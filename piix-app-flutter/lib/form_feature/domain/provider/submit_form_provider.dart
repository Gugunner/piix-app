import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/data/repository/form_repository.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/utils/api/app_api_exception_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submit_form_provider.g.dart';

@riverpod
final class SubmitFormPod extends _$SubmitFormPod with PrivacyAnswerManager {
  String get _className => 'SubmitFormPod';

  @override
  Future<void> build({
    required ResponseFormModel responseForm,
    required FormGroup formGroup,
    BuildContext? context,
  }) async {
    List<AnswerModel> additionalAnswers;
    try {
      additionalAnswers = await _getAdditionalAnswers();
    } catch (e) {
      additionalAnswers = [];
    }
    final enhancedForm = responseForm.copyWith(
      answers: [
        ...responseForm.answers,
        ...additionalAnswers,
      ],
    );
    switch (formGroup) {
      case FormGroup.personal:
        return _sendPersonalInformationForm(enhancedForm, context);
      case FormGroup.documentation:
        return _sendDocumentationForm(enhancedForm);
    }
  }

  ///Returns a list of the signedHour, signedDate, signedIp and
  ///signedLocation [AnswerModel]s.
  ///
  ///It will only return values that are not null.
  Future<List<AnswerModel>> _getAdditionalAnswers() async {
    final signedHour = getSignedHour();
    final signedDate = getSignedDate();
    final signedIp = await getSignedIp();
    final signedLocation = await getSignedLocation();
    return [signedHour, signedDate, signedIp, signedLocation]
        .whereNotNull()
        .toList();
  }

  Future<void> _sendPersonalInformationForm(
      ResponseFormModel responseForm, BuildContext? context) async {
    try {
      //Obtains the user language and adds the answer to the
      //a new complete form.
      final userLanguageAnswer = getUserLanguage(context!);
      final completeResponseForm = responseForm.copyWith(
        answers: [
          ...responseForm.answers,
          userLanguageAnswer,
        ],
      );
      return await ref
          .read(formRepositoryPod)
          .sendBasicForm(completeResponseForm);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }

  Future<void> _sendDocumentationForm(
    ResponseFormModel responseForm,
  ) async {
    try {
      return await ref.read(formRepositoryPod).sendBasicForm(responseForm);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
