import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_form_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

///Handles all real request implementations api calls of basic form repository
extension BenefitRepositoryImplementation on BenefitFormRepositoryDeprecated {
  Future<dynamic> getBenefitFormRequestedImpl(
      RequestBenefitFormModel requestModel) async {
    try {
      final response = await formApi.getBenefitFormApi(requestModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) {
        return BenefitFormStateDeprecated.retrievedError;
      }
      response.data['state'] = BenefitFormStateDeprecated.retrieved;
      return response.data;
    } on DioError catch (dioError) {
      var benefitFormState = BenefitFormStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        benefitFormState = BenefitFormStateDeprecated.notFound;
      }
      if (benefitFormState != BenefitFormStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getBenefitFormRequestedImpl '
              '- ${requestModel.benefitFormId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return benefitFormState;
      }
      throw piixApiExceptions;
    }
  }

  Future<dynamic> sendBenefitFormRequestedImpl(
      BenefitFormAnswerModel answerModel) async {
    try {
      final response = await formApi.sendBenefitFormApi(answerModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return BenefitFormStateDeprecated.sendError;
      }
      return BenefitFormStateDeprecated.sent;
    } on DioError catch (dioError) {
      var benefitFormState = BenefitFormStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        benefitFormState = BenefitFormStateDeprecated.notFound;
      }
      if (benefitFormState != BenefitFormStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in sendBenefitFormRequestedImpl '
              'with id ${answerModel.benefitFormId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return benefitFormState;
      }
      throw piixApiExceptions;
    }
  }
}
