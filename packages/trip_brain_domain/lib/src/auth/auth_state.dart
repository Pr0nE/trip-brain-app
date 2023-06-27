import 'package:trip_brain_domain/trip_brain_domain.dart';

abstract class AuthState {}

class AuthLoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {
  AuthLoggedInState(this.loggedInUser);

  final User loggedInUser;
}
