import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';


///A default [CheckboxThemeData] for the [Checkbox] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppCheckboxTheme extends CheckboxThemeData {
  AppCheckboxTheme()
      : super(
            fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.inactive;
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return PiixColors.active;
              }
              return PiixColors.active;
            }),
            checkColor: const MaterialStatePropertyAll<Color>(PiixColors.space),
            side: MaterialStateBorderSide.resolveWith((states) {
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
            }));
}
