import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A default [RadioThemeData] for the [Radio] with
///pre defined [MaterialStateProperty] values.
///
///Use copyWith with the style property to ovewrite any value.
final class AppRadioButtonTheme extends RadioThemeData {
  AppRadioButtonTheme()
      : super(fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.disabled)) {
            return PiixColors.inactive;
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.selected)) {
            return PiixColors.active;
          }
          return PiixColors.active;
        }));
}
