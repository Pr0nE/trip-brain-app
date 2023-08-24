import 'package:bloc/bloc.dart';

import 'package:trip_brain_domain/trip_brain_domain.dart';

class AuthCubit extends Cubit<AuthState>
    implements AuthIO, AuthInfoProvider, UserFetcher {
  AuthCubit({
    required this.authenticator,
    required this.storage,
  }) : super(AuthLoggedOutState());

  final Authenticator authenticator;
  final AuthStorage storage;

  @override
  void googleLogin() => authenticator.googleLogin().on(
        onLoading: () => emit(AuthLoadingState()),
        onData: (user) {
          storage.saveAccessToken(user.token);
          emit(AuthLoggedInState(user));
        },
        onError: (AppException error) =>
            emit(AuthErrorState(error, googleLogin)),
      );

  @override
  Future<void> checkLatestSavedUser() async {
    emit(AuthLoadingState());

    try {
      final token = await storage.getAccessToken();
      if (token == null) {
        emit(AuthLoggedOutState());

        return;
      }

      final user = await authenticator.accessTokenLogin(token);

      emit(AuthLoggedInState(user));
    } on AppException catch (error) {
      emit(AuthErrorState(error, checkLatestSavedUser));
    }
  }

  @override
  String? get accessToken =>
      state.asOrNull<AuthLoggedInState>()?.loggedInUser.token;

  @override
  Stream<AuthState> get out => stream;

  @override
  Future<User> fetchUser() => authenticator.accessTokenLogin(accessToken ?? '');

  @override
  void guestLogin() {
    final guestUser = User.guest();
    storage.saveAccessToken(guestUser.token);

    emit(AuthLoggedInState(guestUser));
  }

  @override
  void logout() {
    storage.clearAccessToken();

    emit(AuthLoggedOutState());
  }
}
