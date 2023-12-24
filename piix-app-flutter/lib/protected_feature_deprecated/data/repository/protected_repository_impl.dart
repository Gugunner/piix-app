import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/request_available_protected_model.dart';

extension ProtectedRepositoryImpl on ProtectedRepository {
  Future<dynamic> getAvailableProtectedRequestedImpl({
    required RequestAvailableProtectedModel requestModel,
    bool useFirebase = true,
  }) async {
    try {
      final response = await protectedApi.getAvailableProtectedApi(
          requestModel: requestModel);
      final statusCode = response.statusCode ?? 500;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) return ProtectedState.error;
      final data = response.data;
      data['state'] = ProtectedState.retrieved;
      return data;
    } on DioError catch (dioError) {
      var protectedState = ProtectedState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        protectedState = ProtectedState.notFound;
      }
      if (protectedState != ProtectedState.idle) {
        if (useFirebase) {
          final loggerInstance = PiixLogger.instance;
          final logMessage = loggerInstance.errorMessage(
            messageName: 'Exception in getAvaolableProtectedSlots',
            message: piixApiExceptions.toString(),
            isLoggable: true,
          );
          loggerInstance.log(
            logMessage: logMessage.toString(),
            error: dioError,
            level: Level.error,
          );
        }
        return protectedState;
      }
      throw piixApiExceptions;
    }
  }
}
