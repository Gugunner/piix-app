import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';

@Deprecated('No longer in use in 4.0')

///The widget can only be used inside a [PiixStringSelectDropDownButton] as it is an extra [TextFormField]
///to add a custom dropdown [otherResponse] in the [formField].
class PiixStringOtherSelectTextFormFieldDeprecated
    extends ConsumerStatefulWidget {
  const PiixStringOtherSelectTextFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [TextFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixStringOtherSelectTextFormFieldDeprecated> createState() =>
      _PiixStringOtherSelectTextFormFieldState();
}

class _PiixStringOtherSelectTextFormFieldState
    extends ConsumerState<PiixStringOtherSelectTextFormFieldDeprecated> {
  final focusNode = FocusNode();

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

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
          type: ResponseType.other,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.height * 0.0085),
      child: TextFormField(
        focusNode: focusNode,
        initialValue: widget.formField.otherResponse,
        textInputAction: TextInputAction.next,
        decoration: decoration(context),
        onChanged: _onChanged,
        style: style(context),
      ),
    );
  }
}

///An extension used to decorate the [PiixStringOtherSelectTextFormFieldDeprecated] styles, texts and colors
extension _PiixStringOtherSelectTextFormFieldDecoration
    on _PiixStringOtherSelectTextFormFieldState {
  TextStyle labelStyle(BuildContext context) =>
      context.labelSmall?.copyWith(
        color: formField.otherResponse.isNotNullEmpty
            ? PiixColors.azure
            : formField.isEditable
                ? PiixColors.brownishGrey
                : PiixColors.labelText,
      ) ??
      const TextStyle();

  TextStyle floatingLabelStyle(BuildContext context) =>
      context.labelSmall?.copyWith(
        color: formField.otherResponse.isNotNullEmpty
            ? PiixColors.azure
            : formField.isEditable
                ? PiixColors.brownishGrey
                : PiixColors.labelText,
      ) ??
      const TextStyle();

  TextStyle helperStyle(BuildContext context) =>
      context.bodySmall?.copyWith(
        color: formField.otherResponse.isNotNullEmpty
            ? PiixColors.azure
            : formField.isEditable
                ? PiixColors.mainText
                : PiixColors.labelText,
      ) ??
      const TextStyle();

  TextStyle style(BuildContext context) =>
      context.titleSmall?.copyWith(
        color:
            formField.isEditable ? PiixColors.contrast : PiixColors.labelText,
      ) ??
      const TextStyle();

  TextStyle errorStyle(BuildContext context) =>
      context.bodySmall?.copyWith(
        color: PiixColors.errorText,
      ) ??
      const TextStyle();

  InputDecoration decoration(BuildContext context) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasFocus ? PiixColors.azure : PiixColors.gunMetal,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PiixColors.azure,
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PiixColors.errorText,
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PiixColors.errorText,
        ),
      ),
      labelText: PiixCopiesDeprecated.specifyWhich,
      labelStyle: labelStyle(context),
      floatingLabelStyle: floatingLabelStyle(context),
      helperText: formField.required ? PiixCopiesDeprecated.requiredField : '',
      helperStyle: helperStyle(context),
    );
  }
}
