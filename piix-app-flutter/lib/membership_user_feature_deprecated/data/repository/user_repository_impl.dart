import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/user_credential_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/domain/model/update_credential_model.dart';

//TODO: Add documentation
extension UserRepositoryImplementation on UserRepositoryDeprecated {
  Future<dynamic> getUserByEmailRequestedImpl(
      UserCredentialModel credentialModel) async {
    try {
      final response = await userApi.getUserByEmailApi(credentialModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) {
        return UserActionStateDeprecated.error;
      }
      response.data['state'] = UserActionStateDeprecated.retrieved;
      return response.data;
    } on DioError catch (dioError) {
      var userActionState = UserActionStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        userActionState = UserActionStateDeprecated.notFound;
      }
      if (userActionState != UserActionStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getUserByEmailRequestedImpl',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.debug,
        );
        return userActionState;
      }
      throw piixApiExceptions;
    }
  }

  Future<dynamic> getUserByPhoneRequestedImpl(
      UserCredentialModel credentialModel) async {
    try {
      final response = await userApi.getUserByPhoneApi(credentialModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) {
        return UserActionStateDeprecated.error;
      }
      response.data['state'] = UserActionStateDeprecated.retrieved;
      return response.data;
    } on DioError catch (dioError) {
      var userActionState = UserActionStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        userActionState = UserActionStateDeprecated.notFound;
      }
      if (userActionState != UserActionStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getUserByPhoneRequestedImpl',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.debug,
        );
        return userActionState;
      }
      throw piixApiExceptions;
    }
  }

  Future<dynamic> getUserLevelsAndPlansRequestedImpl() async {
    try {
      final response = await userApi.getUserLevelAndPlansApi();
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = <String, dynamic>{};
          data['state'] = UserActionStateDeprecated.retrieved;
          data['memberships'] = response.data;
          return data;
        }
      }
    } on DioError catch (dioError) {
      var userActionState = UserActionStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        userActionState = UserActionStateDeprecated.notFound;
      }
      if (userActionState != UserActionStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getUserLevelsAndPlansRequestedImpl',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return userActionState;
      }
      throw piixApiExceptions;
    }
  }

  Future<UserActionStateDeprecated> updateUserEmailRequestedImpl(
    UpdateEmailRequestModel requestModel,
  ) async {
    try {
      final response = await userApi.updateUserEmailApi(requestModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return UserActionStateDeprecated.updated;
      }
      return UserActionStateDeprecated.errorUpdating;
    } on DioError catch (dioError) {
      var userActionState = UserActionStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        userActionState = UserActionStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        userActionState = UserActionStateDeprecated.alreadyExists;
      }
      if (userActionState != UserActionStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in updateUserEmailRequestedImpl',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.debug,
        );
        return userActionState;
      }
      throw piixApiExceptions;
    }
  }

  Future<UserActionStateDeprecated> updateUserPhoneNumberRequestedImpl(
    UpdatePhoneNumberRequestModel requestModel,
  ) async {
    try {
      final response = await userApi.updateUserPhoneNumberApi(requestModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return UserActionStateDeprecated.updated;
      }
      return UserActionStateDeprecated.errorUpdating;
    } on DioError catch (dioError) {
      var userActionState = UserActionStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        userActionState = UserActionStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        userActionState = UserActionStateDeprecated.alreadyExists;
      }
      if (userActionState != UserActionStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in updateUserPhoneNumberRequestedImpl',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.debug,
        );
        return userActionState;
      }
      throw piixApiExceptions;
    }
  }
}
