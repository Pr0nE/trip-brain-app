import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/app_helper.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_data/trip_brain_data.dart';

import 'package:trip_brain_ui/trip_brain_ui.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DialogManager(context),
      child: Builder(
        builder: (context) => AuthLayout(
          authIO: context.read<AuthCubit>(),
          onSuccessLogin: (_) => context.goHome(),
          onError: (error, retryCallback) => checkAppError(
            context: context,
            error: error,
            onRetry: retryCallback,
          ),
        ),
      ),
    );
  }
}
