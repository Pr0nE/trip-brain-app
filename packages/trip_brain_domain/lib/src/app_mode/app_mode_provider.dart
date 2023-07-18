import 'app_mode.dart';

abstract class AppModeProvider {
  AppMode get currentAppMode;
  Stream<AppMode> get appModeStream;
  bool get isAppOnline => currentAppMode == AppMode.online;
  bool get isAppOffline => currentAppMode == AppMode.offline;
}
