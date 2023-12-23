import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/validators.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Will be removed in 4.0')

///Widget used as a general [TextFormField] to input the phone number without
///the international phone code for
///"phoneNumber" dataTypeId formFields [FormFieldModelOld].
///
/// /// This cannot be used independently and alway needs to be a child widget of [PiixPhoneNumberInput].
/// All calculations are made by using getters, if any additional information
/// is to be inserted, consider using
/// service locators or dependency injections. The only property received in
/// the constructor is a [formField] which
/// is derived from a [FormFieldModelOld] and contains all the information to
/// retrieve and store user responses.
///
/// This do not use any type of [TextEditingController] or [FocusNode] which
/// are not necessary to process any information
/// as this is only used inside predefined forms.
class PiixPhoneNumberTextFormFieldDeprecated extends ConsumerStatefulWidget {
  const PiixPhoneNumberTextFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the
  ///[TextFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixPhoneNumberTextFormFieldDeprecated> createState() =>
      _PiixPhoneNumberTextFormFieldState();
}

class _PiixPhoneNumberTextFormFieldState
    extends ConsumerState<PiixPhoneNumberTextFormFieldDeprecated> {
  final focusNode = FocusNode();

  FormFieldModelOld get formField => widget.formField;

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  ///Checks if default value is a null or if [isNotEmptyOptional] as well as
  ///also [isEditable]
  bool get _enabled => widget.formField.isEditable;

  ///Calculates if the [TextFormField] should always check for an error or just
  ///when a user interacts based on the [FormFieldErrorDeprecated].
  AutovalidateMode get _autovalidateMode =>
      ref.read(formFieldErrorNotifierDeprecatedPodProvider) !=
              FormFieldErrorDeprecated.phoneNumber
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction;

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

  ///Updates the [stringResponse] value of [widget.formField].
  ///If the value is null it cleans the field.
  void _onChanged(String? value) {
    ref.read(formNotifierProvider.notifier).updateFormField(
          formField: widget.formField,
          value: value,
          type: ResponseType.string,
        );
  }

  String? get phoneResponse {
    final stringResponse = widget.formField.stringResponse;
    if (stringResponse.isNotNullEmpty) {
      final phoneNumber =
          stringResponse!.replaceAll(ConstantsDeprecated.mexicanLada, '');
      return phoneNumber;
    }
    return widget.formField.stringResponse;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      enabled: _enabled,
      initialValue: phoneResponse,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autovalidateMode: _autovalidateMode,
      onChanged: _onChanged,
      style: InputStyleUtilsDeprecated.style(
        context,
        isEditable: formField.isEditable,
      ),
      decoration: decoration(context),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) => errorText,
    );
  }
}

///An extension used to decorate the [PiixPhoneNumberTextFormFieldDeprecated] styles,
///texts and colors
///
/// Use [helperText] if other kind of helper text need to be added.
/// Use [errorText] when new specific errors should be presented.
extension _PiixPhoneNumberTextFormFieldDecoration
    on _PiixPhoneNumberTextFormFieldState {
  String? get helperText {
    String? helperText;
    if (formField.required) {
      helperText = PiixCopiesDeprecated.requiredField + (helperText ?? ' ');
    }
    if (formField.helperText.isNotNullEmpty) {
      helperText = '${helperText ?? ''}${formField.helperText!}';
    }
    return '${helperText ?? ''}';
  }

  String? get errorText {
    if (phoneResponse == null || phoneResponse.isEmptyNull) {
      return null;
    }
    if (formField.responseErrorText.isNotNullEmpty) {
      return formField.responseErrorText;
    }
    if ((phoneResponse ?? '').length != 10 ||
        !RegExp(Validators.noLadaPhoneValidator)
            .hasMatch(phoneResponse ?? '')) {
      return PiixCopiesDeprecated.invalidPhone;
    }
    return null;
  }

  ///The decoration used by [PiixPhoneNumberTextFormFieldDeprecated]
  InputDecoration decoration(BuildContext context) {
    final splitName = splitTextBy(name: formField.name);
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      errorBorder: InputDecorationUtilsDeprecated.errorBorder,
      focusedErrorBorder: InputDecorationUtilsDeprecated.focusedErrorBorder,
      labelText: getTextLabel(splitName, formField.required),
      labelStyle: InputStyleUtilsDeprecated.labelStyle(
        context,
        errorText: errorText,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      floatingLabelStyle: InputStyleUtilsDeprecated.floatingLabelStyle(
        context,
        errorText: errorText,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      errorStyle: InputStyleUtilsDeprecated.errorStyle(context),
      errorText: errorText,
    );
  }
}
