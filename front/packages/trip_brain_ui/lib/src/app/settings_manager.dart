import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/stream_listener.dart';

class AppManager extends StatefulWidget {
  const AppManager(
      {required this.appSettingsManager, required this.child, super.key});

  final Widget child;
  final AppSettingsManager appSettingsManager;

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  @override
  void didChangeDependencies() {
    widget.appSettingsManager
        .setAppLanguage(Localizations.localeOf(context).languageCode);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamListener<AppMode>(
      stream: widget.appSettingsManager.appModeStream,
      onState: (appMode) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('App mode is now: ${appMode.name}'))),
      child: widget.child,
    );
  }
}
