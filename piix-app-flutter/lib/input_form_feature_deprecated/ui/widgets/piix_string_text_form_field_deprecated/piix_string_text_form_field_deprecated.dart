import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_text_form_field_deprecated/piix_string_text_form_field_tooltip_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/id_utils.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_validations.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/text_formatters.dart';

@Deprecated('Use instead AppOnActionTextField')

///Widget used as a general [TextFormField] for "string" dataTypeId formFields
/// [FormFieldModelOld].
///
///All calculations are made by using getters, if any additional information
///is to be inserted, consider using dependency injections. The only property
///received in the constructor is a [formField] which is derived from a
///[FormFieldModelOld] and contains all the information to retrieve and store
///user responses.
///
/// This do not use any type of [TextEditingController] or [FocusNode] which
/// are not necessary to process any information as this is only used inside
/// predefined forms.
///
class PiixStringTextFormFieldDeprecated extends ConsumerStatefulWidget {
  const PiixStringTextFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the
  ///[TextFormField]
  ///
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixStringTextFormFieldDeprecated> createState() =>
      _PiixStringTextFormFieldState();
}

class _PiixStringTextFormFieldState
    extends ConsumerState<PiixStringTextFormFieldDeprecated> {
  final focusNode = FocusNode();

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  ///Checks if default value is null or if [isNotEmptyOptional] as well as
  ///also [isEditable]
  bool get _enabled => widget.formField.isEditable;

  int get defaultLength => 50;

  FormFieldModelOld get formField => widget.formField;

  @override
  void initState() {
    focusNode.addListener(_onChangeFocus);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _onChangeFocus() {
    debugPrint('Has primary Focus ${formField.formFieldId} - '
        '${focusNode.hasPrimaryFocus}');
    debugPrint('Has Focus ${formField.formFieldId} - '
        '${focusNode.hasFocus}');
    setState(() {});
  }

  ///How the app should behave when text is being edited.
  void _onChanged(String? value) {
    ref.read(formNotifierProvider.notifier).updateFormField(
          formField: widget.formField,
          value: value,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: TextFormField(
        focusNode: focusNode,
        enabled: _enabled,
        initialValue: widget.formField.stringResponse,
        maxLength: widget.formField.maxLength,
        decoration: decoration(context),
        keyboardType: widget.formField.formFieldId.compareTo('email') == 0
            ? TextInputType.emailAddress
            : TextInputType.text,
        textInputAction:
            formField.lastField ? TextInputAction.done : TextInputAction.next,
        inputFormatters: [
          NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny('  ', replacementString: ' '),
        ],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => errorText,
        style: InputStyleUtilsDeprecated.style(context,
            isEditable: formField.isEditable),
        onChanged: _onChanged,
      ),
    );
  }
}

///An extension used to decorate the [PiixStringTextFormFieldDeprecated] styles, texts
///and colors
///
/// Use [helperText] if other kind of helper text need to be added.
/// Use [errorText] when new specific errors should be presented.
extension _PiixStringTextFormFieldDecoration on _PiixStringTextFormFieldState {
  String? get helperText {
    String? text;
    text = formField.required
        ? PiixCopiesDeprecated.requiredField
        : PiixCopiesDeprecated.optionalField;

    if (formField.helperText.isNotNullEmpty) {
      text = '$text  ${formField.helperText!}';
    }
    return text;
  }

  String? get errorText {
    if (formField.stringResponse == null ||
        formField.stringResponse.isEmptyNull) {
      return null;
    }
    if (formField.responseErrorText.isNotNullEmpty) {
      return formField.responseErrorText;
    }
    if (formField.stringResponse.isNotNullEmpty) {
      if (formField.stringResponse!.trim().length < formField.minLength) {
        return PiixCopiesDeprecated.minCharactersValidatorText(
            formField.minLength);
      }
    }
    const namesFields = [
      'name',
      'middleName',
      'names',
    ];
    const lastNamesFields = [
      'firstLastName',
      'secondLastName',
      'lastNames',
    ];
    if (namesFields.contains(formField.formFieldId) &&
        !validateNames(formField.stringResponse ?? '')) {
      return FormFieldErrorDeprecated.name.errorMessage;
    }
    if (lastNamesFields.contains(formField.formFieldId) &&
        !validateNames(formField.stringResponse ?? '')) {
      return FormFieldErrorDeprecated.firstLastName.errorMessage;
    }
    if (formField.formFieldId.compareTo('email') == 0 &&
        !validateEmail(formField.stringResponse ?? '')) {
      return FormFieldErrorDeprecated.email.errorMessage;
    }
    return null;
  }

  ///The decoration used by [PiixStringTextFormFieldDeprecated]
  InputDecoration decoration(BuildContext context) {
    final splitName = splitTextBy(name: formField.name);
    final Tooltip = formField.tooltip.isNotNullEmpty
        ? PiixStringTextFormFieldTooltipDeprecated(
            tooltip: formField.tooltip,
            id: FormFieldUtilsDeprecated.fromString(formField.formFieldId))
        : null;
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      errorBorder: InputDecorationUtilsDeprecated.errorBorder,
      focusedErrorBorder: InputDecorationUtilsDeprecated.focusedErrorBorder,
      labelText: getTextLabel(splitName, formField.required),
      suffixIcon: Tooltip,
      labelStyle: InputStyleUtilsDeprecated.labelStyle(context,
          hasFocus: hasFocus, isEditable: formField.isEditable),
      floatingLabelStyle: InputStyleUtilsDeprecated.floatingLabelStyle(
        context,
        errorText: errorText,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(context,
          hasFocus: hasFocus, isEditable: formField.isEditable),
      helperMaxLines: 5,
      errorStyle: InputStyleUtilsDeprecated.errorStyle(context),
      errorText: errorText,
    );
  }
}
