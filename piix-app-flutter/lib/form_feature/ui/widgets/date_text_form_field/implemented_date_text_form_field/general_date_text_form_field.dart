import 'package:flutter/src/widgets/framework.dart';
import 'package:piix_mobile/form_feature/ui/widgets/date_text_form_field/date_text_form_field_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';

///A wrapper class that allows for a custom [AppTextFormField] to work
///with the [BaseAppDateTextFormField] implementation.
final class GeneralDateTextFormField extends BaseAppDateTextFormField {
  const GeneralDateTextFormField({
    super.key,
    super.index,
    super.enabled,
    super.required,
    super.autofocus,
    super.handleFocusNode,
    super.obscureText,
    super.scrollPadding,
    super.onSaved,
    super.onChanged,
    super.controller,
    super.validator,
    super.textInputAction,
    super.autovalidateMode,
    super.newFocusNode,
    super.keyboardType,
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
    super.onSelectDate,
    super.minDate,
    super.maxDate,
    super.initialDate,
  });

  @override
  State<StatefulWidget> createState() => _GeneralDateTextFormFieldState();
}

final class _GeneralDateTextFormFieldState
    extends BaseAppDateTextFormFieldState {
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      //Pass true as the value to avoid opening the virtual keyboard when
      //tapping the field.
      readOnly: true,
      enabled: widget.enabled,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      autofocus: widget.autofocus,
      scrollPadding: widget.scrollPadding,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      focusNode: focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      errorMaxLines: widget.errorMaxLines,
      helperMaxLines: widget.helperMaxLines,
      maxLength: widget.maxLines,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onEditingComplete: widget.onEditingComplete,
      // onFieldSubmitted: onSubmitted,
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
