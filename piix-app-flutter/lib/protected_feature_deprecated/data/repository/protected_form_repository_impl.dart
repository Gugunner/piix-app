import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository.dart';

extension ProtectedFormRepositoryImpl on ProtectedFormRepository {
  Future<dynamic> getProtectedRegisterFormRequestedImpl({
    required String membershipId,
    bool useFirebase = true,
  }) async {
    try {
      final response = await formApi.getProtectedRegisterFormApi(
        membershipId: membershipId,
      );
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return ProtectedFormState.retrievedError;
      }
      final data = response.data;
      data['state'] = ProtectedFormState.retrieved;
      return data;
    } on DioError catch (dioError) {
      const protectedFormState = ProtectedFormState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      //TODO: add logic if status code specific states must be handled
      if (protectedFormState != ProtectedFormState.idle) {
        if (useFirebase) {
          final loggerInstance = PiixLogger.instance;
          final logMessage = loggerInstance.errorMessage(
            messageName: 'Exception in getProtectedRegisterFormRequestedImpl',
            message: piixApiExceptions.toString(),
            isLoggable: true,
          );
          loggerInstance.log(
            logMessage: logMessage.toString(),
            error: dioError,
            level: Level.error,
          );
        }
        return protectedFormState;
      }
      throw piixApiExceptions;
    }
  }
}
