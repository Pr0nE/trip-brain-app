import 'package:flutter/material.dart';
import 'package:trip_brain_ui/generated/l10n.dart';

extension LocalizationExtension on BuildContext {
  AppLocalization get localization => AppLocalization.current;
}
