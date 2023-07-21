enum AppMode { online, offline }

abstract class AppSettingsProvider {
  String get appLanguage;
  AppMode get currentAppMode;
  Stream<AppMode> get appModeStream;
  bool get isAppOnline => currentAppMode == AppMode.online;
  bool get isAppOffline => currentAppMode == AppMode.offline;
}

abstract class AppSettingsManager implements AppSettingsProvider {
  void setAppMode(AppMode mode);
  void setAppLanguage(String language);
}
