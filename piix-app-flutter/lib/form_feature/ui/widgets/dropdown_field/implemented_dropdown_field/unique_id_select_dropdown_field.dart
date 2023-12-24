import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/dropdown_field/dropdown_field_barrel_file.dart';

//TODO: Implement OtherOptionField when needed

///A special [AppDropdownFormField] that instead of working with [items] needs
///to receive a list of [ValueModel]s.
///
///When an option is selected from the [values] it will instead store the [id]
///inside of the [ValueModel] to pass it to the parent using [onHandleForm].
final class UniqueIdSelectDropdownField extends BaseAppDropdownFormField {
  const UniqueIdSelectDropdownField({
    super.key,
    required super.onChanged,
    required this.values,
    super.index,
    super.enabled,
    super.required,
    super.handleFocusNode,
    super.readOnly,
    super.newFocusNode,
    super.initialValue,
    super.decoration,
    super.onSaved,
    super.validator,
    super.onHandleForm,
    super.labelText,
    super.helperText,
  });

  ///The values to be passed and converted to [items].
  final List<ValueModel> values;

  @override
  State<StatefulWidget> createState() => _IdTextFropdownFieldState();
}

final class _IdTextFropdownFieldState
    extends BaseAppDropdownFormFieldState<UniqueIdSelectDropdownField> {
  @override
  List<ValueModel> get itemValues => widget.values;

  @override
  List<DropdownMenuItem<String>> get items => itemValues
      .map((v) => DropdownMenuItem<String>(
            onTap: onTap,
            //Passing the value as the id ensures
            //that the value stored is the id.
            value: v.id,
            child: Text(
              v.name,
              style: textStyle,
            ),
          ))
      .toList();

  @override
  void initState() {
    super.initState();
    //initializes the [focusNode] only if
    //[useInternalFocusNode] is true.
    if (widget.handleFocusNode) {
      focusNode = widget.newFocusNode;
    }
    if (widget.initialValue != null) {
      selectedValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownFormField(
      items: items,
      value: selectedValue,
      onChanged: onChanged,
      enabled: widget.enabled,
      focusNode: focusNode,
      onSaved: onSaved,
      onTap: onTap,
      validator: validator,
      labelText: labelText,
      helperText: helperText,
    );
  }
}
