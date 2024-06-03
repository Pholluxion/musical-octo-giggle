import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  TextStyle? get titleLarge => theme.textTheme.titleLarge;
  TextStyle? get titleMedium => theme.textTheme.titleMedium;
  TextStyle? get titleSmall => theme.textTheme.titleSmall;
  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;
  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;
  TextStyle? get bodySmall => theme.textTheme.bodySmall;
  TextStyle? get labelLarge => theme.textTheme.labelLarge;
  TextStyle? get labelMedium => theme.textTheme.labelMedium;
  TextStyle? get labelSmall => theme.textTheme.labelSmall;
  TextStyle? get displayLarge => theme.textTheme.displayLarge;
  TextStyle? get displayMedium => theme.textTheme.displayMedium;
  TextStyle? get displaySmall => theme.textTheme.displaySmall;
  TextStyle? get headlineLarge => theme.textTheme.headlineLarge;
  TextStyle? get headlineMedium => theme.textTheme.headlineMedium;
  TextStyle? get headlineSmall => theme.textTheme.headlineSmall;

  Color get primaryColor => theme.primaryColor;
  Color get secondaryColor => theme.colorScheme.secondary;

  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
