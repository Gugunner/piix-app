import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/color_utils.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A default [ButtonThemeData] for the [OutlinedButton] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppOutlinedButtonTheme extends OutlinedButtonThemeData {
  AppOutlinedButtonTheme()
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
            backgroundColor: MaterialStateProperty.all(PiixColors.space),
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
            overlayColor: MaterialStatePropertyAll(
                ColorUtils.lighten(PiixColors.primary, 0.6)),
            elevation: MaterialStateProperty.all(3),
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 8.h,
              ),
            ),
            minimumSize: MaterialStatePropertyAll(
              Size(8.w, 32.h),
            ),
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
