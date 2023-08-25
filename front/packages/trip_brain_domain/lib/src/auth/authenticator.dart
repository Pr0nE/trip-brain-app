import 'package:trip_brain_domain/trip_brain_domain.dart';

abstract class Authenticator {
  Future<User> googleLogin();

  Future<User> accessTokenLogin(String token);
}
