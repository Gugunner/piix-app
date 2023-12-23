import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';

enum PiixLoggerBuild {
  debug,
  profile,
  release,
}

class PiixLogger {
  PiixLogger._();

  final logger = Logger(filter: PiixLoggerFilter());

  static final instance = PiixLogger._();

  Map<String, dynamic> errorMessage({
    required String messageName,
    String? message,
    bool isLoggable = true,
  }) {
    return {
      'Name': messageName,
      'Message': message,
      'Exception': isLoggable ? 'Piix Api Exception' : 'Piix App Exception',
    };
  }

  void log({
    required String logMessage,
    required Level level,
    Object? error,
    StackTrace? stackTrace,
    bool sendToCrashlytics = false,
  }) {
    StackTrace? piixStackTrace;

    if (error is AppApiLogException) {
      piixStackTrace = error.stackTrace;
    } else if (error is DioError) {
      piixStackTrace = error.stackTrace;
    } else {
      piixStackTrace = PiixStringStackTrace(
        error == null ? '' : error.toString(),
      );
    }
    logger.log(
      level,
      logMessage,
      error,
      stackTrace ?? piixStackTrace,
    );
    final appUserId = getIt<AuthServiceProvider>().user?.userId ??
        getIt<UserBLoCDeprecated>().user?.userId ??
        'none';
    Iterable<Object> information = [
      'PIIX_APP_EXCEPTION',
      '$PiixAnalyticsParameters: $appUserId',
      logMessage,
      error.toString(),
    ];
    if (error is AppApiLogException && error.requestOptions != null) {
      information = [
        'PIIX_API_EXCEPTION',
        '$PiixAnalyticsParameters: $appUserId',
        'LOG_MESSAGE: $logMessage',
        'PATH: ${error.requestOptions!.path}',
        'BODY: ${error.requestOptions!.data.toString()}',
        'ERROR_MESSAGE: ${error.message}',
      ];
    } else if (error is DioException) {
      information = [
        'DIO_ERROR',
        '$PiixAnalyticsParameters: $appUserId',
        'LOG_MESSAGE: $logMessage',
        'PATH: ${error.requestOptions.path}',
        'BODY: ${error.requestOptions.data.toString()}',
        'ERROR_MESSAGE: ${AppApiLogException.fromDioException(error).message}',
      ];
    }
    final fatal = level.index >= Level.error.index;
    if (sendToCrashlytics || fatal) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        information: information,
        reason: logMessage,
        fatal: fatal,
      );
    }
  }
}

class PiixLoggerFilter extends LogFilter {
  static PiixLoggerBuild loggerBuild = PiixLoggerBuild.debug;
  static int minLevelIndex = 0;

  @override
  bool shouldLog(LogEvent event) {
    final level = event.level;
    switch (loggerBuild) {
      case PiixLoggerBuild.debug:
        return debugMode(level);
      case PiixLoggerBuild.profile:
        return profileMode(level);
      default:
        return releaseMode(level);
    }
  }

  //Debug Mode logs all values
  //unless otherwise stated
  bool debugMode(Level level) {
    return level.index >= minLevelIndex;
  }

  bool profileMode(
    Level level,
  ) {
    return level.index >= Level.info.index;
  }

  bool releaseMode(
    Level level, {
    Level? minLevel,
  }) {
    return level.index >= Level.error.index;
  }
}

class PiixStringStackTrace implements StackTrace {
  const PiixStringStackTrace(this._stackTrace);

  final String _stackTrace;

  @override
  String toString() => _stackTrace;
}
