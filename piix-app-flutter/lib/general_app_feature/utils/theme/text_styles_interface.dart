import 'package:flutter/material.dart';

@Deprecated('Use instead a class implementing IAppTextTheme')
abstract class AppTextStylesInterface {
  /// H1 reference
  TextStyle? get displayLarge => const TextStyle();

  /// H2 reference
  TextStyle? get displayMedium => const TextStyle();

  /// H3 reference
  TextStyle? get displaySmall => const TextStyle();

  /// H4 reference
  TextStyle? get headlineLarge => const TextStyle();

  /// H5 reference
  TextStyle? get headlineMedium => const TextStyle();

  /// H6 reference
  TextStyle? get headlineSmall => const TextStyle();

  ///PIIX SUBTITLE reference
  TextStyle? get titleLarge => const TextStyle();

  ///Subtitle1 reference
  TextStyle? get titleMedium => const TextStyle();

  ///Subtitle2 reference
  TextStyle? get titleSmall => const TextStyle();

  ///Subtitle3 reference
  TextStyle? get labelLarge => const TextStyle();

  ///Subtitle4 reference
  TextStyle? get labelMedium => const TextStyle();

  ///Body reference
  TextStyle? get labelSmall => const TextStyle();

  ///Value reference
  TextStyle? get bodyLarge => const TextStyle();

  ///Helper text reference
  TextStyle? get bodyMedium => const TextStyle();

  ///Mini Button reference
  TextStyle? get bodySmall => const TextStyle();
}
