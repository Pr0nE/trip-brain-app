import 'package:bloc/bloc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class AppModeCubit extends Cubit<AppMode> implements AppModeManager {
  AppModeCubit({required this.serverPinger}) : super(AppMode.online) {
    appModeStream
        .where((event) => event == AppMode.offline)
        .listen((event) => _listenOnConnectionBack());
  }

  final Pinger serverPinger;

  @override
  void setAppMode(AppMode mode) => emit(mode);

  @override
  Stream<AppMode> get appModeStream => stream;

  @override
  AppMode get currentAppMode => state;

  @override
  bool get isAppOnline => currentAppMode == AppMode.online;

  @override
  bool get isAppOffline => currentAppMode == AppMode.offline;

  Future<void> _listenOnConnectionBack() async {
    final hasConnection = await _hasConnection();
    print('Checked Connection Status: $hasConnection');

    if (hasConnection) {
      setAppMode(AppMode.online);
    } else {
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
}
