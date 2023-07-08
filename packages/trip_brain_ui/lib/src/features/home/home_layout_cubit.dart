import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/cubit_plus.dart';

abstract class HomeLayoutState {}

class HomeLayoutInitialState extends HomeLayoutState {}

class HomeLayoutLoadingState extends HomeLayoutState {}

class HomeLayoutErrorState extends HomeLayoutState {}

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
        Stream.periodic(const Duration(seconds: 2)).listen((_) => _fetchUser()),
      );

  Future<void> onBuyBalance(int amount) => paymentManager.buyBalance(amount);

  Future<void> _fetchUser() async {
    emit(HomeLayoutLoadingState());

    final user = await userFetcher.fetchUser();

    emit(HomeLayoutUserLoadedState(user: user));
  }
}
