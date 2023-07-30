import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/state_stream_listener.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({
    required this.authIO,
    required this.updateStatusFetcher,
    required this.onUserExist,
    required this.onNewUser,
    required this.onUpdate,
    required this.onError,
    super.key,
  });

  final AuthIO authIO;
  final UpdateStatusFetcher updateStatusFetcher;
  final void Function(User user) onUserExist;
  final void Function(UpdateStatus status, {VoidCallback? onSkipUpdate})
      onUpdate;
  final VoidCallback onNewUser;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  State<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<SplashLayout> {
  @override
  void initState() {
    _onInit();

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
              Text('Just a moment...'),
              SizedBox(height: 16),
              CircularProgressIndicator(strokeWidth: 3),
            ],
          )),
        ),
      );

  void _onInit() async {
    try {
      final updateStatus =
          await widget.updateStatusFetcher.getAppUpdateStatus();

      switch (updateStatus) {
        case UpdateStatus.noUpdates:
          widget.authIO.checkLatestSavedUser();
          break;
        case UpdateStatus.mandatoryUpdate:
          widget.onUpdate(UpdateStatus.mandatoryUpdate);
          break;
        case UpdateStatus.optionalUpdate:
          widget.onUpdate(
            UpdateStatus.optionalUpdate,
            onSkipUpdate: widget.authIO.checkLatestSavedUser,
          );
          break;
      }
    } on AppException catch (error) {
      widget.onError(error, widget.authIO.checkLatestSavedUser);
    }
  }

  void onAuthState(AuthState state) {
    if (state is AuthLoggedInState) {
      widget.onUserExist(state.loggedInUser);
    }

    if (state is AuthErrorState) {
      final error = state.error;

      if (error.type == AppErrorType.needAuth) {
        widget.authIO.guestLogin();
        widget.onNewUser();

        return;
      }

      widget.onError(error, state.retryCallback);
    }

    if (state is AuthLoggedOutState) {
      widget.authIO.guestLogin();
      widget.onNewUser();
    }
  }
}
