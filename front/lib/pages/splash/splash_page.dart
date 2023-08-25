import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/app_helper.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => DialogManager(context),
        child: Builder(
          builder: (context) => SplashLayout(
            updateStatusFetcher: context.read<GeneralRepository>(),
            onUpdate: (status, {onSkipUpdate}) => onAppUpdate(
                context: context, status: status, onSkipUpdate: onSkipUpdate),
            authIO: context.read<AuthCubit>(),
            onUserExist: (user) => context.goHome(),
            onNewUser: () => context.goHome(),
            onError: (error, retryCallback) => checkAppError(
              context: context,
              error: error,
              onRetry: retryCallback,
            ),
          ),
        ),
      );
}
