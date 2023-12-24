import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository_impl.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository_test.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/service/auth_user_form_api.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

//TODO: Add additional errors

enum AuthUserFormState {
  idle,
  retrieving,
  retrieved,
  retrieveError,
  sending,
  sent,
  sentError,
  emailAlreadyUsed,
  phoneAlreadyUsed,
  uniqueIdDuplicated,
  documentNotFound,
  //TODO: Add additional errors
  ready;

  AuthUserFormState fromErrorCodes(List<String> errorCodes) {
    //PERSONAL INFORMATION
    const emailAlreadyUsed = 'EMAIL_ALREADY_USED';
    const phoneAlreadyUsed = 'PHONE_NUMBER_ALREADY_USED';
    //DOCUMENTATION
    const uniqueIdInUser = 'UNIQUE_ID_ALREADY_USED';
    const documentNotFound = 'DOCUMENT_DOES_NOT_EXISTS';
    if (errorCodes.contains(emailAlreadyUsed)) {
      return AuthUserFormState.emailAlreadyUsed;
    } else if (errorCodes.contains(phoneAlreadyUsed)) {
      return AuthUserFormState.phoneAlreadyUsed;
    } else if (errorCodes.contains(uniqueIdInUser)) {
      return AuthUserFormState.uniqueIdDuplicated;
    } else if (errorCodes.contains(documentNotFound)) {
      return AuthUserFormState.documentNotFound;
    }
    return AuthUserFormState.sentError;
  }

  String? get responseErrorText {
    if (this == AuthUserFormState.emailAlreadyUsed) {
      return AuthUserCopies.alreadyUsedEmail;
    } else if (this == AuthUserFormState.phoneAlreadyUsed) {
      return AuthUserCopies.alreadyUsedPhone;
    } else if (this == AuthUserFormState.uniqueIdDuplicated) {
      return AuthUserCopies.uniqueIdDuplicated;
    } else if (this == AuthUserFormState.documentNotFound) {
      return AuthUserCopies.documentNotFound;
    }
    return null;
  }
}

class AuthUserFormRepository {
  const AuthUserFormRepository(this.authUserFormApi);

  final AuthUserFormApi authUserFormApi;

  Future<dynamic> getPersonalInformationFormRequested(
      AuthUserFormModel formModel,
      [bool test = false]) async {
    if (test) {
      return getPersonalInformationFormRequestedTest(formModel);
    }
    return getPersonalInformationFormRequestedImpl(formModel);
  }

  Future<AuthUserFormState> sendPersonalInformationFormRequested(
      BasicFormAnswerModel answerModel,
      [bool test = false]) async {
    if (test) {
      return sendPersonalInformationFormRequestedTest(answerModel);
    }
    return sendPersonalInformationFormRequestedImpl(answerModel);
  }

  Future<dynamic> getDocumentationFormRequested(AuthUserFormModel formModel,
      [bool test = false]) async {
    if (test) {
      return getDocumentationFormRequestedTest(formModel);
    }
    return getDocumentationFormRequestedImpl(formModel);
  }

  Future<AuthUserFormState> sendDocumentationFormRequested(
      BasicFormAnswerModel answerModel,
      [bool test = false]) async {
    if (test) {
      return sendDocumentationFormRequestedTest(answerModel);
    }
    return sendDocumentationFormRequestedImpl(answerModel);
  }

  Future<AuthUserFormState> sendProtectedRegisterFormRequested(
    BasicFormAnswerModel answerModel, [
    bool test = false,
    bool useFirebase = true,
  ]) async {
    if (test) {
      return sendProtectedRegisterFormRequestedTest(answerModel);
    }
    return sendProtectedRegisterFormRequestedImpl(
      answerModel: answerModel,
      useFirebase: useFirebase,
    );
  }

  Future<AuthUserFormState> startMembershipVerificationRequested(
      [bool test = false]) async {
    if (test) {
      return startMembershipVerificationRequestedTes();
    }
    return startMembershipVerificationRequestedImpl();
  }
}
