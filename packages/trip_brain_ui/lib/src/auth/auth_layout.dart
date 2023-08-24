import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/stream_consumer.dart';
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
          child: StreamConsumer<AuthState>(
              stream: authIO.out,
              listener: (authState) {
                if (authState is AuthLoggedInState) {
                  Timer(const Duration(seconds: 1), () {
                    onSuccessLogin(authState.loggedInUser);
                  });
                }
                if (authState is AuthErrorState) {
                  onError(authState.error, authState.retryCallback);
                }
              },
              builder: (BuildContext context, AuthState? authState) {
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

                return _buildLoginButtons(context);
              }),
        ),
      );

  Widget _buildLoginButtons(BuildContext context) => Row(
        children: [
          TextButton.icon(
              onPressed: () {
                onGuestLoginTapped();
                authIO.guestLogin();
              },
              icon: const Icon(Icons.person),
              label: Text(context.localization.guestLogin)),
          TextButton.icon(
              onPressed: () {
                onSocialLoginTapped();
                authIO.googleLogin();
              },
              icon: const Icon(Icons.login),
              label: Text(context.localization.googleLogin)),
        ],
      );
}
