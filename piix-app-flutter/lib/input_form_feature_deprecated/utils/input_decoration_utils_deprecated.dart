import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('No longer in use in 4.0')
class InputDecorationUtilsDeprecated {
  static InputBorder focusedBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: PiixColors.insurance,
    ),
  );

  static InputBorder errorBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: PiixColors.error,
    ),
  );

  static InputBorder focusedErrorBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: PiixColors.error,
    ),
  );

  static InputBorder enabledBorder(bool hasFocus) => UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasFocus ? PiixColors.insurance : PiixColors.infoDefault,
        ),
      );

  static InputBorder border(bool hasFocus) => UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasFocus ? PiixColors.insurance : PiixColors.infoDefault,
        ),
      );
}
