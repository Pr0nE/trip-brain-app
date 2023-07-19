import 'auth_state.dart';

abstract class AuthIO {
  void googleLogin();
  void guestLogin();
  void logout();

  void checkLatestSavedUser();

  Stream<AuthState> get out;
}
