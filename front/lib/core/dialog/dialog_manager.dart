import 'package:flutter/material.dart';

typedef DialogPopper = void Function();

class DialogManager {
  DialogManager(this.rootContext);

  final BuildContext rootContext;

  OverlayEntry? _activeDialog;

  void add(
    Widget Function(BuildContext, DialogPopper) dialogBuilder, {
    bool dismissible = true,
    VoidCallback? onClose,
  }) {
    if (_activeDialog != null) {
      return;
    }

    final overlay = Overlay.maybeOf(rootContext);

    final entry = OverlayEntry(
        builder: (context) => WillPopScope(
              onWillPop: () => Future.value(dismissible),
              child: GestureDetector(
                onTap: dismissible ? () => remove(onClose: onClose) : null,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                  height: double.infinity,
                  child: dialogBuilder(context, () => remove()),
                ),
              ),
            ));

    _activeDialog = entry;
    overlay!.insert(entry);
  }

  void remove({VoidCallback? onClose}) {
    _activeDialog?.remove();
    _activeDialog = null;
    onClose?.call();
  }
}
