import 'package:flutter/src/widgets/framework.dart';
import 'package:piix_mobile/form_feature/ui/widgets/dropdown_field/dropdown_field_barrel_file.dart';

///A wrapper class that allows for a custom [AppDropdownFormField].
final class GeneralTextDropdownFormField extends BaseAppDropdownFormField {
  const GeneralTextDropdownFormField({
    super.key,
    required super.onChanged,
    super.index,
    super.enabled,
    super.required,
    super.autofocus,
    super.handleFocusNode,
    super.readOnly,
    super.isDense,
    super.isExpanded,
    super.iconSize,
    super.alignment,
    super.selectedItemBuilder,
    super.hint,
    super.disabledHint,
    super.icon,
    super.iconDisabledColor,
    super.iconEnabledColor,
    super.itemHeight,
    super.focusColor,
    super.newFocusNode,
    super.dropdownColor,
    super.decoration,
    super.onSaved,
    super.validator,
    super.onHandleForm,
    super.autovalidateMode,
    super.menuMaxHeight,
    super.enableFeedback,
    super.borderRadius,
    super.padding,
    super.items,
    super.itemValues,
    super.onTap,
    super.errorText,
    super.helperText,
    super.labelText,
    super.errorMaxLines,
    super.helperMaxLines,
    super.prefix,
    super.suffix,
    super.contentPadding,
    super.apiException,
  });

  @override
  State<StatefulWidget> createState() => _GeneralTextDropdownFieldState();
}

final class _GeneralTextDropdownFieldState
    extends BaseAppDropdownFormFieldState<GeneralTextDropdownFormField> {
  
  @override
  String? validator(value) => widget.validator?.call(value);

  @override
  Widget build(BuildContext context) {
    return AppDropdownFormField(
      items: items,
      onChanged: onChanged,
      selectedItemBuilder: widget.selectedItemBuilder,
      value: selectedValue,
      hint: widget.hint,
      disabledHint: widget.disabledHint,
      onTap: onTap,
      icon: widget.icon,
      iconDisabledColor: widget.iconDisabledColor,
      iconEnabledColor: widget.iconEnabledColor,
      iconSize: widget.iconSize,
      isDense: widget.isDense,
      isExpanded: widget.isExpanded,
      itemHeight: widget.itemHeight,
      focusColor: widget.focusColor,
      focusNode: focusNode,
      autofocus: widget.autofocus,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      menuMaxHeight: widget.menuMaxHeight,
      enableFeedback: widget.enableFeedback,
      alignment: widget.alignment,
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      enabled: widget.enabled,
      errorText: widget.errorText,
      helperText: helperText,
      labelText: labelText,
      errorMaxLines: widget.errorMaxLines,
      helperMaxLines: widget.helperMaxLines,
      suffix: widget.suffix,
      prefix: widget.prefix,
      contentPadding: widget.contentPadding,
    );
  }
}
