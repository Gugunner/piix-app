import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

mixin LogApiCall {
  void logDioException(
    DioException dioError, {
    required String className,
    Level? level,
  }) {
    final piixApiExceptions = AppApiLogException.fromDioException(dioError);
    final loggerInstance = PiixLogger.instance;
    final logMessage = loggerInstance.errorMessage(
      messageName: 'Exception in $className',
      message: piixApiExceptions.toString(),
      isLoggable: true,
    );
    loggerInstance.log(
      logMessage: logMessage.toString(),
      error: dioError,
      level: level ?? Level.error,
    );
  }
}

mixin LogAppCall {
  void logError(
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
    );
  }
}

mixin LogAnalytics {
  void logEvent(
          {required String eventName, Map<String, dynamic>? eventParameters}) =>
      PiixAnalytics.instance
          .logEvent(eventName: eventName, eventParameters: eventParameters);
}
