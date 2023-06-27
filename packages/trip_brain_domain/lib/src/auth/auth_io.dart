import 'auth_state.dart';

abstract class AuthIO {
  void googleLogin();

  void checkLatestSavedUser();

  Stream<AuthState> get out;
}
