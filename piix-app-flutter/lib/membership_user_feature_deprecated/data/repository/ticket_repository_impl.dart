import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/ticket_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/ticket_model/request_ticket_history_model.dart';

///Handles all real api service implementation calls for support tickets
extension TicketRepositoryImplementation on TicketRepository {
  Future<dynamic> getTicketHistoryRequestedImpl(
      RequestTicketHistoryModel historyModel) async {
    try {
      final response = await ticketApi.getTicketHistoryApi(historyModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {
            'tickets': response.data,
            'state': TicketState.retrieved,
          };
          return data;
        }
      }
      return TicketState.retrieveError;
    } on DioError catch (dioError) {
      var ticketState = TicketState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict) {
        ticketState = TicketState.empty;
      }
      if (ticketState != TicketState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getTicketHistoryRequestedImpl '
              'with id ${historyModel.membershipId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return ticketState;
      }
      throw piixApiExceptions;
    }
  }
}
