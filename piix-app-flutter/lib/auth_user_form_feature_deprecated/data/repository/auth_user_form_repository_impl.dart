import 'package:dio/dio.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

extension AuthUserFormRepositoryImpl on AuthUserFormRepository {
  Future<dynamic> getPersonalInformationFormRequestedImpl(
      AuthUserFormModel formModel) async {
    try {
      final response =
          await authUserFormApi.getPersonalInformationFormApi(formModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) return AuthUserFormState.retrieveError;
      response.data['state'] = AuthUserFormState.retrieved;
      return response.data;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }

  Future<AuthUserFormState> sendPersonalInformationFormRequestedImpl(
      BasicFormAnswerModel answerModel) async {
    try {
      final response =
          await authUserFormApi.sendPersonalInformationFormApi(answerModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return AuthUserFormState.sentError;
      }
      return AuthUserFormState.sent;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }

  Future<dynamic> getDocumentationFormRequestedImpl(
      AuthUserFormModel formModel) async {
    try {
      final response = await authUserFormApi.getDocumentationFormApi(formModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) return AuthUserFormState.retrieveError;
      response.data['state'] = AuthUserFormState.retrieved;
      return response.data;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }

  Future<AuthUserFormState> sendDocumentationFormRequestedImpl(
      BasicFormAnswerModel answerModel) async {
    try {
      final response =
          await authUserFormApi.sendDocumentationFormApi(answerModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return AuthUserFormState.sentError;
      }
      return AuthUserFormState.sent;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }

  Future<AuthUserFormState> sendProtectedRegisterFormRequestedImpl({
    required BasicFormAnswerModel answerModel,
    bool useFirebase = true,
  }) async {
    try {
      final response =
          await authUserFormApi.sendProtectedRegisterFormApi(answerModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return AuthUserFormState.sentError;
      }
      return AuthUserFormState.sent;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }

  Future<AuthUserFormState> startMembershipVerificationRequestedImpl() async {
    try {
      final response = await authUserFormApi.startMembershipVerificationApi();
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return AuthUserFormState.sentError;
      }
      return AuthUserFormState.sent;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }
}
