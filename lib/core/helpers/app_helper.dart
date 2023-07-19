import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import '../dialog/dialog_manager.dart';

void checkAppError({
  required BuildContext context,
  required AppException error,
  VoidCallback? onRetry,
  VoidCallback? onCancel,
}) {
  final dialogManager = context.read<DialogManager>();
  final appModeManager = context.read<AppModeCubit>();

  switch (error.type) {
    case AppErrorType.payment:
      dialogManager.showGeneralErrorDialog(
        context: context,
        errorMessage: error.toString(),
        onCancel: () {},
        onRetry: onRetry,
      );
      break;
    case AppErrorType.insufficientBalance:
      dialogManager.showInsufficientBalanceDialog(context);
      break;
    case AppErrorType.needAuth:
      dialogManager.showNeedAuthDialog(context);
      break;
    case AppErrorType.needNetwork:
      dialogManager.showNeedNetworkDialog(context);
      break;
    case AppErrorType.network:
      appModeManager.setAppMode(AppMode.offline);
      onRetry?.call();
      break;
    case AppErrorType.unknown:
      dialogManager.showGeneralErrorDialog(
        context: context,
        errorMessage: error.toString(),
        onCancel: onCancel,
        onRetry: onRetry,
      );
      break;
  }
}

extension DialogExtension on DialogManager {
  void showInsufficientBalanceDialog(BuildContext context) {
    add(
      (context, popDialog) => AlertDialog(
        title: const Text('Error'),
        content: Text("You don't have enough balance"),
        actions: [
          TextButton(
            onPressed: () => popDialog(),
            child: const Text("Cancel"),
          ),
          // TextButton( //TODO: buy from anywehre in app
          //   onPressed: () => ,
          //   child: const Text("Buy"),
          // ),
        ],
      ),
      dismissible: false,
    );
  }

  void showNeedNetworkDialog(BuildContext context) {
    add(
      (context, popDialog) => AlertDialog(
        title: const Text('Error'),
        content: Text('You need internet connection to continue'),
        actions: [
          TextButton(
            onPressed: () => popDialog(),
            child: const Text("Cancel"),
          ),
        ],
      ),
      dismissible: false,
    );
  }

  void showNeedAuthDialog(BuildContext context) {
    add(
      (context, popDialog) => AlertDialog(
        title: const Text('Error'),
        content: Text('Please login to continue'),
        actions: [
          TextButton(
            onPressed: () {
              popDialog();
              context.goAuth();
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  void showGeneralErrorDialog({
    required BuildContext context,
    required String errorMessage,
    VoidCallback? onRetry,
    VoidCallback? onCancel,
  }) =>
      add(
        (context, popDialog) => AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            if (onCancel != null)
              TextButton(
                onPressed: () {
                  popDialog();
                },
                child: const Text("Cancel"),
              ),
            if (onRetry != null)
              TextButton(
                onPressed: () {
                  onRetry();
                  popDialog();
                },
                child: const Text("Retry"),
              ),
          ],
        ),
      );
}
