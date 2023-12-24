import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_use_case_test.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/payer_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/user_payment_request_model_deprecated.dart';

import '../../../general_app_feature/api/mock_dio.mocks.dart';

void main() {
  setupGetIt();
  final appConfig = AppConfig.instance;
  appConfig
    ..setBackendEndPoint(DevEnv.backendEndpoint)
    ..setCatalogSQLURL(DevEnv.catalogEndpoint)
    ..setSignUpEndpoint(DevEnv.signUpEndpoint)
    ..setPaymentEndpoint(DevEnv.paymentEndpoint);
  final mockDio = MockDio();
  final paymentsBLoC = PaymentsBLoCDeprecated();
  final managingPaymentPath = '${appConfig.paymentEndpoint}/payment';
  final paymentsRepository = getIt<PaymentsRepositoryDeprecated>();
  final mockPaymentsMethods = paymentsRepository.fakePaymentsJson;
  final mockUserPayment = paymentsRepository.userPayment;
  PiixApiDeprecated.setDio(mockDio);
  late String userId;
  late String packageId;
  late String paymentMethodId;
  late String userQuotationId;
  late double transactionAmount;
  const names = 'Nombre puebra';
  const email = 'email_prueba@gmail.com';
  const lastNames = 'Last names de prueba';

  //===========================GET PAYMENT METHODS============================//
  group('get payment methods', () {
    final getPaymentMethodsPath = '$managingPaymentPath/methods';
    test(
        'if the user sends a getPaymentsMethods service and service http '
        'response code is 200 and response list is not empty, the paymentState '
        'is accomplished and payment methods list is not empty', () async {
      when(mockDio.get(getPaymentMethodsPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPaymentMethodsPath),
            statusCode: HttpStatus.ok,
            data: mockPaymentsMethods,
          ));
      await paymentsBLoC.getPaymentsMethods();
      expect(paymentsBLoC.paymentState, PaymentStateDeprecated.accomplished);
      expect(paymentsBLoC.paymentMethods, isNotEmpty);
      //The mock data has five payment methods that is why the length is
      //expected to be 5
      expect(paymentsBLoC.paymentMethods.length, 5);
    });

    test(
        'if the user sends a getPaymentsMethods service and service http '
        'response code is 200 and response list is empty, the paymentState is '
        'empty and payment methods list is empty', () async {
      when(mockDio.get(getPaymentMethodsPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPaymentMethodsPath),
            statusCode: HttpStatus.ok,
            data: [],
          ));
      await paymentsBLoC.getPaymentsMethods();
      expect(paymentsBLoC.paymentState, PaymentStateDeprecated.empty);
      expect(paymentsBLoC.paymentMethods, isEmpty);
    });

    test(
        'if the user sends a getPaymentsMethods service and service http '
        'response code is 200 and response list is null, the paymentState is '
        'error and payment methods list is empty', () async {
      when(mockDio.get(getPaymentMethodsPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPaymentMethodsPath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await paymentsBLoC.getPaymentsMethods();
      expect(paymentsBLoC.paymentState, PaymentStateDeprecated.error);
      expect(paymentsBLoC.paymentMethods, isEmpty);
    });

    test(
        'if the user sends a getPaymentsMethods service and service http '
        'response with a conection time out, the paymentState is a error',
        () async {
      when(mockDio.get(getPaymentMethodsPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPaymentMethodsPath),
          response: Response(
              requestOptions: RequestOptions(path: getPaymentMethodsPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await paymentsBLoC.getPaymentsMethods();
      expect(paymentsBLoC.paymentState, PaymentStateDeprecated.error);
    });
    test(
        'if the user sends a getPaymentsMethods service and service http '
        'response code is 502, the paymentState is a unexpectedError',
        () async {
      when(mockDio.get(getPaymentMethodsPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPaymentMethodsPath),
          response: Response(
              requestOptions: RequestOptions(path: getPaymentMethodsPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await paymentsBLoC.getPaymentsMethods();
      expect(paymentsBLoC.paymentState, PaymentStateDeprecated.unexpectedError);
    });
  });

  group('make user payment', () {
    final makeUserPaymentPath = '$managingPaymentPath/user';
    userId = '180f430b70b2c4ad85f058a6';
    packageId = 'CNOC-2022-01';
    paymentMethodId = 'oxxo';
    userQuotationId =
        '90bc4465bdd1dde36a742013e872e0e04446a48509146e156705359d9276ce4e';
    transactionAmount = 2900.00;
    final payer = PayerModel(email: email, names: names, lastNames: lastNames);

    final request = UserPaymentRequestModel(
        userId: userId,
        packageId: packageId,
        paymentMethodId: paymentMethodId,
        userQuotationId: userQuotationId,
        transactionAmount: transactionAmount,
        payer: payer);

    test(
        'if the user sends a makeUserPaymentPath service and service http '
        'response code is 201 in case of a successful response and response is'
        ' not null, the userPaymentState is accomplished and userPaymentModel not '
        'empty', () async {
      when(mockDio.post(makeUserPaymentPath, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: makeUserPaymentPath),
                statusCode: HttpStatus.created,
                data: mockUserPayment,
              ));
      await paymentsBLoC.makeUserPayment(userPaymentRequest: request);
      expect(
          paymentsBLoC.userPaymentState, PaymentStateDeprecated.accomplished);
      expect(paymentsBLoC.userPaymentModel, isNotNull);
      expect(paymentsBLoC.userPaymentModel!.purchaseInvoiceId, isNotNull);
      expect(paymentsBLoC.userPaymentModel!.userQuotation.userQuotePriceId,
          userQuotationId);
    });

    test(
        'if the user sends a makeUserPaymentPath service and service http '
        'response code is 201 in case of a successful response and response is'
        ' null, the userPaymentState is error', () async {
      when(mockDio.post(makeUserPaymentPath, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: makeUserPaymentPath),
                statusCode: HttpStatus.created,
                data: null,
              ));
      await paymentsBLoC.makeUserPayment(userPaymentRequest: request);
      expect(paymentsBLoC.userPaymentState, PaymentStateDeprecated.error);
    });

    test(
        'if the user sends a makeUserPayment service and service http response '
        'with a http status bad request, the userPaymentState is a badRequest',
        () async {
      when(mockDio.post(makeUserPaymentPath, data: request.toJson())).thenThrow(
          DioError(
              requestOptions: RequestOptions(path: makeUserPaymentPath),
              response: Response(
                  requestOptions: RequestOptions(path: makeUserPaymentPath),
                  statusCode: HttpStatus.badRequest,
                  data: <String, dynamic>{
                    'errorMessage':
                        'There was an error creating the piix payment:: At '
                            'least one of the params to create the payment is '
                            'incorrect.',
                    'errorName': 'Piix Error Payment Params.',
                    'errorMessages': [
                      "The current payment can't be proceessed since it has "
                          'already been purchased.'
                    ]
                  }),
              type: DioErrorType.badResponse));
      await paymentsBLoC.makeUserPayment(userPaymentRequest: request);
      expect(paymentsBLoC.userPaymentState, PaymentStateDeprecated.badRequest);
    });

    test(
        'if the user sends a makeUserPaymentPath service and service http '
        'response with a conection time out, the userPaymentState is a error',
        () async {
      when(mockDio.post(makeUserPaymentPath, data: request.toJson())).thenThrow(
          DioError(
              requestOptions: RequestOptions(path: makeUserPaymentPath),
              response: Response(
                  requestOptions: RequestOptions(path: makeUserPaymentPath),
                  statusCode: HttpStatus.networkConnectTimeoutError,
                  data: <String, dynamic>{
                    'errorMessage': 'Connection time out',
                  }),
              type: DioErrorType.connectionTimeout));
      await paymentsBLoC.makeUserPayment(userPaymentRequest: request);
      expect(paymentsBLoC.userPaymentState, PaymentStateDeprecated.error);
    });
    test(
        'if the user sends a makeUserPaymentPath service and service http '
        'response code is 502, the userPaymentState is a unexpectedError',
        () async {
      when(mockDio.post(makeUserPaymentPath, data: request.toJson())).thenThrow(
          DioError(
              requestOptions: RequestOptions(path: makeUserPaymentPath),
              response: Response(
                  requestOptions: RequestOptions(path: makeUserPaymentPath),
                  statusCode: HttpStatus.badGateway,
                  data: <String, dynamic>{
                    'errorMessage': 'There was an unexpected error',
                  }),
              type: DioErrorType.badResponse));
      await paymentsBLoC.makeUserPayment(userPaymentRequest: request);
      expect(paymentsBLoC.userPaymentState,
          PaymentStateDeprecated.unexpectedError);
    });
  });
}
