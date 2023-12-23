// ignore_for_file: avoid_annotating_with_dynamic

import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/date_text_form_field/date_text_form_field_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/dropdown_field/dropdown_field_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

final class FormFieldModelBuilder extends StatelessWidget {
  const FormFieldModelBuilder({
    super.key,
    required this.formField,
    required this.totalFields,
    this.focusNode,
    this.onChanged,
    this.onSaved,
    this.onHandleForm,
    this.apiException,
  });

  final FormFieldModel formField;

  final int totalFields;

  final FocusNode? focusNode;

  final ValueChanged<dynamic>? onChanged;

  final Function(dynamic value)? onSaved;

  final HandleFormValue? onHandleForm;

  final AppApiException? apiException;

  @override
  Widget build(BuildContext context) {
    if (formField.isHidden) return const SizedBox();
    final textInputAction = formField.index < totalFields - 1
        ? TextInputAction.next
        : TextInputAction.done;
    return formField.map(text: (field) {
      switch (field.textType) {
        case TextType.email:
          return EmailFormField(
            index: field.index,
            readOnly: !field.isEditable,
            required: field.required,
            newFocusNode: focusNode,
            handleFocusNode: true,
            initialValue: field.defaultValue,
            onChanged: onChanged,
            onSaved: onSaved,
            onHandleForm: onHandleForm,
            textInputAction: textInputAction,
            apiException: apiException,
          );
        case TextType.name:
          return NameFormField(
            index: field.index,
            readOnly: !field.isEditable,
            required: field.required,
            newFocusNode: focusNode,
            handleFocusNode: true,
            initialValue: field.defaultValue,
            onChanged: onChanged,
            onSaved: onSaved,
            onHandleForm: onHandleForm,
            textInputAction: textInputAction,
            apiException: apiException,
            labelText: field.name,
          );
        case TextType.text:
          return GeneralTextFormField(
            index: field.index,
            readOnly: !field.isEditable,
            required: field.required,
            newFocusNode: focusNode,
            handleFocusNode: true,
            initialValue: field.defaultValue,
            onChanged: onChanged,
            onSaved: onSaved,
            onHandleForm: onHandleForm,
            textInputAction: textInputAction,
            apiException: apiException,
            labelText: field.name,
            //Checks if required and empty value
            validator: (String? value) {
              final localeMessage = context.localeMessage;
              if (formField.required && value.isNullOrEmpty)
                return localeMessage.emptyField;
              return null;
            },
          );
      }
    }, phone: (field) {
      //TODO: Implement PhoneInputField
      return const SizedBox();
    }, date: (field) {
      return GeneralDateTextFormField(
        index: field.index,
        required: field.required,
        newFocusNode: focusNode,
        handleFocusNode: true,
        initialDate: field.defaultValue,
        onChanged: onChanged,
        onSaved: onSaved,
        onSelectDate: onHandleForm,
        textInputAction: textInputAction,
        apiException: apiException,
        labelText: field.name,
        suffixIconData: Icons.calendar_today,
      );
    }, uniqueIdSelect: (field) {
      return UniqueIdSelectDropdownField(
        onChanged: onChanged,
        values: field.values,
        index: field.index,
        required: field.required,
        readOnly: !field.isEditable,
        newFocusNode: focusNode,
        handleFocusNode: true,
        initialValue: field.defaultValue,
        onSaved: onSaved,
        onHandleForm: onHandleForm,
        labelText: field.name,
      );
    }, document: (field) {
      
      return IdentificationFormField(
        index: field.index,
        required: field.required,
        readOnly: !field.isEditable,
        cameraSilhouette: field.cameraSilhouette,
        onSaved: onSaved,
        onChanged: onChanged,
        onHandleForm: onHandleForm,
        initialPicture: field.fileContent,
        newFocusNode: focusNode,
        labelText: field.name,
        apiException: apiException,
      );
    }, selfie: (field) {
      
      return SelfieFormField(
        index: field.index,
        required: field.required,
        readOnly: !field.isEditable,
        cameraSilhouette: field.cameraSilhouette,
        onSaved: onSaved,
        onChanged: onChanged,
        onHandleForm: onHandleForm,
        initialPicture: field.fileContent,
        newFocusNode: focusNode,
        labelText: field.name,
        apiException: apiException,
      );
    });
  }
}
