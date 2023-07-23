import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/state_stream_builder.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.authIO,
    required this.onSuccessLogin,
    required this.onGuestLoginTapped,
    required this.onSocialLoginTapped,
    required this.onError,
    super.key,
  });

  final AuthIO authIO;
  final void Function(User user) onSuccessLogin;
  final void Function() onGuestLoginTapped;
  final void Function() onSocialLoginTapped;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: StateStreamBuilder<AuthState>(
              stream: authIO.out,
              onState: (authState) {
                if (authState is AuthLoggedInState) {
                  Timer(const Duration(seconds: 1), () {
                    onSuccessLogin(authState.loggedInUser);
                  });
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
                  return Text(
                    context.localization.welcome(
                      authState.loggedInUser.isGuest
                          ? context.localization.guest
                          : authState.loggedInUser.name,
                    ),
                  );
                }

                return _buildLoginButtons();
              }),
        ),
      );

  Widget _buildLoginButtons() => Row(
        children: [
          TextButton.icon(
              onPressed: () {
                onGuestLoginTapped();
                authIO.guestLogin();
              },
              icon: Icon(Icons.person),
              label: Text('Login as guest')),
          TextButton.icon(
              onPressed: () {
                onSocialLoginTapped();
                authIO.googleLogin();
              },
              icon: Icon(Icons.login),
              label: Text('Google Login')),
        ],
      );
}
