import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///The class to extend from  [DropdownButtonFormField] inside the App.
///
///This class is a subclass of [DropdownButtonFormField] with a predefined
///[InputDecoration and properties used for the app.
base class AppDropdownFormField extends DropdownButtonFormField {
  AppDropdownFormField({
    super.key,
    required super.items,
    required super.onChanged,
    super.selectedItemBuilder,
    super.value,
    super.hint,
    super.disabledHint,
    super.onTap,
    super.elevation,
    super.icon,
    super.iconDisabledColor,
    super.iconEnabledColor,
    super.iconSize,
    super.isDense,
    super.isExpanded,
    super.itemHeight,
    super.focusColor,
    super.focusNode,
    super.autofocus,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.menuMaxHeight,
    super.enableFeedback,
    super.alignment,
    super.borderRadius,
    super.padding,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.labelText,
    this.errorMaxLines,
    this.helperMaxLines,
    this.suffix,
    this.prefix,
    this.contentPadding,
  })  : assert(
          suffix == null || icon == null,
        ),
        super(
          decoration: InputDecoration(
            helperText: helperText,
            labelText: labelText,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            helperMaxLines: helperMaxLines,
            enabled: enabled,
            suffix: suffix,
            prefix: prefix,
            suffixIcon: icon,
            suffixIconConstraints: BoxConstraints(
              maxWidth: 16.w,
              maxHeight: 16.w,
            ),
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
                BaseTextTheme().labelMedium.copyWith(color: Colors.transparent),
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
            contentPadding: contentPadding,
          ),
          style: MaterialStateTextStyle.resolveWith((states) {
            var color = PiixColors.infoDefault;
            if (states.contains(MaterialState.disabled)) {
              color = PiixColors.secondary;
            }
            return BaseTextTheme().titleMedium.copyWith(color: color);
          }),
        );

  @override
  final bool enabled;

  ///The text shown when the [TextFormField] has
  ///an error.
  final String? errorText;

  ///The text shown below the [TextFormField] to
  ///indicate what the user needs to comply with.
  final String? helperText;

  ///The text shown in the [TextFormField] to
  ///knwow what the field is for.
  final String? labelText;

  ///Maximum number of lines an error can show below the
  ///[TextFormField].
  final int? errorMaxLines;

  ///Maximum number of lines a help text can show below the
  ///[TextFormField].
  final int? helperMaxLines;

  ///Pass a non null value to show a suffix.
  ///[suffixIconData] and [icon] must be null.
  final Widget? suffix;

  ///Pass a non null value to show a prefix.
  final Widget? prefix;

  ///Allows to acommodate the content to make bigger or smaller
  ///the input space.
  final EdgeInsets? contentPadding;
}
