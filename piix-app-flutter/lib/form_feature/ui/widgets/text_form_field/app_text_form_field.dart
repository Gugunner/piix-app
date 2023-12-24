import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/text_theme/base_text_theme.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

///The class to extend from when working with [TextFormField] inside the App.
///
///This class is a subclass of [TextFormField] with a predefined
///[InputDecoration and properties used for the app.
base class AppTextFormField extends TextFormField {
  AppTextFormField({
    super.key,
    super.autovalidateMode,
    super.controller,
    super.enabled,
    super.initialValue,
    super.onSaved,
    super.validator,
    super.focusNode,
    super.keyboardType,
    super.textInputAction,
    super.autofocus,
    super.readOnly,
    super.obscuringCharacter,
    super.obscureText,
    super.minLines,
    super.maxLines,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onTapOutside,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.inputFormatters,
    super.scrollPadding,
    super.scrollController,
    super.expands,
    this.errorText,
    this.helperText,
    this.labelText,
    this.errorMaxLines,
    this.helperMaxLines,
    this.suffixIconData,
    this.icon,
    this.suffix,
    this.prefix,
    this.contentPadding,
  })  : assert(
          suffix == null || icon == null || suffixIconData == null,
        ),
        super(
          decoration: GeneralFormInputDecoration(
            helperText: helperText,
            labelText: labelText,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            helperMaxLines: helperMaxLines,
            enabled: enabled ?? true,
            suffix: suffix,
            prefix: prefix,
            suffixIcon:
                icon ?? (suffixIconData != null ? Icon(suffixIconData) : null),
            suffixIconConstraints: BoxConstraints(
              maxWidth: 16.w,
              maxHeight: 16.w,
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

  ///Pass a non null value to show an icon after the input space.
  ///If this property is not null [icon] must be null.
  final IconData? suffixIconData;

  ///Pass a non null value to show an element after the input space.
  ///If this property is not null [suffixIconData] must be null.
  final Widget? icon;

  ///Pass a non null value to show a suffix.
  ///[suffixIconData] and [icon] must be null.
  final Widget? suffix;

  ///Pass a non null value to show a prefix.
  final Widget? prefix;

  ///Allows to acommodate the content to make bigger or smaller
  ///the input space.
  final EdgeInsets? contentPadding;
}
