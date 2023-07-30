import 'package:bloc/bloc.dart';
import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class AppSettingsState {
  AppSettingsState({
    required this.appLanguage,
    required this.appMode,
  });

  final String appLanguage;
  final AppMode appMode;

  AppSettingsState copyWith({
    String? appLanguage,
    AppMode? appMode,
  }) {
    return AppSettingsState(
      appLanguage: appLanguage ?? this.appLanguage,
      appMode: appMode ?? this.appMode,
    );
  }
}

class AppSettingsCubit extends Cubit<AppSettingsState>
    implements AppSettingsManager {
  AppSettingsCubit({required this.serverPinger, required this.apiClient})
      : super(AppSettingsState(appLanguage: 'en', appMode: AppMode.online)) {
    appModeStream
        .where((event) => event == AppMode.offline)
        .listen((event) => _listenOnConnectionBack());
  }

  final Pinger serverPinger;
  final APIClient apiClient;

  @override
  void setAppMode(AppMode mode) => emit(state.copyWith(appMode: mode));

  @override
  Stream<AppMode> get appModeStream =>
      stream.map((event) => event.appMode).distinct();

  @override
  AppMode get currentAppMode => state.appMode;

  @override
  bool get isAppOnline => currentAppMode == AppMode.online;

  @override
  bool get isAppOffline => currentAppMode == AppMode.offline;

  Future<void> _listenOnConnectionBack() async {
    final hasConnection = await _hasConnection();

    if (hasConnection) {
      setAppMode(AppMode.online);
    } else {
      apiClient.reconnect();
      await Future.delayed(Duration(seconds: 1));
      _listenOnConnectionBack();
    }
  }

  Future<bool> _hasConnection() async {
    try {
      final result = await serverPinger.ping().timeout(Duration(seconds: 5));

      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  String get appLanguage => state.appLanguage;

  @override
  void setAppLanguage(String language) =>
      emit(state.copyWith(appLanguage: language));
}
