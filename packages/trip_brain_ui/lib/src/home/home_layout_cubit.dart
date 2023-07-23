import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/cubit_plus.dart';

abstract class HomeLayoutState {
  User? get getUser => asOrNull<HomeLayoutUserLoadedState>()?.user;
}

class HomeLayoutInitialState extends HomeLayoutState {}

class HomeLayoutLoadingState extends HomeLayoutUserLoadedState {
  HomeLayoutLoadingState({User? user}) : super(user: user ?? User.empty());
}

class HomeLayoutErrorState extends HomeLayoutState {
  HomeLayoutErrorState(this.error, this.retryCallback);

  final AppException error;
  final void Function() retryCallback;
}

class HomeLayoutUserLoadedState extends HomeLayoutState {
  HomeLayoutUserLoadedState({required this.user});

  final User user;
}

class HomeLayoutCubit extends CubitPlus<HomeLayoutState> {
  HomeLayoutCubit({required this.userFetcher, required this.paymentManager})
      : super(HomeLayoutInitialState());

  final UserFetcher userFetcher;
  final PaymentManager paymentManager;

  Stream<int> get balanceStream => stream
      .whereType<HomeLayoutUserLoadedState>()
      .map((state) => state.user.balance);

  void onLayoutInit() => addSubscription(
        Stream.periodic(const Duration(seconds: 2)).listen((_) {
          if (!isClosed) {
            _fetchUser();
          }
        }),
      );

  void _fetchUser() => userFetcher.fetchUser().on(
        onLoading: () => emit(HomeLayoutLoadingState(user: state.getUser)),
        onData: (user) {
          if (!isClosed) {
            emit(HomeLayoutUserLoadedState(user: user));
          }
        },
        onError: (AppException error) {
          if (!isClosed) {
            emit(HomeLayoutErrorState(error, _fetchUser));
          }
        },
      );
}
