import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A default [ButtonThemeData] for the [TextButton] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppTextButtonTheme extends TextButtonThemeData {
  AppTextButtonTheme()
      : super(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) {
                final titleMedium = PrimaryTextTheme().titleMedium;
                if (states.contains(MaterialState.disabled)) {
                  return titleMedium.copyWith(
                    color: PiixColors.inactive,
                  );
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return titleMedium.copyWith(
                    color: PiixColors.primary,
                  );
                }
                return titleMedium.copyWith(
                  color: PiixColors.active,
                );
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return PiixColors.inactive;
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return PiixColors.primary;
                }
                return PiixColors.active;
              },
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.zero,
            ),
            minimumSize: MaterialStatePropertyAll(
              Size(8.w, 32.h),
            ),
            iconSize: MaterialStatePropertyAll<double>(16.w),
            iconColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return PiixColors.inactive;
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return PiixColors.primary;
                }
                return PiixColors.active;
              },
            ),
          ),
        );
}
