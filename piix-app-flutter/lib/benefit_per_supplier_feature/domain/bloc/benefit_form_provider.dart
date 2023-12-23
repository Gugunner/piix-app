import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_form_model.dart';
import 'package:piix_mobile/email_feature/domain/bloc/email_system_bloc.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_answer_provider_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';

final benefitFormProvider = ChangeNotifierProvider<BenefitFormNotifier>(
    (ref) => BenefitFormNotifier(ref));

/// This BLoC is Benefit Form fields are stored.
class BenefitFormNotifier extends ChangeNotifier {
  BenefitFormNotifier(this.ref);

  final ChangeNotifierProviderRef<BenefitFormNotifier> ref;

  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  String? _currentBenefitFormId;
  String? get currentBenefitFormId => _currentBenefitFormId;
  set currentBenefitFormId(String? value) {
    _currentBenefitFormId = value;
    notifyListeners();
  }

  ///Injects [FormFieldBLoC] into this
  FormNotifier get formNotifier => ref.read(formNotifierProvider.notifier);

  // BenefitFormModel? _benefitForm;
  FormModelOld? get benefitForm => formNotifier.state;
  set benefitForm(FormModelOld? benefitForm) {
    formNotifier.setForm(benefitForm);
    notifyListeners();
  }

  ///Updates the [formFields] property of [benefitForm] if the form is
  ///not null.
  set benefitFormFields(List<FormFieldModelOld> formFields) {
    if (benefitForm != null) {
      benefitForm = benefitForm!.copyWith(
        formFields: formFields,
      );
      notifyListeners();
    }
  }

  ///Returns either the [formFields] list of [benefitForm] if the
  ///form is not null otherwise returns an empty list.
  List<FormFieldModelOld> get benefitFormFields {
    if (benefitForm != null) {
      return benefitForm!.formFields;
    }
    return [];
  }

  BenefitFormStateDeprecated _benefitFormState =
      BenefitFormStateDeprecated.idle;
  BenefitFormStateDeprecated get benefitFormState => _benefitFormState;
  set benefitFormState(BenefitFormStateDeprecated state) {
    _benefitFormState = state;
    notifyListeners();
  }

  ///Injection of [BenefitFormRepositoryDeprecated]
  BenefitFormRepositoryDeprecated get _benefitFormRepository =>
      getIt<BenefitFormRepositoryDeprecated>();

  ///Injection of [FileSystemBLoC]
  FileSystemBLoC get _fileSystemBLoC => getIt<FileSystemBLoC>();

  ///Injection of [EmailSystemBLoC]
  EmailSystemBLoC get _emailSystemBLoC => getIt<EmailSystemBLoC>();

  ///Injection of [BenefitPerSupplierBLoCDeprecated]
  BenefitPerSupplierBLoCDeprecated get _benefitPerSupplierBLoC =>
      getIt<BenefitPerSupplierBLoCDeprecated>();

  ///Retrieves the data to store a [benefitForm], if the data is
  ///a [BenefitFormStateDeprecated] the [benefitFormState] is set.
  ///
  ///If an error occurs the [benefitFormState] sets an error
  ///and no data is stored in [benefitForm]. When the data is valid
  ///a [benefitForm] stores the information created by [FormModelOld] fromJson method.
  Future<void> getBenefitForm() async {
    formNotifier.setForm(null);
    try {
      final requestModel = RequestBenefitFormModel(
        benefitFormId: currentBenefitFormId!,
      );
      benefitFormState = BenefitFormStateDeprecated.retrieving;
      final data = await _benefitFormRepository
          .getBenefitFormRequested(requestModel, test: appTest);
      if (data is BenefitFormStateDeprecated) {
        benefitFormState = data;
      } else {
        benefitForm = FormModelOld.fromJson(data);
        benefitFormState = data['state'];
      }
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getBenefitForm with id $currentBenefitFormId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      benefitFormState = BenefitFormStateDeprecated.retrievedError;
    }
  }

