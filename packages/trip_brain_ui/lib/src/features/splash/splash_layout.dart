import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/state_stream_listener.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({
    required this.authIO,
    required this.onUserExist,
    required this.onNewUser,
    required this.onError,
    super.key,
  });

  final AuthIO authIO;
  final void Function(User user) onUserExist;
  final VoidCallback onNewUser;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  State<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<SplashLayout> {
  @override
  void initState() {
    widget.authIO.checkLatestSavedUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => StateStreamListener<AuthState>(
        stream: widget.authIO.out,
        onState: onAuthState,
        child: const Scaffold(
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome To App'),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          )),
        ),
      );

  void onAuthState(AuthState state) {
    if (state is AuthLoggedInState) {
      widget.onUserExist(state.loggedInUser);
    }

    if (state is AuthErrorState) {
      final error = state.error;

      if (error.type == AppErrorType.expiredToken) {
        widget.onNewUser();

        return;
      }

      widget.onError(error, state.retryCallback);
    }
  }
}
