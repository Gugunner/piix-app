import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/text_theme/primary_text_theme.dart';

///A default [ButtonThemeData] for the [FilledButton] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppFilledButtonTheme extends FilledButtonThemeData {
  AppFilledButtonTheme()
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
                  color: PiixColors.active,
                );
              }
              return titleMedium.copyWith(
                color: PiixColors.space,
              );
            },
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
          overlayColor: MaterialStateProperty.resolveWith<Color>(
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
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(8.w, 32.h),
          ),
          iconSize: MaterialStatePropertyAll(16.w),
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
        ));
}
