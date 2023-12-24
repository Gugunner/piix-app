import 'package:flutter/material.dart';

///A simple interface that declares each type 
///of [TextStyle] used for an app [TextTheme].
abstract interface class IAppTextTheme {
  TextStyle? get displayLarge;

  TextStyle? get displayMedium;

  TextStyle? get displaySmall;

  TextStyle? get headlineLarge;

  TextStyle? get headlineMedium;

  TextStyle? get headlineSmall;

  TextStyle? get titleLarge;

  TextStyle? get titleMedium;

  TextStyle? get titleSmall;

  TextStyle? get labelLarge;

  TextStyle? get labelMedium;

  TextStyle? get labelSmall;

  TextStyle? get bodyLarge;

  TextStyle? get bodyMedium;

  TextStyle? get bodySmall;

  TextTheme get textTheme;
}
