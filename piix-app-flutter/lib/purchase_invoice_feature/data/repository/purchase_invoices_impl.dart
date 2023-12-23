import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';

///Is a implementation extension of [PurchaseInvoiceRepositoryDeprecated]
///Contains all api dev calls
///
extension PurchaseInvoiceImpl on PurchaseInvoiceRepositoryDeprecated {
  ///Gets purchase invoices by membership id
  /// If the request is not successful it either return [InvoiceStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getPurchaseInvoiceByMembershipRequestedImpl(
      {required String membershipId, bool onlyActiveInvoices = false}) async {
    try {
      final response =
          await purchaseInvoiceApi.getPurchaseInvoicesByMembershipApi(
        membershipId: membershipId,
        onlyActiveInvoices: onlyActiveInvoices,
      );
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) {
        return InvoiceStateDeprecated.error;
      }
      return response.data;
    } on DioError catch (dioError) {
      var invoiceState = InvoiceStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        invoiceState = InvoiceStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        invoiceState = InvoiceStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        invoiceState = InvoiceStateDeprecated.unexpectedError;
      }
      if (invoiceState != InvoiceStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getPurchaseInvoicesByMembership whit'
              'membership id $membershipId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return invoiceState;
      }
      throw piixApiExceptions;
    }
  }

  ///Get Additional Benefit Purchase Invoice By Id
  /// If the request is not successful it either return [InvoiceStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getAdditionalBenefitPurchaseInvoiceRequestedImpl(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final response =
          await purchaseInvoiceApi.getAdditionalBenefitPurchaseInvoiceApi(
              membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (!PiixApiDeprecated.checkStatusCode(statusCode: statusCode) ||
          response.data == null) return InvoiceStateDeprecated.error;

      final data = response.data;
      data['modelType'] = 'detail';
      return data;
    } on DioError catch (dioError) {
      var invoiceState = InvoiceStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        invoiceState = InvoiceStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        invoiceState = InvoiceStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        invoiceState = InvoiceStateDeprecated.unexpectedError;
      }
      if (invoiceState != InvoiceStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getAdditionalBenefitPurchaseInvoiceById'
              ' whit membership id $membershipId, and purchaseInvoiceId'
              '$purchaseInvoiceId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return invoiceState;
      }
      throw piixApiExceptions;
    }
  }

  ///Get Package Combo Purchase Invoice By Id
  /// If the request is not successful it either return [InvoiceStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getPackageComboPurchaseInvoiceByIdImpl(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final response =
          await purchaseInvoiceApi.getPackageComboPurchaseInvoiceById(
              membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return InvoiceStateDeprecated.error;
        }
        final data = response.data;
        data['modelType'] = 'detail';
        return data;
      }
      return InvoiceStateDeprecated.error;
    } on DioError catch (dioError) {
      var invoiceState = InvoiceStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        invoiceState = InvoiceStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        invoiceState = InvoiceStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        invoiceState = InvoiceStateDeprecated.unexpectedError;
      }
      if (invoiceState != InvoiceStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getPackageComboPurchaseInvoiceById'
              ' whit membership id $membershipId, and purchaseInvoiceId'
              '$purchaseInvoiceId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return invoiceState;
      }
      throw piixApiExceptions;
    }
  }

  ///Get Level Purchase Invoice By Id
  /// If the request is not successful it either return [InvoiceStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getLevelPurchaseInvoiceByIdImpl(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final response = await purchaseInvoiceApi.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return InvoiceStateDeprecated.error;
        }
        final data = response.data;
        data['modelType'] = 'detail';
        return data;
      }
      return InvoiceStateDeprecated.error;
    } on DioError catch (dioError) {
      var invoiceState = InvoiceStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        invoiceState = InvoiceStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        invoiceState = InvoiceStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        invoiceState = InvoiceStateDeprecated.unexpectedError;
      }
      if (invoiceState != InvoiceStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getLevelPurchaseInvoiceById'
              ' whit membership id $membershipId, and purchaseInvoiceId'
              '$purchaseInvoiceId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return invoiceState;
      }
      throw piixApiExceptions;
    }
  }

  /// Get Plan Purchase Invoice By Id
  /// If the request is not successful it either return [InvoiceStateDeprecated]
  /// as conflict, notFound or unexpectedError
  ///
  Future<dynamic> getPlanPurchaseInvoiceByIdImpl(
      {required String membershipId, required String purchaseInvoiceId}) async {
    try {
      final response = await purchaseInvoiceApi.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return InvoiceStateDeprecated.error;
        }
        final data = response.data;
        data['modelType'] = 'detail';
        return data;
      }
      return InvoiceStateDeprecated.error;
    } on DioError catch (dioError) {
      var invoiceState = InvoiceStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        invoiceState = InvoiceStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.conflict) {
        invoiceState = InvoiceStateDeprecated.conflict;
      } else if (statusCode == HttpStatus.badGateway) {
        invoiceState = InvoiceStateDeprecated.unexpectedError;
      }
      if (invoiceState != InvoiceStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getPlanPurchaseInvoiceById'
              ' whit membership id $membershipId, and purchaseInvoiceId'
              '$purchaseInvoiceId',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return invoiceState;
      }
      throw piixApiExceptions;
    }
  }
}
