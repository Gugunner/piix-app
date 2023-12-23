import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

///The default implementation for the [AppTextFormField] working as
///a phone number input.
final class PhoneFormField extends BaseAppTextFormField {
  const PhoneFormField({
    super.key,
    super.index,
    super.enabled,
    super.required,
    super.readOnly,
    super.handleFocusNode = true,
    super.newFocusNode,
    super.onSaved,
    super.onChanged,
    super.onHandleForm,
    super.controller,
    super.validator,
    super.labelText,
    super.helperText,
    super.initialValue,
    super.apiException,
  });

  @override
  State<StatefulWidget> createState() => _AppOnActionPhoneFieldState();
}

final class _AppOnActionPhoneFieldState
    extends BaseAppTextFormFieldState<PhoneFormField> with AppRegex {
  @override
  String? get labelText =>
      (widget.labelText ?? '${context.localeMessage.phoneNumber}') +
      requiredMark;

  @override
  String? get helperText => widget.helperText;

  int get _helperMaxLines => 5;

  int get _errorMaxLines => 5;

  EdgeInsets get _contentPadding => EdgeInsets.symmetric(vertical: 9.h);

  @override
  String? validator(String? value) {
    //If a [validator] callback is passed then it replaces this
    //method.
    if (widget.validator != null) return widget.validator?.call(value);
    if (value.isNullOrEmpty) return null;
    final localeMessage = context.localeMessage;
    if (!validPhone(value!)) return localeMessage.invalidPhone;
    final apiException = widget.apiException;

    //If no api error is found then no error is shown.
    if (apiException == null) return null;
    if (apiException.errorCodes.isNullOrEmpty) return null;
    //Checks for specific error codes.
    if (apiException.errorCodes!.contains(apiPhoneAlreadyUsed))
      return localeMessage.registeredPhone;
    if (apiException.errorCodes!.contains(apiUserNotFoundWithCredential))
      return localeMessage.unregisteredPhone;
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

  ///Returns the text inside the [controller].
  String? get controllerText {
    if (widget.controller != null) return widget.controller!.text;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      autovalidateMode: autovalidateMode,
      enabled: widget.enabled,
      focusNode: widget.handleFocusNode ? focusNode : null,
      readOnly: widget.readOnly,
      onSaved: onSaved,
      onChanged: onChanged,
      controller: widget.controller,
      validator: controllerText.isNotNullEmpty ? null : validator,
      helperMaxLines: _helperMaxLines,
      helperText: helperText,
      labelText: labelText,
      errorMaxLines: _errorMaxLines,
      errorText:
          controllerText.isNotNullEmpty ? validator(controllerText!) : null,
      keyboardType: TextInputType.phone,
      onTapOutside: onTapOutside,
      textInputAction: TextInputAction.done,
      contentPadding: _contentPadding,
    );
  }
}
