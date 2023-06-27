import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/state_stream_listener.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({
    required this.authIO,
    required this.onExistUser,
    required this.onNewUser,
    super.key,
  });

  final AuthIO authIO;
  final void Function(User user) onExistUser;
  final VoidCallback onNewUser;

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
      widget.onExistUser(state.loggedInUser);
    }

    if (state is AuthLoggedOutState) {
      widget.onNewUser();
    }
  }
}
