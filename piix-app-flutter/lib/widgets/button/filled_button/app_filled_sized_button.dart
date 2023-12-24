import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/widgets/button/filled_button/app_filled_button.dart';

///Calls specific constructors for the [AppFilledButton]
///with default values unless a new value is passed when
///instantiating the class.
///
///Do not modify any factory constructor just the base constructor.
final class AppFilledSizedButton extends AppFilledButton {
  ///A regular sized button with the
  ///default [FilledButtonThemeData] style.
  AppFilledSizedButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.keepSelected,
    super.loading,
    super.iconData,
    double? minWidth = null,
    double? maxWidth = null,
    double? height = null,
    ButtonStyle? style = null,
  }) : super(
          minWidth: minWidth ?? 48.w,
          maxWidth: maxWidth ?? 288.w,
          height: height ?? 32.h,
          style: style,
        );

  ///A small button with modified [FilledButtonThemeData] style.
  factory AppFilledSizedButton.small({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool keepSelected,
    bool? loading,
    IconData? iconData,
    double? height,
    double? maxWidth,
    double? minWidth,
    ButtonStyle? style,
  }) = _AppFilledSmallButton;
}

///A small button with specific constraints do not try to modify.
final class _AppFilledSmallButton extends AppFilledSizedButton {
  _AppFilledSmallButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.keepSelected,
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
          height: height ?? 21.h,
          minWidth: minWidth ?? 20.w,
          maxWidth: maxWidth ?? 288.w,
          style: style ??
              AppFilledButtonTheme().style?.copyWith(
                    textStyle: MaterialStatePropertyAll<TextStyle?>(
                      AccentTextTheme().labelMedium,
                    ),
                    iconSize: MaterialStatePropertyAll<double>(12.w),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                    ),
                  ),
        );
}
