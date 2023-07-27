import 'package:flutter/material.dart';

extension BuildContextThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get onBackground => Theme.of(this).colorScheme.onBackground;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
