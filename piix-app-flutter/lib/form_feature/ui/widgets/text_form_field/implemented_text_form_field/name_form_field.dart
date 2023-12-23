import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///The default implementation for the [AppTextFormField] working as a
///name input (name, middle name, first last name and second last name).
final class NameFormField extends BaseAppTextFormField {
  const NameFormField({
    super.key,
    super.index,
    super.enabled,
    super.required,
    super.autofocus,
    super.newFocusNode,
    super.handleFocusNode = false,
    super.labelText,
    super.initialValue,
    super.readOnly,
    super.onSaved,
    super.onChanged,
    super.onHandleForm,
    super.controller,
    super.validator,
    super.textInputAction,
    super.apiException,
  });

  @override
  State<StatefulWidget> createState() => _NameFormFieldState();
}

///The implementation for the [BaseAppTextFormFieldState] based on a
///[NameFormField].
final class _NameFormFieldState extends BaseAppTextFormFieldState<NameFormField>
    with AppRegex {
  @override
  String? validator(String? value) {
    //If a [validator] callback is passed then it replaces this
    //method.
    if (widget.validator != null) return widget.validator?.call(value);
    final localeMessage = context.localeMessage;
    if (widget.required && value.isNullOrEmpty) return localeMessage.emptyField;
    if (value.isNotNullEmpty && !validName(value!))
      return localeMessage.invalidName;
    final apiException = widget.apiException;
    //If no api error is found then no error is shown.
    if (apiException == null) return null;
    if (apiException.errorCodes.isNullOrEmpty) return null;
    //Implement apiExceptions codes if needed
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
      autofocus: widget.autofocus,
      focusNode: focusNode,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      onSaved: onSaved,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      controller: widget.controller,
      validator: controllerText != null ? null : validator,
      helperText: helperText,
      helperMaxLines: 3,
      errorMaxLines: 3,
      labelText: labelText,
      errorText: controllerText != null ? validator(controllerText!) : null,
      keyboardType: TextInputType.name,
      onTapOutside: onTapOutside,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
    );
  }
}
