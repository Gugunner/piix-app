import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';

@Deprecated('No longer in use in 4.0')
class InputStyleUtilsDeprecated {
  static TextStyle? errorStyle(BuildContext context) =>
      context.textTheme?.labelMedium?.copyWith(
        color: PiixColors.error,
      );

  static TextStyle? helperStyle(BuildContext context,
          {required bool hasFocus, required bool isEditable}) =>
      context.textTheme?.labelMedium?.copyWith(
        color: hasFocus
            ? PiixColors.insurance
            : isEditable
                ? PiixColors.infoDefault
                : PiixColors.secondary,
      );

  static TextStyle? labelStyle(
    BuildContext context, {
    required bool hasFocus,
    required bool isEditable,
    String? errorText,
  }) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: errorText.isNotNullEmpty
            ? PiixColors.errorText
            : hasFocus
                ? PiixColors.insurance
                : isEditable
                    ? PiixColors.infoDefault
                    : PiixColors.secondary,
      );

  static TextStyle? floatingLabelStyle(
    BuildContext context, {
    String? errorText,
    required bool hasFocus,
    required bool isEditable,
  }) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: errorText.isNotNullEmpty
            ? PiixColors.error
            : hasFocus
                ? PiixColors.insurance
                : isEditable
                    ? PiixColors.infoDefault
                    : PiixColors.secondary,
      );

  static TextStyle? style(BuildContext context, {required bool isEditable}) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: isEditable ? PiixColors.contrast : PiixColors.secondary,
      );
}
