import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A predefined [InputDecoration] for the app inputs.
final class GeneralFormInputDecoration extends InputDecoration {
  GeneralFormInputDecoration({
    super.enabled,
    super.errorText,
    super.helperText,
    super.labelText,
    super.errorMaxLines,
    super.helperMaxLines,
    super.suffixIcon,
    super.suffixIconConstraints,
    super.suffix,
    super.prefix,
    super.contentPadding,
  }) : super(
          //TODO: Test if theme InputDecorationTheme can be used instead of super in this constructor
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: PiixColors.infoDefault, width: 1),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: PiixColors.error, width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: PiixColors.active, width: 1),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: PiixColors.error, width: 1),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle:
              BaseTextTheme().labelMedium.copyWith(color: PiixColors.error),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
            var color = PiixColors.infoDefault;
            if (states.contains(MaterialState.error)) {
              color = PiixColors.error;
            } else if (states.contains(MaterialState.disabled)) {
              color = PiixColors.secondary;
            } else if (states.contains(MaterialState.focused)) {
              color = PiixColors.active;
            }
            return BaseTextTheme().bodyMedium.copyWith(color: color);
          }),
          helperStyle: MaterialStateTextStyle.resolveWith((states) {
            var color = PiixColors.infoDefault;
            if (states.contains(MaterialState.error)) {
              color = PiixColors.error;
            } else if (states.contains(MaterialState.focused)) {
              color = PiixColors.active;
            }
            return BaseTextTheme().labelMedium.copyWith(color: color);
          }),
          labelStyle: MaterialStateTextStyle.resolveWith((states) {
            var color = PiixColors.infoDefault;
            if (states.contains(MaterialState.error)) {
              color = PiixColors.error;
            } else if (states.contains(MaterialState.disabled)) {
              color = PiixColors.secondary;
            } else if (states.contains(MaterialState.focused)) {
              color = PiixColors.active;
            }
            return BaseTextTheme().titleMedium.copyWith(color: color);
          }),
          suffixIconColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.error)) {
                return PiixColors.error;
              }
              if (states.contains(MaterialState.focused)) {
                return PiixColors.active;
              }
              return PiixColors.infoDefault;
            },
          ),
        );
}
