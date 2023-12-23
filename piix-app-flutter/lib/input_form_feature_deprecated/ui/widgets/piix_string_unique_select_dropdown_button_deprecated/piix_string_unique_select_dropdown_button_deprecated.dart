import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_unique_select_dropdown_button_deprecated/piix_string_other_select_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Use instead AppOnActionUniqueSelectField')

///Widget used as a general [DropdownButtonFormField] for "string" dataTypeId
///formFields [FormFieldModelOld].
///
/// All calculations are made by using getters, if any additional information
/// is to be inserted, consider using service locators or dependency
/// injections.
/// The only property received in the constructor is a [formField] which
/// is derived from a [FormFieldModelOld] and contains all the information
/// to retrieve and store user response.
class PiixStringSelectDropDownButtonDeprecated extends ConsumerStatefulWidget {
  const PiixStringSelectDropDownButtonDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [DropdownButtonFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixStringSelectDropDownButtonDeprecated> createState() =>
      _PiixStringSelectDropDownButtonState();
}

class _PiixStringSelectDropDownButtonState
    extends ConsumerState<PiixStringSelectDropDownButtonDeprecated> {
  final focusNode = FocusNode();

  FormFieldModelOld get formField => widget.formField;

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  @override
  void initState() {
    focusNode.addListener(_onChangeFocus);
    if (widget.formField.stringResponse.isNotNullEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onChanged(widget.formField.stringResponse);
      });
    }
    super.initState();
  }

  void _onChangeFocus() {
    debugPrint('Has primary Focus ${formField.formFieldId} - '
        '${focusNode.hasPrimaryFocus}');
    debugPrint('Has Focus ${formField.formFieldId} - '
        '${focusNode.hasFocus}');
    if (!focusNode.hasPrimaryFocus) {
      focusNode.unfocus();
    }
    setState(() {});
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  List<SelectorModel>? get values {
    if (formField.relatedFormFieldId.isNullOrEmpty) {
      return null;
    }
    if (formField.values.isNullOrEmpty) {
      return null;
    }
    final selector = formField.values!.first;
    if (selector.typeId.isNullOrEmpty) {
      return null;
    }
    final filteringFormField = ref
        .read(formNotifierProvider.notifier)
        .state
        ?.formFieldBy(formField.relatedFormFieldId!);
    if (filteringFormField == null ||
        filteringFormField.idResponse.isNullOrEmpty) {
      return null;
    }
    final values = formField.values!
        .where((v) => v.typeId == filteringFormField.idResponse);
    return values.toList();
  }

  ///Retrieves the list of string values that is found inside the property [values] in a [PiixFormFieldModel].
  ///
  /// Checks if the list is only [String] and then returns it casting it since [values] is a list of dynamic type.
  /// Currently it can process either a list of only [String] values or a list of [SelectorModel] values.
  /// Any other type of list returns an empty list.
  List<String> get _stringValues {
    if (!widget.formField.returnId &&
        widget.formField.stringValues.isNotNullOrEmpty) {
      return widget.formField.stringValues!;
    } else if (widget.formField.returnId &&
        widget.formField.values.isNotNullOrEmpty) {
      final newValues = values ?? widget.formField.values!;
      return newValues.map((v) => v.name).toList();
    }
    return [];
  }

  ///Retrieves a list of string [formFieldId] values that is found inside the property [values] in a [PiixFormFieldModel].
  ///
  /// Currently it can only process list of [SelectorModel], any other type of list returns an empty list.
  List<String> get _idValues {
    if (widget.formField.values.isNotNullOrEmpty && widget.formField.returnId) {
      final newValues = values ?? widget.formField.values!;
      return newValues.map((v) => v.id).toList();
    }
    return [];
  }

  ///Stores the [value] that is selected in the dropdown form field.
  ///
  /// If there are [_idValues] it store the  corresponding [formFieldId]
  /// inside the property of [idResponse] of the [widget.formField] by calling
  /// the method [updateFormField] from [_formFieldBLoC].
  ///The [value] is always a string name and not an id so it needs to check for
  ///the index where the id is stored.
  ///
  /// Finally it stores the [value] inside the inside the property of
  /// [idResponse] of the [widget.formField] by calling
  /// the method [updateFormField] from [_formFieldBLoC].
  void _onChanged(String? value) {
    final idValues = _idValues;
    final newFormField =
        ref.read(formNotifierProvider.notifier).updateFormField(
              formField: widget.formField.copyWith(defaultValue: null),
              value: value,
              type: ResponseType.string,
            );
    if (value != null && idValues.isNotEmpty) {
      final index = _stringValues.indexWhere((v) => v == value);
      if (index > -1) {
        final selectedValue = idValues[index];
        ref.read(formNotifierProvider.notifier).updateFormField(
              formField: newFormField.copyWith(defaultValue: null),
              value: selectedValue,
              type: ResponseType.id,
            );
        //TODO: Check focus node bug
        focusNode.nextFocus();
      }
      formField.onChanged?.call();
    }
  }

  ///If [otherOption] is true and the current [value] is not otro or otra
  ///then it cleans the [otherResponse] property of the [widget.formField] by
  ///calling the method [updateFormField] from [_formFieldBLoC].
  void cleanOtherResponse(String? value) {
    if (otherOption) {
      if (widget.formField.stringResponse!.compareTo(value ?? '') != 0) {
        ref.read(formNotifierProvider.notifier).updateFormField(
              formField: widget.formField,
              value: null,
              type: ResponseType.other,
            );
      }
    }
  }

  ///Checks if the [stringResponse] is a non empty nullable string type and
  ///then compares if either it contains otra or otro.
  bool get otherOption =>
      widget.formField.stringResponse.isNotNullEmpty &&
      widget.formField.includesOtherOption &&
      widget.formField.stringResponse!.toLowerCase().compareTo('otro') == 0;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.formField.isEditable,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: context.height * 0.0085),
        child: Column(
          children: [
            if (otherOption) const Divider(),
            if (widget.formField.name.length > 84)
              Text(
                widget.formField.name,
                style: InputStyleUtilsDeprecated.labelStyle(
                  context,
                  errorText: formField.errorText,
                  hasFocus: hasFocus,
                  isEditable: formField.isEditable,
                ),
              ),
            DropdownButtonFormField<String>(
              onTap: () => focusNode.requestFocus(),
              focusColor: hasFocus ? PiixColors.azure : PiixColors.mainText,
              focusNode: focusNode,
              isExpanded: true,
              isDense: false,
              items: _dropdownItems,
              value: widget.formField.stringResponse,
              decoration: decoration(context),
              style: InputStyleUtilsDeprecated.style(context,
                  isEditable: formField.isEditable),
              onChanged: widget.formField.isEditable ? _onChanged : null,
              icon: Align(
                alignment: Alignment.centerRight,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: formField.errorText.isNotNullEmpty
                      ? PiixColors.errorText
                      : hasFocus
                          ? PiixColors.azure
                          : PiixColors.brownishGrey,
                ),
              ),
            ),
            if (otherOption) ...[
              PiixStringOtherSelectTextFormFieldDeprecated(
                  formField: widget.formField),
              const Divider()
            ],
          ],
        ),
      ),
    );
  }
}

