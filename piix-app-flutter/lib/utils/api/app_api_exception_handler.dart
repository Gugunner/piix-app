import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

final class AppApiExceptionHandler {
  static List<int> get _criticalStatusCodes => [
        HttpStatus.badGateway,
        HttpStatus.badRequest,
        HttpStatus.methodNotAllowed,
        HttpStatus.requestTimeout
      ];

  ///Log errors that happen to the api that need to be sent
  ///to the [Crashlytics] logger.
  static void _logDioException(
    DioException exception, {
    required String className,
    Level? level,
  }) {
    final piixApiExceptions = AppApiLogException.fromDioException(exception);
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Exception in $className',
      message: piixApiExceptions.toString(),
      isLoggable: true,
    );
    final statusCode =
        exception.response?.statusCode ?? HttpStatus.internalServerError;
    final sendToCrashlytics = _criticalStatusCodes.contains(statusCode) ||
        exception.type != DioExceptionType.badResponse;
    loggerInstance.log(
        logMessage: logMessage.toString(),
        error: exception,
        level: level ?? Level.error,
        sendToCrashlytics: sendToCrashlytics);
  }

  ///Log errors that happen to the app that need to be sent
  ///to the [Crashlytics] logger.
  static void _logError(
    Object? error, {
    required String className,
    Level? level,
  }) {
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Exception in $className',
      message: error.toString(),
      isLoggable: true,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: error,
      level: level ?? Level.error,
      sendToCrashlytics: true,
    );
  }

  ///Recieves the [className] and the error and
  ///checks if it is a [DioException] that can be treated as
  ///an [AppApiException].
  ///
  ///In either case it treats the [error] and logs it
  ///respectively as either an api or an app error.
  static void handleError(String className, Object error) {
    if (error is DioException) {
      final exception = error;
      _logDioException(exception, className: className);
      final data = exception.response?.data;
      if (data == null) throw exception;
      throw AppApiException.fromJson(data);
  }
    _logError(error, className: className);
    return;
  }
}
