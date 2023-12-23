import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/base_app_text_form_field.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/app_text_form_field.dart';

///A wrapper class that allows for a custom [AppTextFormField].
final class GeneralTextFormField extends BaseAppTextFormField {
  const GeneralTextFormField({
    super.key,
    super.index,
    super.readOnly = false,
    super.enabled = true,
    super.required = true,
    super.autofocus = false,
    super.obscureText = false,
    super.handleFocusNode,
    super.controller,
    super.onSaved,
    super.onHandleForm,
    super.onChanged,
    super.validator,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.obscuringCharacter = '•',
    super.autovalidateMode,
    super.initialValue,
    super.newFocusNode,
    super.keyboardType,
    super.textInputAction,
    super.minLines,
    super.maxLines,
    super.errorMaxLines,
    super.helperMaxLines,
    super.maxLength,
    super.onTap,
    super.onTapOutside,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onFocus,
    super.inputFormatters,
    super.scrollController,
    super.helperText,
    super.labelText,
    super.errorText,
    super.suffixIconData,
    super.icon,
    super.suffix,
    super.prefix,
    super.inputDecoration,
    super.apiException,
  });

  @override
  State<StatefulWidget> createState() => _GeneralFormFieldState();
}

final class _GeneralFormFieldState
    extends BaseAppTextFormFieldState<GeneralTextFormField> {
  @override
  String? validator(String? value) => widget.validator?.call(value);

  ///Unfocus the [AppTextFormField] if
  /// [useInternalFocusNode] is true when
  /// the user taps outside the this.
  void onTapOutside(PointerDownEvent? event) {
    if (widget.handleFocusNode) {
      focusNode?.unfocus();
    }
  }

  @override
  void onFocus() => widget.onFocus?.call();

  @override
  AppTextFormField build(BuildContext context) {
    return AppTextFormField(
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      controller: widget.controller,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      scrollPadding: widget.scrollPadding,
      autovalidateMode: autovalidateMode,
      initialValue: widget.initialValue,
      focusNode: focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscuringCharacter: widget.obscuringCharacter,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      errorMaxLines: widget.errorMaxLines,
      helperMaxLines: widget.helperMaxLines,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      onTapOutside: onTapOutside,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      scrollController: widget.scrollController,
      helperText: helperText,
      labelText: labelText,
      errorText: widget.errorText,
      suffixIconData: widget.suffixIconData,
      icon: widget.icon,
      suffix: widget.suffix,
      prefix: widget.prefix,
    );
  }
}
