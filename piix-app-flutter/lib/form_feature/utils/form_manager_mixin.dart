import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show FocusNode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_provider_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///Contains all the methods use to convert a [RequestFormModel] into a
///[ResponseFormModel].
///
///First call [createResponseForm] to convert a [RequestFormModel] into a
///[ResponseFormModel] with tha same number of [AnswerModel] answers as there
/// is a number of [FormFieldModel] form fields.
///
///Call [updateForm] to edit the [answer] value of each [AnswerModel] inside
///the [ResponseFormModel].
///
///If the [Form] is handling a [FocusNode] for each formField to control
///how focus works in each one call [mapToFocusNodes] which returns a list
///of [FocusNode] with the same number of form fields.
///
///IF the [Form] has [FormFieldModel]s with s3 url path in their default
///values then executing [getAsyncImageValues] will prepare the providers
///to obtain the [FileModel] with its [FileContentModel] data.
mixin FormManager {
  AnswerModel _createOrUpdateAnswer(
      {required FormFieldModel formField,
      bool required = false,
      value,
      AnswerModel? oldAnswer}) {
    //Either update the oldAnswer or create a new answer.
    final answerModel = (oldAnswer ??
            AnswerModel(
                formFieldId: formField.formFieldId,
                dataTypeId: formField.dataTypeId))
        .copyWith(
      required: required,
      answer: formField.maybeMap(
        date: (_) {
          if (value is DateTime) {
            return value.toIso8601String();
          }
          return value;
        },
        orElse: () => value,
      ),
      index: formField.index,
    );
    //Checks special case that includes answers that needs to
    //upload the value to S3.
    return formField.maybeMap(
      //Specific types become AnswerS3Models and only the first time
      //the answer is created the value of the xFile of the formField
      //is assigned, this means that only if the form was previusly submitted
      //and a file is present when requesting the form again that the
      //file is assigned.
      document: (value) => answerModel.toAnswerS3Model(
        oldAnswer == null ? value.fileContent : null,
      ),
      selfie: (value) => answerModel.toAnswerS3Model(
        oldAnswer == null ? value.fileContent : null,
      ),
      orElse: () => answerModel,
    );
  }

  ///Lookup an answer by its index reference in the [formField].
  AnswerModel? _getOldAnswer(
          List<AnswerModel> answers, FormFieldModel formField) =>
      answers.firstWhereOrNull((answer) => answer.index == formField.index);

  ///Converts a [RequestFormModel] into a [ResponseFormModel].
  ResponseFormModel createResponseForm(
      {required RequestFormModel requestForm,
      required String userId,
      required FormType formType}) {
    final answers = <AnswerModel>[];

    //TODO: Implement recursive logic if formFields become nested into themselves
    for (final formField in requestForm.formFields) {
      //It will be null since the first time the answer is not there.
      final oldAnswer = _getOldAnswer(answers, formField);
      answers.add(
        _createOrUpdateAnswer(
          formField: formField,
          required: formField.required,
          value: formField.defaultValue,
          oldAnswer: oldAnswer,
        ),
      );
    }
    return ResponseFormModel(
      mainUserInfoFormId: requestForm.formId,
      userId: userId,
      answers: answers,
      formType: formType,
    );
  }

  ///Returns a copy of the [responseForm] with
  ///the updated answer [value] for a specific
  ///[formField]
  ResponseFormModel updateForm({
    required ResponseFormModel responseForm,
    required FormFieldModel formField,
    bool required = true,
    value,
  }) {
    //It will obtain the old answer to be updated.
    final oldAnswer = _getOldAnswer(responseForm.answers, formField);
    //TODO: Implement recursive logic if formFields become nested into themselves
    final answer = _createOrUpdateAnswer(
        formField: formField,
        required: required,
        value: value,
        oldAnswer: oldAnswer);
    final answers = responseForm.answers
        .updateIndexValue<AnswerModel>(formField.index, value: answer);
    return responseForm.copyWith(answers: answers);
  }

  ///Generates the same number of focus nodes as form fields has
  ///the [requestForm].
  List<FocusNode> mapToFocusNodes(RequestFormModel requestForm) =>
      requestForm.formFields.map((_) => FocusNode()).toList();

  ///Gets each defaultValue from the formFields [requestForm] and each answer
  ///from the [responseForm] and compares each element if it
  ///has the same [index].
  bool equalDefaultValuesToAnswers(
      RequestFormModel requestForm, ResponseFormModel responseForm) {
    //Gets all indexes from the form fields of the requestForm
    //index should be set in the answer when first loading a form.
    final indexes = requestForm.formFields.map((formField) => formField.index);
    //Compares the form field and answer values with the same index.
    for (final index in indexes) {
      //Since the index could be out of boundes it can return null
      final formField = requestForm.formFields
          .firstWhereOrNull((formField) => formField.index == index);
      final formFieldValue = formField?.maybeMap(
            date: (value) => value.defaultValue?.toIso8601String(),
            orElse: () => formField.defaultValue,
          ) ??
          '';
      //Since the index could be out of boundes it can return null
      final answerValue = responseForm.answers
              .firstWhereOrNull((answer) => answer.index == index)
              ?.answer ??
          '';
      //If it is not the same value then it is not equal.
      if (formFieldValue != answerValue) return false;
    }
    //If the loop finishes it means that it is equal.
    return true;
  }

  ///Retrieves the [AsyncValue]s and index of each [FormFieldModel]
  ///that contains a [path] referencing the S3 bucket where the
  ///image is contained.
  ///
  ///Filters any value that is returned as null to only retrieve the
  ///values that have an [AsyncValue] and index, if no [FormFieldModel]
  ///has values it returns an empty list.
  List<(AsyncValue<FileContentModel>, int)> getAsyncImageValues(
    List<FormFieldModel> formFields, {
    required String userId,
    required WidgetRef ref,
  }) {
    return formFields
        .map((formField) {
          final filePath = formField.defaultValue;
          //If there is no value then it returns null.
          if (filePath == null) return null;
          //Builds a RequestFileModel used to reques the file from S3.
          final name = '${formField.formFieldId}_${formField.index}';
          final requestModel = RequestFileModel(
            userId: userId,
            filePath: filePath,
            propertyName: name,
          );
          //Only returns a valid value for the [FormFieldModel] that can
          //have an S3 path.
          return formField.maybeMap(
            document: (value) =>
                (ref.watch(requestFilePodProvider(requestModel)), value.index),
            selfie: (value) =>
                (ref.watch(requestFilePodProvider(requestModel)), value.index),
            orElse: () => null,
          );
        })
        .whereNotNull()
        .toList();
  }
}