  ///This method build a benefit form answers, add benefit forma answers and
  ///legal answers
  ///
  Future<List<AnswerRequestItemModel>> processBenefitFormAnswers({
    required FormModelOld benefitForm,
    required ByteData screenshotForm,
  }) async {
    try {
      benefitFormState = BenefitFormStateDeprecated.sending;
      final benefitFormFields = benefitForm.formFields;
      final legalAnswerNotifier = ref.read(formAnswersProvider);
      final newFormFields = await legalAnswerNotifier
          .checkFormForS3ImagesUploads(benefitFormFields);
      if (_fileSystemBLoC.fileState == FileStateDeprecated.uploadError) {
        throw Exception('One or more images could not be uploaded to S3');
      }
      final answers = legalAnswerNotifier.responsesToAnswers(newFormFields);
      final legalPdfCopyAnswer = await legalAnswerNotifier.processLegalPdfCopy(
        screenshotForm: screenshotForm,
      );
      if (legalPdfCopyAnswer == null) {
        formNotifier
            .setForm(formNotifier.state?.copyWith(formFields: newFormFields));
        throw Exception('The legal pdf copy could not be obtained');
      }
      final legalAnswers = await legalAnswerNotifier.getLegalAnswers();
      if (ref.read(legalAnswerStateNotifierProvider) ==
              LegalAnswerState.error ||
          legalAnswers.isEmpty) {
        formNotifier
            .setForm(formNotifier.state?.copyWith(formFields: newFormFields));
        throw Exception('The legal answers could not be obtained');
      }
      answers.addAll(
        [
          ...legalAnswers,
          legalPdfCopyAnswer,
        ],
      );
      return answers;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in processBenefitFormAnswers '
            'when sending benefit form with id ${benefitForm.formId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );

      return [];
    }
  }

  ///This future send benefit form answers
  ///
  Future<void> sendBenefitForm({
    required UserAppModel user,
    required String packageId,
    required FormModelOld benefitForm,
    required List<AnswerRequestItemModel> answers,
    required String? benefitPerSupplierId,
    required String? cobenefitPerSupplierId,
    required String? additionalBenefitPerSupplierId,
  }) async {
    try {
      benefitFormState = BenefitFormStateDeprecated.sending;
      final answerModel = BenefitFormAnswerModel(
        userId: user.userId,
        benefitFormId: benefitForm.formId,
        packageId: packageId,
        answers: answers,
        benefitPerSupplierId: benefitPerSupplierId,
        cobenefitPerSupplierId: cobenefitPerSupplierId,
        additionalBenefitPerSupplierId: additionalBenefitPerSupplierId,
      );

      final state = await _benefitFormRepository.sendBenefitFormRequested(
        answerModel,
        test: appTest,
      );
      if (state == BenefitFormStateDeprecated.sent && user.email != null) {
        await _shouldSendToEmail(
          answers,
          user,
          benefitForm,
        );
      }
      benefitFormState = state;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendBenefitForm with id ${benefitForm.formId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      benefitFormState = BenefitFormStateDeprecated.sendError;
    }
  }

  ///This method sends email with benefit form to user
  ///
  Future<void> _shouldSendToEmail(
    List<AnswerRequestItemModel> answerList,
    UserAppModel user,
    FormModelOld benefitForm,
  ) async {
    await ref.read(formAnswersProvider).uploadCsvToS3(answerList);
    final benefit = !_benefitPerSupplierBLoC.isCobenefit
        ? _benefitPerSupplierBLoC.selectedBenefitPerSupplier
            ?.mapOrNull((value) => value)
            ?.benefit
        : _benefitPerSupplierBLoC.selectedCobenefitPerSupplier
            ?.mapOrNull((value) => null, cobenefit: (value) => value)
            ?.benefit;
    if (_fileSystemBLoC.fileState == FileStateDeprecated.uploaded &&
        benefit != null) {
      final benefitName = benefit.name;
      final pdfName = '${user.userId}_${benefitForm.formId}';
      final currentDate = DateTime.now().toString().split(' ')[0];
      await _emailSystemBLoC.sendEmail(
        userId: user.userId,
        benefitName: benefitName,
        displayNames: ['${user.displayName}'],
        emails: [user.email!],
        fileNames: [
          '${currentDate}_$pdfName.pdf',
        ],
        paths: [
          ref.read(pdfPathNotifierProvider),
        ],
      );
    }
  }

  /// Clear BLoC state.
  void clearProvider() {
    _currentBenefitFormId = null;
    _benefitFormState = BenefitFormStateDeprecated.idle;
    notifyListeners();
  }
}
