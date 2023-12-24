import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A default [ButtonThemeData] for the [ElevatedButtonTheme] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppElevatedButtonTheme extends ElevatedButtonThemeData {
  AppElevatedButtonTheme()
      : super(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              PrimaryTextTheme().titleMedium?.copyWith(color: PiixColors.space),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
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
            foregroundColor: const MaterialStatePropertyAll(PiixColors.space),
            overlayColor: const MaterialStatePropertyAll(PiixColors.primary),
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 8.h,
              ),
            ),
            minimumSize: MaterialStatePropertyAll(
              Size(8.w, 32.h),
            ),
            iconColor: const MaterialStatePropertyAll(PiixColors.space),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return const BorderSide(
                    color: PiixColors.inactive,
                  );
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return const BorderSide(color: PiixColors.primary);
                }
                return const BorderSide(color: PiixColors.active);
              },
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
          ),
        );
}
