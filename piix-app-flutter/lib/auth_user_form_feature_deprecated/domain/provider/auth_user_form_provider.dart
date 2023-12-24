import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_exception.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/form_feature/domain/model/form_model_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/answer_request_item_model.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

final authUserFormProvider = ChangeNotifierProvider<AuthUserFormNotifier>(
    (ref) => AuthUserFormNotifier(ref));

class AuthUserFormNotifier extends ChangeNotifier {
  AuthUserFormNotifier(this.ref);

  final ChangeNotifierProviderRef<AuthUserFormNotifier> ref;

  ///State that handles the status of calling [getPersonalInformationForm],
  ///[sendPersonalInformationForm], [getDocumentationForm],
  ///[sendDocumentationForm] and [startMembershipVerification]
  AuthUserFormState _authUserFormState = AuthUserFormState.idle;
  AuthUserFormState get authUserFormState => _authUserFormState;
  void setAuthUserFormState(AuthUserFormState state) {
    _authUserFormState = state;
    notifyListeners();
  }

  ///Injects [FormFieldBLoC] into this
  FormNotifier get formNotifier => ref.read(formNotifierProvider.notifier);

  AuthUserFormRepository get _authUserFormRepository =>
      getIt<AuthUserFormRepository>();

  Future<void> getPersonalInformationForm({
    required String userId,
    required String formId,
  }) async {
    formNotifier.setForm(null);
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setAuthUserFormState(AuthUserFormState.retrieving);
      //Create an AuthUserFormModel for requesting a form
      final formModel = AuthUserFormModel(
        userId: userId,
        mainUserInfoFormId: formId,
      );
      final data =
          await _authUserFormRepository.getPersonalInformationFormRequested(
        formModel,
      );
      //When the data is an AuthUserFormState it means
      //that a specific error was handled with a specific state
      //and the execution should stop.
      if (data is AuthUserFormState) {
        setAuthUserFormState(data);
        return;
      }
      final informationForm = FormModelOld.fromJson(data);
      formNotifier.setForm(informationForm);
      setAuthUserFormState(data['state']);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPersonalInformationForm',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //If any kind of exception or error is thrown that
      //is not directly handled always set
      //the authUserFormState to an retrieve error state.
      setAuthUserFormState(AuthUserFormState.retrieveError);
    }
  }

  Future<void> sendPersonalInformationForm({
    required String userId,
    required String mainUserInfoFormId,
    required List<AnswerRequestItemModel> answers,
    bool useFirebase = true,
    List<AnswerRequestItemModel>? legalAnswers,
  }) async {
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setAuthUserFormState(AuthUserFormState.sending);
      final concatAnswers = [
        ...answers,
      ];
      //Legal answers may be included or not
      if (legalAnswers.isNotNullOrEmpty) {
        concatAnswers.addAll(legalAnswers!);
      }
      //Create a BasicFormAnswerModel for submitting
      //a form with all the answers written by the user
      final answerModel = BasicFormAnswerModel(
        userId: userId,
        answers: concatAnswers,
        mainUserInfoFormId: mainUserInfoFormId,
      );
      final formState =
          await _authUserFormRepository.sendPersonalInformationFormRequested(
        answerModel,
      );
      setAuthUserFormState(formState);
    } catch (e) {
      if (useFirebase) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Error in sendPersonalInformationForm',
          message: e.toString(),
          isLoggable: isApiException(e),
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: e,
          level: Level.error,
          sendToCrashlytics: true,
        );
      }
      _handleFormErrors(e);
    }
  }

  Future<void> getDocumentationForm({
    required String userId,
    required String mainUserInfoFormId,
  }) async {
    formNotifier.setForm(null);
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setAuthUserFormState(AuthUserFormState.retrieving);
      //Create an AuthUserFormModel for requesting a form
      final formModel = AuthUserFormModel(
        userId: userId,
        mainUserInfoFormId: mainUserInfoFormId,
      );
      final data = await _authUserFormRepository.getDocumentationFormRequested(
        formModel,
      );
      //When the data is an AuthUserFormState it means
      //that a specific error was handled with a specific state
      //and the execution should stop.
      if (data is AuthUserFormState) {
        setAuthUserFormState(data);
        return;
      }
      final authUserForm = FormModelOld.fromJson(data);
      formNotifier.setForm(authUserForm);
      setAuthUserFormState(data['state']);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getDocumentationForm',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //If any kind of exception or error is thrown that
      //is not directly handled always set
      //the authUserFormState to an retrieve error state.
      setAuthUserFormState(AuthUserFormState.retrieveError);
    }
  }

  Future<void> sendDocumentationForm({
    required String userId,
    required String mainUserInfoFormId,
    required List<AnswerRequestItemModel> answers,
    List<AnswerRequestItemModel>? legalAnswers,
  }) async {
    try {
      setAuthUserFormState(AuthUserFormState.sending);
      final concatAnswers = [
        ...answers,
      ];
      //Legal answers may be included or not
      if (legalAnswers.isNotNullOrEmpty) {
        concatAnswers.addAll(legalAnswers!);
      }
      //Create a BasicFormAnswerModel for submitting
      //a form with all the answers written by the user
      final answerModel = BasicFormAnswerModel(
        userId: userId,
        mainUserInfoFormId: mainUserInfoFormId,
        answers: concatAnswers,
      );
      final formState =
          await _authUserFormRepository.sendDocumentationFormRequested(
        answerModel,
      );
      setAuthUserFormState(formState);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendDocumentationForm',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      _handleFormErrors(e);
    }
  }

  void _handleFormErrors(Object e) {
    //Some forms can handle special error cases
    //if the error has data in it
    if (e is! AppApiLogException || e.data == null) {
      setAuthUserFormState(AuthUserFormState.sentError);
      return;
    }
    //From the json create a PiixApiError instance to
    //easily access the error data
    final piixApiError = AppApiException.fromJson(e.data!);
    if (piixApiError.errorCodes.isNullOrEmpty) {
      setAuthUserFormState(AuthUserFormState.sentError);
      return;
    }
    //Check for any errors that need handling in the form
    final errorFormState =
        authUserFormState.fromErrorCodes(piixApiError.errorCodes!);
    setAuthUserFormState(errorFormState);
    final responseErrorText = authUserFormState.responseErrorText ?? '';
    switch (authUserFormState) {
      case AuthUserFormState.emailAlreadyUsed:
        formNotifier.addResponseErrorTextToField(
          'email',
          text: responseErrorText,
        );
        break;
      case AuthUserFormState.phoneAlreadyUsed:
        formNotifier.addResponseErrorTextToField(
          'phoneNumber',
          text: responseErrorText,
        );
        formNotifier.addResponseErrorTextToField(
          'protectedPhoneNumber',
          text: authUserFormState.responseErrorText ?? '',
        );
        break;
      case AuthUserFormState.uniqueIdDuplicated:
        formNotifier.addResponseErrorTextToField(
          'uniqueId',
          text: responseErrorText,
        );
        break;
      case AuthUserFormState.documentNotFound:
        formNotifier.addResponseErrorTextToField(
          'user_validation_documents',
          text: responseErrorText,
        );
        break;
      default:
    }
  }

  Future<void> startMembershipVerification({
    required UserAuthenticationStatus status,
  }) async {
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setAuthUserFormState(AuthUserFormState.sending);
      //Call the service to start the process for the user to
      //verify its information by getting the userId from the auth token
      final formState =
          await _authUserFormRepository.startMembershipVerificationRequested();
      setAuthUserFormState(formState);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in startMembershipVerification',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      //If any kind of exception or error is thrown that
      //is not directly handled always set
      //the authUserFormState to an sent error state.
      setAuthUserFormState(AuthUserFormState.sentError);
    }
  }

  Future<void> sendProtectedRegisterForm({
    required String userId,
    required String mainUserInfoFormId,
    required String packageId,
    required List<AnswerRequestItemModel> answers,
    List<AnswerRequestItemModel>? legalAnswers,
  }) async {
    try {
      //Set the state to a loading state to handle any loading effect on the
      //calling widget
      setAuthUserFormState(AuthUserFormState.sending);
      final concatAnswers = [
        ...answers,
      ];
      //Legal answers may be included or not
      if (legalAnswers.isNotNullOrEmpty) {
        concatAnswers.addAll(legalAnswers!);
      }
      //Create a BasicFormAnswerModel for submitting
      //a form with all the answers written by the user
      final answerModel = BasicFormAnswerModel(
        userId: userId,
        answers: concatAnswers,
        mainUserInfoFormId: mainUserInfoFormId,
        packageId: packageId,
      );
      final formState =
          await _authUserFormRepository.sendPersonalInformationFormRequested(
        answerModel,
      );
      setAuthUserFormState(formState);
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in sendProtectedRegisterForm',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      _handleFormErrors(e);
    }
  }

  ///Cleans all the states handled by this provider.
  void clearProvider() {
    _authUserFormState = AuthUserFormState.idle;
    formNotifier.setForm(null);
    notifyListeners();
  }
}
