import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/text_theme/iapp_text_theme.dart';

///Use this to replace textTheme in [ThemeData].
///
///Can be called directly inside an inherited Widget pattern or 
///in othe util functions.
final class BaseTextTheme implements IAppTextTheme {
  BaseTextTheme._singleton();

  static final BaseTextTheme _instance = BaseTextTheme._singleton();

  factory BaseTextTheme() => _instance;

  Color get textColor => PiixColors.infoDefault;

  @override
  TextStyle get displayLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 26.sp,
        height: 30.5.sp / 26.sp,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.2,
        color: textColor,
      );

  @override
  TextStyle get displayMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 24.sp,
        height: 28.2.sp / 24.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle get displaySmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20.sp,
        height: 23.5.sp / 20.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle get headlineLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 18.sp,
        height: 21.1.sp / 18.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle get headlineMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        height: 18.8.sp / 16.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle get headlineSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        height: 16.4.sp / 14.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle get titleLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        height: 18.8.sp / 16.sp,
        letterSpacing: 0.17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.17,
        color: textColor,
      );

  @override
  TextStyle get titleMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        height: 16.4.sp / 14.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle? get titleSmall => null;

  @override
  TextStyle? get labelLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 11.sp,
        height: 12.9.sp / 11.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle get labelMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10.sp,
        height: 11.7.sp / 10.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle? get labelSmall => null;

  @override
  TextStyle? get bodyLarge => null;

  @override
  TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 16.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle? get bodySmall => null;

  @override
  TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
      );
}
