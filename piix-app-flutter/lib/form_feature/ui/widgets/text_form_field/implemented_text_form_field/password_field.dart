import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/checkbox_button/app_checkbox_button.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

///The default implementation for the [AppTextFormField] working as a
///password input.
///
///This is a custom [Widget] that portrays a password input and an [AppCheckbox]
///to toggle password visibility.
final class PasswordField extends BaseAppTextFormField {
  const PasswordField({
    super.key,
    super.enabled,
    super.handleFocusNode = true,
    super.autofocus,
    super.onSaved,
    super.onChanged,
    super.controller,
    super.validator,
    super.obscuringCharacter = '•',
    this.minLength = 8,
    super.maxLength = 20,
    this.show,
    super.labelText,
    super.inputFormatters,
    super.apiException,
  });

  ///The minimum length for the password security,
  ///by default is 8.
  final int minLength;

  ///Pass the value as either true or false
  ///to control password visibility.
  final bool? show;

  @override
  State<StatefulWidget> createState() => _AppOnActionPasswordFieldState();
}

///The implementation for the [BaseAppTextFormFieldState] based on an
///[PasswordField].
final class _AppOnActionPasswordFieldState
    extends BaseAppTextFormFieldState<PasswordField> with AppRegex {
  ///An internal flag that toggles between true or false
  ///to hide or show the password.
  bool _show = false;
  @override
  String? get labelText => widget.labelText ?? context.localeMessage.password;

  String get _showPassword => context.localeMessage.showPassword;

  ///A simple call to avoid calling widget each time the minimum
  ///length is needed.
  int get _minLength => widget.minLength;

  ///A simple call to avoid calling widget each time the maximum
  ///length is needed.
  int get _maxLength => widget.maxLength!;
  double get _space => 4.h;

  ///Returns the text inside the [controller].
  String? get controllerText {
    if (widget.controller != null) return widget.controller!.text;
    return null;
  }

  @override
  String? validator(String? value) {
    //If a [validator] callback is passed then it replaces this
    //method.
    final apiException = widget.apiException;
    if (widget.validator != null) return widget.validator?.call(value);

    final localeMessage = context.localeMessage;
    if (value.isNullOrEmpty) return localeMessage.emptyField;
    if (value!.characters.length < _minLength)
      return localeMessage.wrongMinLength(_minLength);
    if (value.characters.length > _maxLength)
      return localeMessage.wrongMaxLength(_maxLength);
    if (!validPassword(value))
      return localeMessage.passwordInstructions(_minLength, _maxLength);

    ///If no api error is found then no error is shown.
    if (apiException == null || apiException.errorCodes.isNullOrEmpty)
      return null;
    if (apiException.errorCodes!.contains(apiInvalidPassword)) {
      return localeMessage.invalidPassword;
    }

    return null;
  }

  ///Unfocus the [AppTextFormField] if
  /// [useInternalFocusNode] is true when
  /// the user taps outside the this.
  void onTapOutside(PointerDownEvent? event) {
    if (widget.handleFocusNode) {
      focusNode?.unfocus();
    }
  }

  ///Handles toggling the password
  ///visibility
  void onTogggleShowPassword(bool? value) {
    setState(() {
      _show = !_show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          autovalidateMode: autovalidateMode,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          focusNode: widget.handleFocusNode ? focusNode : null,
          readOnly: widget.readOnly,
          onSaved: onSaved,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          controller: widget.controller,
          validator: controllerText != null ? null : validator,
          helperText: helperText,
          labelText: labelText,
          errorMaxLines: 5,
          helperMaxLines: 5,
          keyboardType: TextInputType.visiblePassword,
          onTapOutside: onTapOutside,
          textInputAction: TextInputAction.done,
          obscureText: widget.show ?? !_show,
          obscuringCharacter: widget.obscuringCharacter,
          maxLines: 1,
        ),
        if (widget.show == null) ...[
          SizedBox(height: _space),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppCheckboxButton(value: _show, onChanged: onTogggleShowPassword),
              SizedBox(width: 4.w),
              Text(
                _showPassword,
                style: AppInputDecorationTheme().helperStyle,
              ),
            ],
          )
        ],
      ],
    );
  }
}
