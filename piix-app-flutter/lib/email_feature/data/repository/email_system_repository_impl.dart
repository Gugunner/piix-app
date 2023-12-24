import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/email_feature/data/repository/email_system_repository.dart';
import 'package:piix_mobile/email_feature/domain/model/request_email_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

extension EmailSystemRepositoryImplementation on EmailSystemRepository {
  Future<EmailState> sendEmailRequestedImpl(
      RequestEmailModel requestEmail) async {
    try {
      final response = await emailApi.sendEmailApi(requestEmail);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return EmailState.sent;
      }
      return EmailState.error;
    } on DioError catch (dioError) {
      var emailState = EmailState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        emailState = EmailState.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        emailState = EmailState.error;
      }
      if (emailState != EmailState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in sendEmailRequestedImpl '
              'sending the benefit ${requestEmail.benefitName}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return emailState;
      }
      throw piixApiExceptions;
    }
  }
}
