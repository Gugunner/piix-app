import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/color_utils.dart';

///A default [SwitchThemeData] for the [Switch] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppSwitchButtonTheme extends SwitchThemeData {
  AppSwitchButtonTheme()
      : super(
            trackColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return PiixColors.stormy;
                            }
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.hovered) ||
                                states.contains(MaterialState.selected)) {
                              return ColorUtils.lighten(PiixColors.active, 0.2);
                            }
                            return PiixColors.secondaryLight;
                          }),
                          thumbColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.hovered) ||
                                states.contains(MaterialState.selected)) {
                              return PiixColors.active;
                            }
                            return PiixColors.sky;
                          }),
                          trackOutlineColor: const MaterialStatePropertyAll(
                            Colors.transparent,
                          ));
}
