import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_repository.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/combo_quote_price_request_model.dart';

///Is a implementation extension of [PackageCombosRepository]
///Contains all api dev calls
///
extension PackageComboImpl on PackageCombosRepository {
  ///Gets additional benefits per supplier by membership id
  /// If the request is not successful it either return [AdditionalBenefitsPerSupplierState]
  /// as userNotMatchError, notFound or unexpectedError
  ///
  Future<dynamic> getPackageCombosByMembershipImpl(
      {required String membershipId}) async {
    try {
      final response = await packageCombosApi.getPackageCombosByMembership(
          membershipId: membershipId);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return response.data;
      }
      return PackageCombosState.error;
    } on DioError catch (dioError) {
      var packageCombosState = PackageCombosState.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        packageCombosState = PackageCombosState.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        packageCombosState = PackageCombosState.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        packageCombosState = PackageCombosState.unexpectedError;
      }
      if (packageCombosState != PackageCombosState.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getPackageCombosByMembershipImpl '
              'with id $membershipId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return packageCombosState;
      }
      throw piixApiExceptions;
    }
  }

  ///Gets additional benefits per supplier whit details and prices by additional
  /// benefit per supplier id and membership id
  /// If the request is not successful it either return [AdditionalBenefitsPerSupplierState]
  /// as userNotMatchError, notFound or unexpectedError
  ///
  Future<dynamic> getPackageCombosWithDetailsAndPriceByMembershipImpl(
      {required ComboQuotePriceRequestModel requestModel}) async {
    try {
      final response = await packageCombosApi
          .getPackageCombosWithDetailsAndPriceByMembership(
        requestModel: requestModel,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode))
        return GeneralQuotationStateDeprecated.error;
      final data = response.data;
      data['modelType'] = 'default';
      return data;
    } on DioError catch (dioError) {
      var quotationState = GeneralQuotationStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.badGateway) {
        quotationState = GeneralQuotationStateDeprecated.unexpectedError;
      } else if (statusCode == HttpStatus.conflict) {
        quotationState = GeneralQuotationStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.notFound) {
        quotationState = GeneralQuotationStateDeprecated.notFound;
      }
      if (quotationState != GeneralQuotationStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in '
              'getPackageCombosWithDetailsAndPriceByMembership '
              'with id membership ${requestModel.membershipId}'
              ' and package combo id '
              '${requestModel.packageComboId} ',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return quotationState;
      }
      throw piixApiExceptions;
    }
  }
}
