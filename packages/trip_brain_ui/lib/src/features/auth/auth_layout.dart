import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/state_stream_builder.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.authIO,
    required this.onSuccessLogin,
    required this.onError,
    super.key,
  });

  final AuthIO authIO;
  final void Function(User user) onSuccessLogin;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: StateStreamBuilder<AuthState>(
              stream: authIO.out,
              onState: (authState) {
                if (authState is AuthLoggedInState) {
                  onSuccessLogin(authState.loggedInUser);
                }
                if (authState is AuthErrorState) {
                  onError(authState.error, authState.retryCallback);
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
        onPressed: authIO.googleLogin,
        icon: const Icon(Icons.login_outlined),
      );
}
