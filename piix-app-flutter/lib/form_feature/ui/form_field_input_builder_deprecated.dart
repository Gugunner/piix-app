// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_document_input_deprecated/piix_document_input_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_date_text_form_field_deprecated/piix_date_text_form_field_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_display_text_deprecated/piix_display_text_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_number_text_form_field_deprecated/piix_number_text_form_field_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_object_select_dropdown_button_deprecated/piix_object_select_drop_down_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_phone_number_input_deprecated/piix_phone_number_input_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_section_input_deprecated/piix_section_container_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_signature_input_deprecated/piix_signature_input_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_multiple_select_dropdown_button_deprecated/piix_string_multiple_select_dropdown_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_unique_select_dropdown_button_deprecated/piix_string_unique_select_dropdown_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_text_form_field_deprecated/piix_string_text_form_field_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_time_text_form_field_deprecated/piix_time_text_form_field_deprecated.dart';

@Deprecated('Will be removed in 4.0')
//TODO: Refactor with new inputs
///Widget that builds any of the form fields that are used inside a [Form]
///and comply with [FormFieldModelOld].
///
/// Any new FormField must be called from inside the build method and not
/// independently in a Widget. To keep code as maintainable as possible only
/// pass the [formField] argument to each form field widget instance.
class FormFieldInputBuilderDeprecated extends ConsumerWidget {
  const FormFieldInputBuilderDeprecated({
    Key? key,
    required this.formField,
    this.isLoading = false,
  }) : super(key: key);

  ///A data model that contains all the information to render a form field.
  final FormFieldModelOld formField;
  final bool isLoading;

  ///Tha type which defines what form field to build.
  String get dataTypeId => formField.dataTypeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Keep this line so the widget can rebuild when the form field changes
    ref.watch(formNotifierProvider);

    if (isLoading) {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        width: context.width,
        height: 40.h,
        child: const Card(),
      );
    }

    return formField.map(
      (value) => const SizedBox(),
      string: (value) => PiixStringTextFormFieldDeprecated(formField: value),
      time: (value) => PiixTimeTextFormFieldDeprecated(formField: value),
      unique: (value) =>
          PiixStringSelectDropDownButtonDeprecated(formField: value),
      multiple: (value) =>
          PiixStringMultipleSelectDropdownButtonDeprecated(formField: value),
      signature: (value) => PiixSignatureFormFieldDeprecated(formField: value),
      section: (value) => PiixSectionContainerDeprecated(formField: value),
      phone: (value) => PiixPhoneNumberInputDeprecated(formField: value),
      object: (value) =>
          PiixObjectSelectDropDownButtonDeprecated(formField: value),
      number: (value) => PiixNumberTextFormFieldDeprecated(formField: value),
      document: (value) => PiixDocumentInputDeprecated(formField: value),
      display: (value) => PiixDisplayTextDeprecated(formField: value),
      date: (value) => PiixDateTextFormFieldDeprecated(formField: value),
    );
  }
}
