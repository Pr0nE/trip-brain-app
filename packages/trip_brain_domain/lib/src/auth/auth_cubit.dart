import 'package:bloc/bloc.dart';

import 'package:trip_brain_domain/src/auth/auth_info_provider.dart';
import 'package:trip_brain_domain/src/auth/authenticator.dart';
import 'package:trip_brain_domain/src/auth/user.dart';
import 'package:trip_brain_domain/src/object_extensions.dart';
import 'package:trip_brain_domain/src/user_fetcher.dart';

import 'auth_io.dart';
import 'auth_state.dart';
import 'auth_storage.dart';

class AuthCubit extends Cubit<AuthState>
    implements AuthIO, AuthInfoProvider, UserFetcher {
  AuthCubit({
    required this.authenticator,
    required this.storage,
  }) : super(AuthLoggedOutState());

  final Authenticator authenticator;
  final AuthStorage storage;

  @override
  Future<void> googleLogin() async {
    emit(AuthLoadingState());

    try {
      final user = await authenticator.googleLogin();

      storage.saveAccessToken(user.token);

      emit(AuthLoggedInState(user));
    } catch (e) {
      emit(AuthLoggedOutState());
      // TODO: error state
    }
  }

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
    } catch (e) {
      emit(AuthLoggedOutState());
      // TODO: error state
    }
  }

  @override
  String? get accessToken =>
      state.asOrNull<AuthLoggedInState>()?.loggedInUser.token;

  @override
  Stream<AuthState> get out => stream;

  @override
  Future<User> fetchUser() => authenticator.accessTokenLogin(accessToken ?? '');
}
