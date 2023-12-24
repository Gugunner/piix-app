import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/model/selector_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_object_select_dropdown_button_deprecated/piix_dropdown_menu_characteristics_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_object_select_dropdown_button_deprecated/piix_dropdown_menu_radio_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Will be removed in 6.0')

///Widget used as a general [PiixObjectSelectDropDownButtonDeprecated] for "object"
///dataTypeId formFields [FormFieldModelOld}.
///
/// All calculations are made by using getters, if any additional information
/// is to be inserted, consider using service locators or dependency injections.
/// The only property received in the constructor is a [formField] which is
/// derived from a [FormFieldModelOld] and contains all the information to
/// retrieve and store user response.
class PiixObjectSelectDropDownButtonDeprecated extends ConsumerStatefulWidget {
  const PiixObjectSelectDropDownButtonDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the
  ///[DropdownButtonFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixObjectSelectDropDownButtonDeprecated> createState() =>
      _PiixObjectSelectDropDownButtonState();
}

class _PiixObjectSelectDropDownButtonState
    extends ConsumerState<PiixObjectSelectDropDownButtonDeprecated> {
  final FocusNode focusNode = FocusNode();

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  FormFieldModelOld get formField => widget.formField;

  late FormNotifier formNotifier;

  @override
  void initState() {
    focusNode..addListener(_onChangeFocus);
    super.initState();
  }

  @override
  void dispose() {
    //We must dispose the controller to avoid memory leaks
    focusNode.dispose();
    super.dispose();
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

  /// [objectValues] is a nullable list type, a simple evaluation is made to
  /// avoid calling the values
  /// if they are null.
  List<SelectorObjectModel> get _objectValues {
    if (widget.formField.objectValues.isNotNullOrEmpty) {
      return widget.formField.objectValues!;
    }
    return [];
  }

  ///Stores the [value] that is selected in the dropdown form field.
  void _onChanged(String? value) {
    formNotifier.updateFormField(
      formField: widget.formField,
      value: value,
      type: ResponseType.string,
    );
    focusNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    formNotifier = ref.watch(formNotifierProvider.notifier);
    return IgnorePointer(
      ignoring: !widget.formField.isEditable,
      child: Container(
        margin: EdgeInsets.only(
          top: context.height * 0.0085,
          bottom: context.height * 0.017,
        ),
        // height: 50,
        child: DropdownButtonFormField<String>(
          focusNode: focusNode,
          isExpanded: true,
          items: _dropdownItems,
          onChanged: _onChanged,
          value:
              widget.formField.defaultValue ?? widget.formField.stringResponse,
          alignment: AlignmentDirectional.topCenter,
          decoration: decoration(context),
          menuMaxHeight: 380,
          style: InputStyleUtilsDeprecated.style(context,
              isEditable: formField.isEditable),
          icon: Align(
            alignment: Alignment.centerRight,
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(
              Icons.arrow_drop_down,
              color: widget.formField.stringResponse.isNotNullEmpty
                  ? PiixColors.insurance
                  : PiixColors.infoDefault,
            ),
          ),
        ),
      ),
    );
  }
}

///An extension used to decorate the [PiixObjectSelectDropDownButtonDeprecated] styles,
///texts and colors
extension _PiixObjectSelectDropDownButtonDecorator
    on _PiixObjectSelectDropDownButtonState {
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
      contentPadding: EdgeInsets.zero,
      label: Text(getTextLabel(splitName, formField.required)),
      labelStyle: InputStyleUtilsDeprecated.labelStyle(context,
          hasFocus: hasFocus, isEditable: formField.isEditable),
      floatingLabelStyle: InputStyleUtilsDeprecated.floatingLabelStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(context,
          hasFocus: hasFocus, isEditable: formField.isEditable),
      constraints: const BoxConstraints(minHeight: 0),
    );
  }
}

///An extension used to obtain the [_dropdownItems] list for
///[PiixObjectSelectDropDownButtonDeprecated].
extension _PiixObjectSelectDropDownButtonMenuItem
    on _PiixObjectSelectDropDownButtonState {
  List<DropdownMenuItem<String>> get _dropdownItems =>
      _objectValues.map((value) {
        return DropdownMenuItem(
          child: Container(
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IgnorePointer(
                  ignoring: true,
                  child: PiixDropdownMenuRadioDeprecated(
                    value: value.name,
                    groupValue: formField.stringResponse,
                  ),
                ),
                Expanded(
                  child: PiixDropdownMenuCharacteristicsDeprecated(
                    value: value.name,
                    values: value.characteristics,
                  ),
                ),
              ],
            ),
          ),
          value: value.name,
        );
      }).toList();
}
