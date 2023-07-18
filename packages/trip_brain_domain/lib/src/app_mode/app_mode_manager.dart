import 'app_mode.dart';
import 'app_mode_provider.dart';

abstract class AppModeManager implements AppModeProvider {
  void setAppMode(AppMode mode);
}
