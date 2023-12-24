import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/cancel_payment_request_model.dart';
import 'package:piix_mobile/store_feature/domain/model/user_payment_request_model_deprecated.dart';

///Is a implementation extension of [PaymentsRepositoryDeprecated]
///Contains all api dev calls
///
extension PaymentsImpl on PaymentsRepositoryDeprecated {
  ///Gets payments methods
  /// If the request is not successful it either return [PaymentStateDeprecated]
  /// as unexpectedError
  ///
  Future<dynamic> getPaymentsMethodsImpl() async {
    try {
      final response = await paymentsApi.getPaymentsMethods();
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return PaymentStateDeprecated.error;
        }
        return response.data;
      }
      return PaymentStateDeprecated.error;
    } on DioError catch (dioError) {
      var paymentState = PaymentStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.badGateway) {
        paymentState = PaymentStateDeprecated.unexpectedError;
      }
      if (paymentState != PaymentStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in getPaymentsMethods',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return paymentState;
      }
      throw piixApiExceptions;
    }
  }

  ///Make user payments
  /// If the request is not successful it either return [PaymentStateDeprecated]
  /// as unexpectedError or bad request
  ///
  Future<dynamic> makeUserPaymentImpl(
      {required UserPaymentRequestModel userPaymentRequest}) async {
    try {
      final response = await paymentsApi.makeUserPayment(
          userPaymentRequest: userPaymentRequest);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return PaymentStateDeprecated.error;
        }
        final data = response.data;
        data['modelType'] = 'payment';
        return data;
      }
      return PaymentStateDeprecated.error;
    } on DioError catch (dioError) {
      var userPaymentState = PaymentStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.badGateway) {
        userPaymentState = PaymentStateDeprecated.unexpectedError;
      }
      if (statusCode == HttpStatus.badRequest) {
        userPaymentState = PaymentStateDeprecated.badRequest;
      }
      if (userPaymentState != PaymentStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in makeUserPayment'
              'with user quotation id ${userPaymentRequest.userQuotationId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return userPaymentState;
      }
      throw piixApiExceptions;
    }
  }

  ///cancel user payment
  /// If the request is not successful it either return [PaymentStateDeprecated]
  /// as unexpectedError or bad request
  ///
  Future<dynamic> cancelUserPaymentImpl(
      {required CancelPaymentRequestModel cancelPaymentRequest}) async {
    try {
      final response = await paymentsApi.cancelUserPayment(
          cancelPaymentRequest: cancelPaymentRequest);
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (PiixApiDeprecated.checkStatusCode(statusCode: statusCode)) {
        if (response.data == null) {
          return PaymentStateDeprecated.error;
        }
        return response.data;
      }
      return PaymentStateDeprecated.error;
    } on DioError catch (dioError) {
      var paymentState = PaymentStateDeprecated.idle;
      final piixApiExceptions = AppApiLogException.fromDioException(dioError);
      final statusCode = piixApiExceptions.statusCode;
      if (statusCode == HttpStatus.notFound) {
        paymentState = PaymentStateDeprecated.notFound;
      } else if (statusCode == HttpStatus.badRequest) {
        paymentState = PaymentStateDeprecated.badRequest;
      } else if (statusCode == HttpStatus.badGateway) {
        paymentState = PaymentStateDeprecated.unexpectedError;
      } else if (statusCode == HttpStatus.conflict) {
        paymentState = PaymentStateDeprecated.conflict;
      }
      if (paymentState != PaymentStateDeprecated.idle) {
        final loggerInstance = PiixLogger.instance;
        final logMessage = loggerInstance.errorMessage(
          messageName: 'Exception in cancelUserPayment'
              'with purchase invoice id '
              '${cancelPaymentRequest.purchaseInvoiceId}',
          message: piixApiExceptions.toString(),
          isLoggable: true,
        );
        loggerInstance.log(
          logMessage: logMessage.toString(),
          error: dioError,
          level: Level.error,
        );
        return paymentState;
      }
      throw piixApiExceptions;
    }
  }
}
