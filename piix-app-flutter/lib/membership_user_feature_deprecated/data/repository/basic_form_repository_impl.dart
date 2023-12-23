import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

///Handles all real request implementations api calls of basic form repository
extension BasicFormRepositoryImplementation on BasicFormRepository {
  Future<dynamic> getBasicFormRequestedImpl(
      RequestBasicFormModel requestModel) async {
    try {
      final response = await formApi.getUserBasicFormApi(requestModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          response.data['state'] = BasicFormState.retrieved;
          return response.data;
        }
      }
      return BasicFormState.retrieveError;
    } on DioError catch (dioError) {
      var basicFormState = BasicFormState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict ||
          statusCode == HttpStatus.notFound) {
        basicFormState = BasicFormState.notFound;
      }
      if (basicFormState != BasicFormState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getBasicFormRequestedImpl with id '
              '${requestModel.mainUserInfoFormId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return basicFormState;
      }
      throw piixApiExceptions;
    }
  }

  Future<BasicFormState> sendBasicFormRequestedImpl(
      BasicFormProtectedAnswerModel answerModel) async {
    try {
      final response = await formApi.sendBasicFormApi(answerModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return BasicFormState.sent;
      }
      return BasicFormState.sendError;
    } on DioError catch (dioError) {
      var basicFormState = BasicFormState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        basicFormState = BasicFormState.notFound;
      }
      if (basicFormState != BasicFormState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in sendBasicFormRequestedImpl with id '
              '${answerModel.mainUserInfoFormId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return basicFormState;
      }
      throw piixApiExceptions;
    }
  }
}
