import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/plans_quote_price_request_model_deprecated.dart';

///Is a implementation extension of [PlansRepositoryDeprecated]
///Contains all api dev calls
///
extension PlansImpl on PlansRepositoryDeprecated {
  ///Gets plans by membership id
  /// If the request is not successful it either return [PlanStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getPlansByMembershipRequestedImpl(
      {required String membershipId}) async {
    try {
      final response = await plansApi.getPlansByMembershipApi(
        membershipId: membershipId,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return PlanStateDeprecated.error;
        }
        return response.data;
      }
      return PlanStateDeprecated.error;
    } on DioError catch (dioError) {
      var planState = PlanStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        planState = PlanStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        planState = PlanStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        planState = PlanStateDeprecated.unexpectedError;
      }
      if (planState != PlanStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getPlansByMembership '
              'with id $membershipId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return planState;
      }
      throw piixApiExceptions;
    }
  }

  ///Gets plan quotation by additional plans ids and membership id
  /// If the request is not successful it either return [PlanStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getPlansQuotationByMembershipImpl(
      {required PlansQuotePriceRequestModel requestModel}) async {
    try {
      final response = await plansApi.getPlansQuotationByMembership(
          requestModel: requestModel);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return PlanStateDeprecated.error;
        }
        return response.data;
      }
      return PlanStateDeprecated.error;
    } on DioError catch (dioError) {
      var planState = PlanStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.badGateway) {
        planState = PlanStateDeprecated.unexpectedError;
      } else if (statusCode == HttpStatus.conflict) {
        planState = PlanStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.notFound) {
        planState = PlanStateDeprecated.notFound;
      }
      if (planState != PlanStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in '
              'getPackageCombosWithDetailsAndPriceByMembership '
              'with id membership ${requestModel.membershipId}'
              ' and package combo id '
              '${requestModel.planIds} ',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return planState;
      }
      throw piixApiExceptions;
    }
  }
}
