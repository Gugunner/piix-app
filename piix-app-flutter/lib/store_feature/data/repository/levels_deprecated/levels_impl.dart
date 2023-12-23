import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/level_quote_price_request_model_deprecated.dart';

///Is a implementation extension of [LevelsRepositoryDeprecated]
///Contains all api dev calls
///
extension LevelsImpl on LevelsRepositoryDeprecated {
  ///Gets levels by membership id
  /// If the request is not successful it either return [LevelStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getLevelsByMembershipImpl(
      {required String membershipId}) async {
    try {
      final response =
          await levelsApi.getLevelsByMembership(membershipId: membershipId);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return LevelStateDeprecated.error;
        }
        return response.data;
      }
      return LevelStateDeprecated.error;
    } on DioError catch (dioError) {
      var levelState = LevelStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        levelState = LevelStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        levelState = LevelStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        levelState = LevelStateDeprecated.unexpectedError;
      }
      if (levelState != LevelStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getLevelsByMembershipImpl '
              'with id $membershipId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return levelState;
      }
      throw piixApiExceptions;
    }
  }

  ///Gets level quotation by level id and membership id
  /// If the request is not successful it either return [LevelStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getLevelQuotationByMembershipImpl(
      {required LevelQuotePriceRequestModel requestModel}) async {
    try {
      final response = await levelsApi.getLevelQuotationByMembership(
          requestModel: requestModel);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return LevelStateDeprecated.error;
        }
        return response.data;
      }
      return LevelStateDeprecated.error;
    } on DioError catch (dioError) {
      var levelState = LevelStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.badGateway) {
        levelState = LevelStateDeprecated.unexpectedError;
      } else if (statusCode == HttpStatus.conflict) {
        levelState = LevelStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.notFound) {
        levelState = LevelStateDeprecated.notFound;
      }
      if (levelState != LevelStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getLevelQuotationByMembership '
              'with id membership ${requestModel.membershipId}'
              ' and level id ${requestModel.levelId} ',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return levelState;
      }
      throw piixApiExceptions;
    }
  }
}
