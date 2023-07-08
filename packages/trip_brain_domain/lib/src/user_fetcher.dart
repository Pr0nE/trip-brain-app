import 'package:trip_brain_domain/src/auth/user.dart';

abstract class UserFetcher {
  Future<User> fetchUser();
}
