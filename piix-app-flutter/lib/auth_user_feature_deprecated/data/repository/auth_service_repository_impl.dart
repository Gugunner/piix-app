import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

extension AuthServiceRepositoryImpl on AuthServiceRepository {
  Future<CredentialState> sendCredentialRequestedImpl(
      AuthUserModel authModel) async {
    try {
      final response = await serviceApi.sendCredentialApi(authModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return CredentialState.error;
      }
      return CredentialState.sent;
    } on DioError catch (dioError) {
      var credentialState = CredentialState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict) {
        credentialState = CredentialState.conflict;
      } else if (statusCode == HttpStatus.notFound) {
        credentialState = CredentialState.notFound;
      }
      if (credentialState != CredentialState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in sendCredentialRequestedImpl',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.debug,
        );
        return credentialState;
      }
      throw piixApiExceptions;
    }
  }

  Future<dynamic> sendVerificationCodeRequestedImpl(
      AuthUserModel authModel) async {
    try {
      final response = await serviceApi.sendVerificationCodeApi(authModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) {
        throw Exception('Data was not found in the verification code response');
      }
      final data = response.data;
      data['state'] = VerificationCodeState.verified;
      return response.data;
    } on DioError catch (dioError) {
      var credentialState = VerificationCodeState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict) {
        credentialState = VerificationCodeState.conflict;
      }
      if (credentialState != VerificationCodeState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in sendVerificationCode',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.debug,
        );
        return credentialState;
      }
      throw piixApiExceptions;
    }
  }

  Future<dynamic> sendHashableAuthValuesRequestedImpl(
      AuthUserModel authModel) async {
    try {
      final response = await serviceApi.sendHashableAuthValuesApi(authModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        throw Exception('Data was not found in the hashable '
            'auth values response');
      }
      final data = response.data;
      data['state'] = AuthState.authorized;
      return response.data;
    } on DioError catch (dioError) {
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      throw piixApiExceptions;
    }
  }
}
