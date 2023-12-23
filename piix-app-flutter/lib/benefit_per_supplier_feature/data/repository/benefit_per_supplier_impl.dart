import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/request_benefit_per_supplier_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';

extension BenefitPerSupplierImplementation
    on BenefitPerSupplierRepositoryDeprecated {
  Future<dynamic> getBenefitPerSupplierRequestedImpl(
      RequestBenefitPerSupplierModel requestModel) async {
    try {
      final response =
          await benefitPerSupplierApi.getBenefitPerSupplierApi(requestModel);
      final statusCode = response.statusCode ?? 500;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data != null) {
          response.data['state'] = BenefitPerSupplierStateDeprecated.retrieved;
          final data = response.data;
          data['modelType'] = 'detail';
          return data;
        }
      }
      return BenefitPerSupplierStateDeprecated.error;
    } on DioError catch (dioError) {
      var benefitPerSupplierState = BenefitPerSupplierStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        benefitPerSupplierState = BenefitPerSupplierStateDeprecated.notFound;
      }
      if (benefitPerSupplierState != BenefitPerSupplierStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getBenefitPerSupplierRequestedImpl '
              'with id ${requestModel.benefitPerSupplierId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return benefitPerSupplierState;
      }
      throw piixApiExceptions;
    }
  }
}
