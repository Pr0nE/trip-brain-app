import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:trip_brain_domain/trip_brain_domain.dart';

class AppModeCubit extends Cubit<AppMode> implements AppModeManager {
  AppModeCubit() : super(AppMode.online) {
    appModeStream
        .where((event) => event == AppMode.offline)
        .listen((event) => _listenOnConnectionBack());
  }

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
      await http
          .get(Uri.parse('https://google.com'))
          .timeout(Duration(seconds: 5));
      return true;
    } catch (e) {
      return false;
    }
  }
}
