import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///Calls specific constructors for the [AppTextButton]
///with default values unless a new value is passed when
///instantiating the class.
///
///Do not modify any factory constructor just the base constructor.
final class AppTextSizedButton extends AppTextButton {
  AppTextSizedButton({
    super.key,
    required super.onPressed,
    super.keepSelected,
    super.loading,
    super.iconData,
    required String text,
    bool upperCase = true,
    double? minWidth = null,
    double? maxWidth = null,
    double? height = null,
    ButtonStyle? style = null,
  }) : super(
          text: upperCase ? text.toUpperCase() : text,
          minWidth: minWidth ?? 26.w,
          maxWidth: maxWidth ?? 288.w,
          height: height ?? 30.h,
          style: style,
        );

  ///A button with modified [OutlinedButtonThemeData] style
  ///with a titleMedium textStyle.
  factory AppTextSizedButton.title({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool keepSelected,
    bool upperCase,
    bool? loading,
    IconData? iconData,
    double? height,
    double? maxWidth,
    double? minWidth,
    ButtonStyle? style,
  }) = _AppTextTitleButton;

  ///A button with modified [OutlinedButtonThemeData] style.
  ///with a headlineLarge textStyle.
  factory AppTextSizedButton.headline({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool keepSelected,
    bool upperCase,
    bool? loading,
    IconData? iconData,
    double? height,
    double? maxWidth,
    double? minWidth,
    ButtonStyle? style,
  }) = _AppTextHeadlineButton;
}

///A title medium textStyle button with specific constraints do
///not try to modify.
final class _AppTextTitleButton extends AppTextSizedButton {
  _AppTextTitleButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.keepSelected,
    super.upperCase = false,
    super.loading,
    super.iconData,
    double? height = null,
    double? maxWidth = null,
    double? minWidth = null,
    ButtonStyle? style,
  })  : assert(height == null &&
            maxWidth == null &&
            minWidth == null &&
            style == null),
        super(
          height: height ?? 26.h,
          minWidth: minWidth ?? 48.w,
          maxWidth: maxWidth ?? 288.w,
          style: style ??
              AppTextButtonTheme().style?.copyWith(
                    textStyle: MaterialStatePropertyAll<TextStyle?>(
                      PrimaryTextTheme().titleSmall,
                    ),
                    iconSize: MaterialStatePropertyAll<double>(12.w),
                  ),
        );
}

///A headline large textStyle button with specific constraints do
///not try to modify.
final class _AppTextHeadlineButton extends AppTextSizedButton {
  _AppTextHeadlineButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.keepSelected,
    super.upperCase = false,
    super.loading,
    super.iconData,
    double? height = null,
    double? maxWidth = null,
    double? minWidth = null,
    ButtonStyle? style,
  })  : assert(height == null &&
            maxWidth == null &&
            minWidth == null &&
            style == null),
        super(
          height: height ?? 30.h,
          minWidth: minWidth ?? 48.w,
          maxWidth: maxWidth ?? 288.w,
          style: style ??
              AppTextButtonTheme().style?.copyWith(
                    textStyle: MaterialStatePropertyAll<TextStyle?>(
                      AccentTextTheme().headlineLarge,
                    ),
                  ),
        );
}
