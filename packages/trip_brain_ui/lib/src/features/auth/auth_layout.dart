import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/state_stream_builder.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({
    required this.authIO,
    required this.onSuccessLogin,
    super.key,
  });

  final AuthIO authIO;
  final void Function(User user) onSuccessLogin;

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  Future<User>? authenticatedUserFuture;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: StateStreamBuilder<AuthState>(
              stream: widget.authIO.out,
              onState: (authState) {
                if (authState is AuthLoggedInState) {
                  widget.onSuccessLogin(authState.loggedInUser);
                }
              },
              onStateBuilder: (BuildContext context, AuthState? authState) {
                if (authState is AuthLoadingState) {
                  return const CircularProgressIndicator();
                }

                if (authState is AuthLoggedInState) {
                  return Text('Welcome ${authState.loggedInUser.name}');
                }

                return _buildLoginButton();
              }),
        ),
      );

  Widget _buildLoginButton() => IconButton(
        onPressed: widget.authIO.googleLogin,
        icon: const Icon(Icons.login_outlined),
      );
}
