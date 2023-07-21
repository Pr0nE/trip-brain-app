import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/event_helper.dart';
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
        BuildContext context, PaymentManager paymentManager) =>
    showModalBottomSheet(
      routeSettings: const RouteSettings(name: 'BalanceSelectorBottomSheet'),
      context: context,
      enableDrag: false,
      builder: (context) => BuyBalanceBottomSheet(
        paymentManager: context.read<PaymentManager>(),
      ),
    );

class BuyBalanceBottomSheet extends StatefulWidget {
  const BuyBalanceBottomSheet({required this.paymentManager, super.key});

  final PaymentManager paymentManager;

  @override
  State<BuyBalanceBottomSheet> createState() => _BuyBalanceBottomSheetState();
}

class _BuyBalanceBottomSheetState extends State<BuyBalanceBottomSheet> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => DialogManager(context),
        child: Builder(
          builder: (context) => BottomSheet(
            builder: (context) => Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Opacity(
                  opacity: isLoading ? 0.1 : 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => onAmountSelected(context, 10),
                        child: Text('10'),
                      ),
                      TextButton(
                        onPressed: () => onAmountSelected(context, 25),
                        child: Text('25'),
                      ),
                      TextButton(
                        onPressed: () => onAmountSelected(context, 50),
                        child: Text('50'),
                      ),
                    ],
                  ),
                ),
                if (isLoading) CircularProgressIndicator()
              ],
            ),
            onClosing: () {},
          ),
        ),
      );

  void onAmountSelected(BuildContext context, int selectedAmount) {
    onBuyBalanceEvent(selectedAmount);

    widget.paymentManager.buyBalance(selectedAmount).on(
          onLoading: () => setState(() => isLoading = true),
          onError: (AppException error) {
            context.pop();
            setState(() => isLoading = false);
            checkAppError(context: context, error: error);
          },
          onData: (result) {
            // TODO: show success message
            context.pop();
            setState(() => isLoading = false);
          },
        );
  }
}
