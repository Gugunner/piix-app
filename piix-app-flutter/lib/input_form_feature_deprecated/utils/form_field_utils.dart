import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/ui/form_field_input_builder_deprecated.dart';

Iterable<Widget> buildFormFields(List<FormFieldModelOld> formFields,
    [bool isLoading = false]) {
  Widget buildFormField(FormFieldModelOld formField) =>
      FormFieldInputBuilderDeprecated(
        isLoading: isLoading,
        formField: formField,
      );

  return formFields.map(
    buildFormField,
  );
}
