import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';

class PiixAnalytics {
  PiixAnalytics._({
    required this.authServiceProvider,
    required this.userBLoC,
  });

  static final instance = PiixAnalytics._(
    authServiceProvider: getIt<AuthServiceProvider>(),
    userBLoC: getIt<UserBLoCDeprecated>(),
  );

  final analyticsInstance = FirebaseAnalytics.instance;
  final UserBLoCDeprecated userBLoC;
  final AuthServiceProvider authServiceProvider;

  Future<void> logEvent({
    required String eventName,
    Map<String, dynamic>? eventParameters,
  }) async {
    //Any event that can pass on parameters needs to map with a userId,
    //there are three different sources to obtain it.
    final userId = authServiceProvider.user?.userId ??
        userBLoC.user?.userId ??
        (await AppSharedPreferences.recoverAuthUser())?.userId;
    //If there is no userId it means the event is not logged for
    //an authenticated user and the event is anonymous
    if (userId == null) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
          messageName: 'The user id is null',
          message: 'The event can’t be logged with the userId',
          isLoggable: false);
      loggerInstance.log(
        logMessage: logMessage.toString(),
        level: Level.debug,
        sendToCrashlytics: false,
      );
    }
    //If other parameters are passed they are added
    //before calling FirebaseAnalytics
    //Always keep this parameters in an event to
    //analyze a user journey
    //The date in iso string is added
    final parameters = <String, Object?>{};
    //If there are event parameters passed in the arguments,
    //then it tries to iterate and convert each string to capital
    //snake case to easily recognize events and parameters in
    //Analytics dashboard or data set
    if (eventParameters != null && eventParameters.isNotEmpty) {
      for (final entry in eventParameters.entries) {
        final key = entry.key.fromCamelToSnake(
          lowerCase: false,
        );
        if (entry.value is String) {
          final value = (entry.value as String).fromCamelToSnake(
            lowerCase: false,
          );
          parameters[key] = value;
          continue;
        }
        parameters[key] = entry.value;
      }
    }
    //Finally the event is logged in FirebaseAnalytics
    await analyticsInstance.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
