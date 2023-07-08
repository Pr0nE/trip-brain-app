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

  void onLayoutInit() => _fetchUser();
  Future<void> onBuyBalance(int amount) async {
    final isSuccess = await paymentManager.buyBalance(amount);

    if (isSuccess) {
      await Future.delayed(const Duration(seconds: 1));
      _fetchUser();
    }
  }

  Future<void> _fetchUser() async {
    emit(HomeLayoutLoadingState());

    final user = await userFetcher.fetchUser();

    emit(HomeLayoutUserLoadedState(user: user));
  }
}
