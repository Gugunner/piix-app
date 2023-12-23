import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/additional_benefit_per_supplier_quote_price_request_model_deprecated.dart';

///Is a implementation extension of [AdditionalBenefitsPerSupplierRepositoryDeprecated]
///Contains all api dev calls
///
extension AdditionalBenefitsPerSupplierImpl
    on AdditionalBenefitsPerSupplierRepositoryDeprecated {
  ///Gets additional benefits per supplier by membership id
  /// If the request is not successful it either return [AdditionalBenefitsPerSupplierStateDeprecated]
  /// as userNotMatchError, notFound or unexpectedError
  ///
  Future<dynamic> getAdditionalBenefitsPerSupplierByMembershipRequestedImpl({
    required String membershipId,
  }) async {
    try {
      final response = await additionalBenefitsApi
          .getAdditionalBenefitsPerSupplierByMembershipApi(
        membershipId: membershipId,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        return response.data;
      }
      return AdditionalBenefitsPerSupplierStateDeprecated.error;
    } on DioError catch (dioError) {
      var additionalBenefitsPerSupplierState =
          AdditionalBenefitsPerSupplierStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        additionalBenefitsPerSupplierState =
            AdditionalBenefitsPerSupplierStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        additionalBenefitsPerSupplierState =
            AdditionalBenefitsPerSupplierStateDeprecated.userNotMatchError;
      } else if (statusCode == HttpStatus.badGateway) {
        additionalBenefitsPerSupplierState =
            AdditionalBenefitsPerSupplierStateDeprecated.unexpectedError;
      }
      if (additionalBenefitsPerSupplierState !=
          AdditionalBenefitsPerSupplierStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName:
              'Exception in getAdditionalBenefitsPerSupplierByMembershipImpl '
              'with id $membershipId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return additionalBenefitsPerSupplierState;
      }
      throw piixApiExceptions;
    }
  }

  ///Gets additional benefits per supplier whit details and prices by additional
  /// benefit per supplier id and membership id
  /// If the request is not successful it either return [AdditionalBenefitsPerSupplierStateDeprecated]
  /// as userNotMatchError, notFound or unexpectedError
  ///
  Future<dynamic> getAdditionalBenefitPerSupplierDetailsAndPriceRequestedImpl(
      {required AdditionalBenefitPerSupplierQuotePriceRequestModel
          requestModel}) async {
    try {
      final response = await additionalBenefitsApi
          .getAdditionalBenefitPerSupplierDetailsAndPriceApi(
              requestModel: requestModel);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode))
        return GeneralQuotationStateDeprecated.error;
      final data = response.data;
      data['modelType'] = 'additional';
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
              'getAdditionalBenefitPerSupplierDetailsAndPriceRequestedImpl '
              'with id membership ${requestModel.membershipId}'
              ' and additional benefit per supplier id '
              '${requestModel.additionalBenefitPerSupplierId} ',
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
