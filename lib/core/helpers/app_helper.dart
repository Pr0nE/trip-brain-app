import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/helpers/event_helper.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

void checkAppError({
  required BuildContext context,
  required AppException error,
  VoidCallback? onRetry,
  VoidCallback? onCancel,
}) {
  final dialogManager = context.read<DialogManager>();
  final appModeManager = context.read<AppSettingsCubit>();

  onAppExceptionEvent(error);

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

void onAppUpdate({
  required BuildContext context,
  required UpdateStatus status,
  VoidCallback? onSkipUpdate,
}) {
  final dialogManager = context.read<DialogManager>();

  if (status == UpdateStatus.mandatoryUpdate) {
    dialogManager.showMandatoryUpdateDialog(context);
  } else if (status == UpdateStatus.optionalUpdate && onSkipUpdate != null) {
    dialogManager.showOptionalUpdateDialog(context, onSkipUpdate);
  }
}

extension DialogExtension on DialogManager {
  void showOptionalUpdateDialog(
    BuildContext context,
    VoidCallback onSkipUpdate,
  ) {
    add(
      (context, popDialog) => AlertDialog(
        title: const Text('Update'),
        content: const Text("New update is available"),
        actions: [
          TextButton(
            onPressed: () {
              onSkipUpdate();
              popDialog();
            },
            child: const Text("Skip"),
          ),
          TextButton(
            onPressed: () => StoreRedirect.redirect(),
            child: const Text("Update"),
          ),
        ],
      ),
      onClose: onSkipUpdate,
    );
  }

  void showMandatoryUpdateDialog(BuildContext context) {
    add(
      (context, popDialog) => AlertDialog(
        title: const Text('Important Update'),
        content: const Text("New mandatory update is available"),
        actions: [
          TextButton(
            onPressed: () => StoreRedirect.redirect(),
            child: const Text("Update"),
          ),
        ],
      ),
      dismissible: false,
    );
  }

  void showInsufficientBalanceDialog(BuildContext context) {
    add(
      (context, popDialog) => AlertDialog(
        title: const Text('Error'),
        content: const Text("You don't have enough balance"),
        actions: [
          TextButton(
            onPressed: () => popDialog(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              showBuyBalanceBottomSheet(
                context,
                context.read<PaymentManager>(),
              );
              popDialog();
            },
            child: const Text("Buy balance"),
          ),
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

void showBuyBalanceBottomSheet(
  BuildContext context,
  PaymentManager paymentManager,
) =>
    showModalBottomSheet(
      routeSettings: const RouteSettings(name: 'BalanceSelectorBottomSheet'),
      context: context,
      enableDrag: false,
      builder: (context) => Provider(
        create: (context) => DialogManager(context),
        child: Builder(
          builder: (context) => SuggestionPricesBottomSheet(
            paymentManager: context.read<PaymentManager>(),
            onSuggestionPriceTapped: onBuyBalanceEvent,
            onSuccess: () => context.pop(),
            onError: (error, {retryCallback}) {
              context.pop();
              checkAppError(
                context: context,
                error: error,
                onRetry: retryCallback,
              );
            },
          ),
        ),
      ),
    );
