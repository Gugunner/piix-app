import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/claim_ticket_request.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';

//TODO ADD DOCUMENTATION IN NEXT PR
extension ClaimTicketImpl on ClaimTicketRepository {
  Future<dynamic> getTicketHistoryByMembershipRequestedImpl(String membershipId,
      [bool useLoggers = true]) async {
    try {
      final response =
          await claimTicketApi.getTicketHistoryByMembership(membershipId);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {
            'tickets': response.data,
            'state': ClaimTicketStateDeprecated.retrieved,
          };
          return data;
        }
        return ClaimTicketStateDeprecated.retrieveError;
      }
      return ClaimTicketStateDeprecated.retrieveError;
    } on DioError catch (dioError) {
      var ticketState = ClaimTicketStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.conflict) {
        ticketState = ClaimTicketStateDeprecated.empty;
      }
      if (ticketState != ClaimTicketStateDeprecated.idle) {
        if (!useLoggers) {
          return ticketState;
        }
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getTicketHistoryRequestedImpl '
              'with membership id ${membershipId}',
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

  Future<dynamic> cancelClaimTicketRequestedImpl(
      ClaimTicketRequest cancelRequest,
      [bool useLoggers = true]) async {
    try {
      final response = await claimTicketApi.cancelClaimTicket(
        cancelRequest: cancelRequest,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {
            'ticket': response.data,
            'state': ClaimTicketStateDeprecated.cancelled,
          };
          return data;
        }
        return ClaimTicketStateDeprecated.error;
      }
      return ClaimTicketStateDeprecated.error;
    } on DioError catch (dioError) {
      var ticketState = ClaimTicketStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        ticketState = ClaimTicketStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        ticketState = ClaimTicketStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        ticketState = ClaimTicketStateDeprecated.unexpectedError;
      }
      if (ticketState != ClaimTicketStateDeprecated.idle) {
        if (!useLoggers) {
          return ticketState;
        }
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in cancelClaimTicket with ticketId '
              '${cancelRequest.ticketId}',
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

  Future<dynamic> closeClaimTicketRequestedImpl(ClaimTicketRequest closeRequest,
      [bool useLoggers = true]) async {
    try {
      final response = await claimTicketApi.closeClaimTicket(
        closeRequest: closeRequest,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {
            'ticket': response.data,
            'state': ClaimTicketStateDeprecated.closed,
          };
          return data;
        }
        return ClaimTicketStateDeprecated.error;
      }
      return ClaimTicketStateDeprecated.error;
    } on DioError catch (dioError) {
      var ticketState = ClaimTicketStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        ticketState = ClaimTicketStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        ticketState = ClaimTicketStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        ticketState = ClaimTicketStateDeprecated.unexpectedError;
      }
      if (ticketState != ClaimTicketStateDeprecated.idle) {
        if (!useLoggers) {
          return ticketState;
        }
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in closeClaimTicket with ticketId '
              '${closeRequest.ticketId}',
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

  Future<dynamic> reportClaimTicketProblemRequestedImpl(
      ClaimTicketRequest reportRequest,
      [bool useLoggers = true]) async {
    try {
      final response = await claimTicketApi.reportClaimTicketProblem(
        reportRequest: reportRequest,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {
            'ticket': response.data,
            'state': ClaimTicketStateDeprecated.reported,
          };
          return data;
        }
        return ClaimTicketStateDeprecated.error;
      }
      return ClaimTicketStateDeprecated.error;
    } on DioError catch (dioError) {
      var ticketState = ClaimTicketStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        ticketState = ClaimTicketStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        ticketState = ClaimTicketStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        ticketState = ClaimTicketStateDeprecated.unexpectedError;
      }
      if (ticketState != ClaimTicketStateDeprecated.idle) {
        if (!useLoggers) {
          return ticketState;
        }
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in reportClaimTicketProblem with ticketId '
              '${reportRequest.ticketId}',
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

  Future<dynamic> createClaimTicketRequestedImpl(
      ClaimTicketRequest createRequest,
      [bool useLoggers = true]) async {
    try {
      final response = await claimTicketApi.createClaimTicket(
        createRequest: createRequest,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          final data = {
            'ticket': TicketModel.fromJson(response.data),
            'state': ClaimTicketStateDeprecated.created,
          };
          return data;
        }
        return ClaimTicketStateDeprecated.error;
      }
      return ClaimTicketStateDeprecated.error;
    } on DioError catch (dioError) {
      var ticketState = ClaimTicketStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        ticketState = ClaimTicketStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        ticketState = ClaimTicketStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        ticketState = ClaimTicketStateDeprecated.unexpectedError;
      } else if (statusCode == HttpStatus.badRequest) {
        ticketState = ClaimTicketStateDeprecated.conflict;
      }
      if (ticketState != ClaimTicketStateDeprecated.idle) {
        if (!useLoggers) {
          return ticketState;
        }
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName:
              'Exception in createClaimTicketRequestedImpl with membershipId '
              '${createRequest.membershipId}',
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