///An extension used to decorate the [PiixStringSelectDropDownButtonDeprecated] styles,
/// texts and colors
extension _PiixStringSelectDropDownButtonDecorator
    on _PiixStringSelectDropDownButtonState {
  String? get helperText {
    String? helperText;
    if (formField.required) {
      helperText = PiixCopiesDeprecated.requiredField + (helperText ?? ' ');
    }
    if (formField.helperText.isNotNullEmpty) {
      helperText = helperText ?? '' + formField.helperText!;
    }
    return helperText;
  }

  InputDecoration decoration(BuildContext context) {
    final splitName = splitTextBy(name: formField.name);
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      errorBorder: InputDecorationUtilsDeprecated.errorBorder,
      focusedErrorBorder: InputDecorationUtilsDeprecated.focusedBorder,
      label: Text(
        getTextLabel(splitName, formField.required),
      ),
      labelStyle: InputStyleUtilsDeprecated.labelStyle(
        context,
        errorText: formField.errorText,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      floatingLabelStyle: InputStyleUtilsDeprecated.floatingLabelStyle(
        context,
        errorText: formField.errorText,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      errorText: formField.errorText,
      errorStyle: InputStyleUtilsDeprecated.errorStyle(context),
    );
  }
}

///An extension used to obtain the [_dropdownItems] list for
///[PiixStringSelectDropDownButtonDeprecated].
extension _PiixStringSelectDropDownButtonMenuItem
    on _PiixStringSelectDropDownButtonState {
  List<DropdownMenuItem<String>> get _dropdownItems => _stringValues.map(
        (value) {
          return DropdownMenuItem(
            child: Text(
              value,
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            value: value,
            onTap: () {
              cleanOtherResponse(value);
              focusNode.unfocus();
            },
          );
        },
      ).toList();
}
