import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/text_styles_interface.dart';

@Deprecated('Use instead PrimaryTextTheme')
class TextPrimaryStyles implements AppTextStylesInterface {
  TextPrimaryStyles._();
  static final TextPrimaryStyles instance = TextPrimaryStyles._();

  final textColor = PiixColors.infoDefault;

  @override
  TextStyle? get displayLarge {
    try {
      throw UnimplementedError(
          'TextTheme Primary => displayLarge Style is not implemented');
    } catch (e) {
      return const TextStyle();
    }
  }

  @override
  TextStyle? get displayMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        height: 18.8.sp / 16.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle? get displaySmall {
    try {
      throw UnimplementedError(
          'TextTheme Primary => displaySmall Style is not implemented');
    } catch (e) {
      return const TextStyle();
    }
  }

  @override
  TextStyle? get headlineLarge {
    try {
      throw UnimplementedError(
          'TextTheme Primary => headlineLarge Style is not implemented');
    } catch (e) {
      return const TextStyle();
    }
  }

  @override
  TextStyle? get headlineMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        height: 18.8.sp / 16.sp,
        letterSpacing: 0.17,
        fontWeight: FontWeight.w500,
        wordSpacing: 0.17,
        color: textColor,
      );

  @override
  TextStyle? get headlineSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        height: 16.4.sp / 14.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle? get titleLarge {
    try {
      throw UnimplementedError(
          'TextTheme Primary => titleLarge Style is not implemented');
    } catch (e) {
      return const TextStyle();
    }
  }

  @override
  TextStyle? get titleMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.1,
        color: textColor,
      );

  @override
  TextStyle? get titleSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle? get labelLarge => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle? get labelMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10.sp,
        height: 11.7.sp / 10.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        wordSpacing: 0.4,
        color: textColor,
      );

  @override
  TextStyle? get labelSmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10.sp,
        height: 11.7.sp / 10.sp,
        letterSpacing: -0.4,
        fontWeight: FontWeight.w600,
        wordSpacing: -0.4,
        color: textColor,
      );

  @override
  TextStyle? get bodyLarge {
    try {
      throw UnimplementedError(
          'TextTheme Primary => bodyLarge Style is not implemented');
    } catch (e) {
      return const TextStyle();
    }
  }

  @override
  TextStyle? get bodyMedium => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        height: 14.1.sp / 12.sp,
        letterSpacing: 0,
        fontWeight: FontWeight.w300,
        wordSpacing: 0,
        color: textColor,
      );

  @override
  TextStyle? get bodySmall {
    try {
      throw UnimplementedError(
          'TextTheme Primary => bodySmall Style is not implemented');
    } catch (e) {
      return const TextStyle();
    }
  }
}
