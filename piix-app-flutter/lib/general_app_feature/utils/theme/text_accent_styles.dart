import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
@Deprecated('Use instead AccentTextTheme')
class TextAccentStyles extends TextTheme {
  const TextAccentStyles._();
  static const TextAccentStyles instance = TextAccentStyles._();

  @override
  TextStyle? get displayLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20.sp,
        height: 23.5.sp / 20.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get displayMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        height: 18.1.sp / 16.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get displaySmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        height: 18.1.sp / 16.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get headlineLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        height: 16.4.sp / 14.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.4,
        color: PiixColors.primary,
      );

  @override
  TextStyle? get headlineMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        height: 16.4.sp / 14.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.4,
        color: PiixColors.highlight,
      );

  @override
  TextStyle? get headlineSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: PiixColors.active,
      );

  @override
  TextStyle? get titleLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get titleMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get titleSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: PiixColors.highlight,
      );

  @override
  TextStyle? get labelLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10.sp,
        height: 11.7.sp / 10.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.4,
        color: PiixColors.primary,
      );

  @override
  TextStyle? get labelMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 11.sp,
        height: 12.9.sp / 11.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get labelSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10.sp,
        height: 11.7.sp / 10.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.4,
        fontStyle: FontStyle.italic,
        color: PiixColors.primary,
      );

  @override
  TextStyle? get bodyLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: PiixColors.primary,
      );

  @override
  TextStyle? get bodyMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10.sp,
        height: 11.7.sp / 10.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.1,
        color: PiixColors.space,
      );

  @override
  TextStyle? get bodySmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 9.sp,
        height: 10.6.sp / 9.sp,
        letterSpacing: -0.09,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.1,
        fontStyle: FontStyle.italic,
        color: PiixColors.highlight,
      );
}
