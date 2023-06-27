import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef DialogPopper = void Function();

class DialogManager {
  DialogManager(this.rootContext);

  final BuildContext rootContext;

  OverlayEntry? _activeDialog;

  void add(
    Widget Function(BuildContext, DialogPopper) dialogBuilder,
  ) {
    if (_activeDialog != null) {
      return;
    }

    final overlay = rootContext.findRootAncestorStateOfType<OverlayState>();

    final entry = OverlayEntry(
        builder: (context) => GestureDetector(
              onTap: remove,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
                child: GestureDetector(
                  onTap: () {},
                  child: dialogBuilder(context, () => remove()),
                ),
              ),
            ));

    _activeDialog = entry;
    overlay!.insert(entry);
  }

  remove() {
    _activeDialog?.remove();
    _activeDialog = null;
  }
}

void showAppErrorDialog({
  required BuildContext context,
  required String error,
}) {
  final manager = context.read<DialogManager>();
  manager.add((context, popDialog) => AlertDialog(
        title: const Text('Error'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              popDialog();
            },
            child: const Text("Cancel"),
          ),
        ],
      ));
}
