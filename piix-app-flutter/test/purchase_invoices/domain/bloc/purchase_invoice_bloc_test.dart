import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_use_case_test.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';

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
  final purchaseInvoiceBLoC = PurchaseInvoiceBLoCDeprecated();
  final managingPurchaseInvoicePath =
      '${appConfig.backendEndpoint}/purchaseInvoices/users/membership';
  final purchaseInvoiceRepository =
      getIt<PurchaseInvoiceRepositoryDeprecated>();
  final mockPurchaseInvoices = purchaseInvoiceRepository.fakeInvoicesJson;
  final mockAdditionalBenefitPurchase =
      purchaseInvoiceRepository.fakeAdditionalBenefitPurchaseJson;
  final mockPackageComboPurchase =
      purchaseInvoiceRepository.fakePackageComboPurchaseJson;
  final mockPlanPurchase = purchaseInvoiceRepository.fakePlanPurchaseJson;
  final mockLevelPurchase = purchaseInvoiceRepository.fakeLevelPurchaseJson;
  PiixApiDeprecated.setDio(mockDio);
  late String membershipId;
  late String purchaseInvoiceId;

  //=================GET PURCHASE INVOICES BY MEMBERSHIP ID==================//
  group('get purchase invoice', () {
    membershipId = 'CNOC-2022-01-24-00';
    final getPurchaseInvoicePath =
        '$managingPurchaseInvoicePath?membershipId=$membershipId';

    test(
        'if the user sends a getPurchaseInvoiceByMembership service'
        'and service http response code is 200 and response list is not empty,'
        'the invoiceState is accomplished and purchaseInvoiceList is not empty',
        () async {
      when(mockDio.get(getPurchaseInvoicePath))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: getPurchaseInvoicePath),
                statusCode: HttpStatus.ok,
                data: mockPurchaseInvoices,
              ));
      await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.accomplished);
      expect(purchaseInvoiceBLoC.purchaseInvoiceList, isNotEmpty);
      //The mock data has four purchase invoice that is why the length is
      //expected to be 4
      expect(purchaseInvoiceBLoC.purchaseInvoiceList.length, 4);
    });
    test(
        'if the user sends a getPurchaseInvoiceByMembership service'
        ' and service http response code is 200 and response list is empty,'
        ' the invoiceState is empty and '
        'levelList list is empty', () async {
      when(mockDio.get(getPurchaseInvoicePath))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: getPurchaseInvoicePath),
                statusCode: HttpStatus.ok,
                data: [],
              ));
      await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.empty);
      expect(purchaseInvoiceBLoC.purchaseInvoiceList, isEmpty);
    });

    test(
        'if the user sends a getPurchaseInvoiceByMembership service'
        ' and service http response code is 404, the '
        'invoiceState is a notFound', () async {
      when(mockDio.get(getPurchaseInvoicePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPurchaseInvoicePath),
          response: Response(
            requestOptions: RequestOptions(path: getPurchaseInvoicePath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the purchase invoices info:: '
                      'Membership with id: CNOC-2022-01-24-00 was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.notFound);
    });

    test(
        'if the user sends a getPurchaseInvoiceByMembership service'
        ' and service http response code is 409, the '
        'invoiceState is a conflict', () async {
      when(mockDio.get(getPurchaseInvoicePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPurchaseInvoicePath),
          response: Response(
            requestOptions: RequestOptions(path: getPurchaseInvoicePath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the purchase invoices list:: '
                      "Please provide a(n) 'userId'.",
              'errorName': 'Piix Error userId Not Provided.',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.conflict);
    });
    test(
        'if the user sends a getPurchaseInvoiceByMembership service and service'
        'http response with a conection time out, the invoiceState is a error',
        () async {
      when(mockDio.get(getPurchaseInvoicePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPurchaseInvoicePath),
          response: Response(
              requestOptions: RequestOptions(path: getPurchaseInvoicePath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
    });
    test(
        'if the user sends a getPurchaseInvoiceByMembership service and service'
        ' http response code is 502, the invoiceState is a unexpectedError',
        () async {
      when(mockDio.get(getPurchaseInvoicePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPurchaseInvoicePath),
          response: Response(
              requestOptions: RequestOptions(path: getPurchaseInvoicePath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getAllInvoicesByMembership(
          membershipId: membershipId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.unexpectedError);
    });
  });

  //==========GET ADDITIONAL BENEFIT PURCHASE BY ID==========//
  group('get additional benefit purchase', () {
    membershipId = 'CNOC-2022-01-24-00';
    purchaseInvoiceId =
        'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946';
    final getAdditionalBenefitPurchasePath =
        '$managingPurchaseInvoicePath/additionalBenefitPerSupplier?'
        'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';

    test(
        'if the user sends a getAdditionalBenefitPurchaseInvoiceById service'
        'and service http response code is 200 and response is not null,'
        'the invoiceState is accomplished and purchaseInvoiceDetail is not null',
        () async {
      when(mockDio.get(getAdditionalBenefitPurchasePath))
          .thenAnswer((_) async => Response(
                requestOptions:
                    RequestOptions(path: getAdditionalBenefitPurchasePath),
                statusCode: HttpStatus.ok,
                data: mockAdditionalBenefitPurchase,
              ));
      await purchaseInvoiceBLoC.getAdditionalBenefitPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.accomplished);
      expect(purchaseInvoiceBLoC.invoice, isNotNull);
      expect(purchaseInvoiceBLoC.invoice!.purchaseInvoiceId, purchaseInvoiceId);
    });
    test(
        'if the user sends a getPurchaseInvoiceByMembership service'
        ' and service http response code is 200 and response is null,'
        ' the invoiceState is error and purchaseInvoiceDetail is null',
        () async {
      when(mockDio.get(getAdditionalBenefitPurchasePath))
          .thenAnswer((_) async => Response(
                requestOptions:
                    RequestOptions(path: getAdditionalBenefitPurchasePath),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await purchaseInvoiceBLoC.getAdditionalBenefitPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
      expect(purchaseInvoiceBLoC.invoice, isNull);
    });

    test(
        'if the user sends a getAdditionalBenefitPurchaseInvoiceById service'
        ' and service http response code is 404, the '
        'invoiceState is a notFound', () async {
      when(mockDio.get(getAdditionalBenefitPurchasePath)).thenThrow(DioError(
          requestOptions:
              RequestOptions(path: getAdditionalBenefitPurchasePath),
          response: Response(
            requestOptions:
                RequestOptions(path: getAdditionalBenefitPurchasePath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage': 'There was an error getting the purchase invoice:: '
                  'PurchaseInvoice with id: '
                  'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720rr '
                  'was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getAdditionalBenefitPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.notFound);
    });

    test(
        'if the user sends a getAdditionalBenefitPurchaseInvoiceById service '
        'and service http response with a connection time out, the invoiceState'
        ' is a error', () async {
      when(mockDio.get(getAdditionalBenefitPurchasePath)).thenThrow(DioError(
          requestOptions:
              RequestOptions(path: getAdditionalBenefitPurchasePath),
          response: Response(
              requestOptions:
                  RequestOptions(path: getAdditionalBenefitPurchasePath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await purchaseInvoiceBLoC.getAdditionalBenefitPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
    });
    test(
        'if the user sends a getAdditionalBenefitPurchaseInvoiceById service '
        'and service http response code is 502, the invoiceState is a '
        'unexpectedError', () async {
      when(mockDio.get(getAdditionalBenefitPurchasePath)).thenThrow(DioError(
          requestOptions:
              RequestOptions(path: getAdditionalBenefitPurchasePath),
          response: Response(
              requestOptions:
                  RequestOptions(path: getAdditionalBenefitPurchasePath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getAdditionalBenefitPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.unexpectedError);
    });
  });

  //==========GET PACKAGE COMBO PURCHASE BY ID==========//
  group('get package combo purchase', () {
    membershipId = 'CNOC-2022-01-24-00';
    purchaseInvoiceId =
        'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363422';
    final getPackageComboPurchasePath = '$managingPurchaseInvoicePath/combo?'
        'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';

    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service'
        'and service http response code is 200 and response is not null,'
        'the invoiceState is accomplished and purchaseInvoiceDetail is not null',
        () async {
      when(mockDio.get(getPackageComboPurchasePath))
          .thenAnswer((_) async => Response(
                requestOptions:
                    RequestOptions(path: getPackageComboPurchasePath),
                statusCode: HttpStatus.ok,
                data: mockPackageComboPurchase,
              ));
      await purchaseInvoiceBLoC.getPackageComboPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.accomplished);
      expect(purchaseInvoiceBLoC.invoice, isNotNull);
      expect(purchaseInvoiceBLoC.invoice!.purchaseInvoiceId, purchaseInvoiceId);
    });
    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service'
        ' and service http response code is 200 and response is null,'
        ' the invoiceState is error and purchaseInvoiceDetail is null',
        () async {
      when(mockDio.get(getPackageComboPurchasePath))
          .thenAnswer((_) async => Response(
                requestOptions:
                    RequestOptions(path: getPackageComboPurchasePath),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await purchaseInvoiceBLoC.getPackageComboPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
      expect(purchaseInvoiceBLoC.invoice, isNull);
    });

    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service'
        ' and service http response code is 404, the '
        'invoiceState is a notFound', () async {
      when(mockDio.get(getPackageComboPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPackageComboPurchasePath),
          response: Response(
            requestOptions: RequestOptions(path: getPackageComboPurchasePath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage': 'There was an error getting the purchase invoice:: '
                  'PurchaseInvoice with id: '
                  'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720rr '
                  'was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getPackageComboPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.notFound);
    });

    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service '
        'and service http response with a connection time out, the invoiceState'
        ' is a error', () async {
      when(mockDio.get(getPackageComboPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPackageComboPurchasePath),
          response: Response(
              requestOptions: RequestOptions(path: getPackageComboPurchasePath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await purchaseInvoiceBLoC.getPackageComboPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
    });
    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service '
        'and service http response code is 502, the invoiceState is a '
        'unexpectedError', () async {
      when(mockDio.get(getPackageComboPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPackageComboPurchasePath),
          response: Response(
              requestOptions: RequestOptions(path: getPackageComboPurchasePath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getPackageComboPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.unexpectedError);
    });
  });

//==========GET PLAN PURCHASE BY ID==========//
  group('get plan purchase', () {
    membershipId = 'CNOC-2022-01-24-00';
    purchaseInvoiceId =
        'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946';
    final getPlanPurchasePath = '$managingPurchaseInvoicePath/plans?'
        'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';

    test(
        'if the user sends a getPlanPurchaseInvoiceById service'
        'and service http response code is 200 and response is not null,'
        'the invoiceState is accomplished and purchaseInvoiceDetail is not null',
        () async {
      when(mockDio.get(getPlanPurchasePath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPlanPurchasePath),
            statusCode: HttpStatus.ok,
            data: mockPlanPurchase,
          ));
      await purchaseInvoiceBLoC.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.accomplished);
      expect(purchaseInvoiceBLoC.invoice, isNotNull);
      expect(purchaseInvoiceBLoC.invoice!.purchaseInvoiceId, purchaseInvoiceId);
    });
    test(
        'if the user sends a getPlanPurchaseInvoiceById service'
        ' and service http response code is 200 and response is null,'
        ' the invoiceState is error and purchaseInvoiceDetail is null',
        () async {
      when(mockDio.get(getPlanPurchasePath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPlanPurchasePath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await purchaseInvoiceBLoC.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
      expect(purchaseInvoiceBLoC.invoice, isNull);
    });

    test(
        'if the user sends a getPlanPurchaseInvoiceById service'
        ' and service http response code is 404, the '
        'invoiceState is a notFound', () async {
      when(mockDio.get(getPlanPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlanPurchasePath),
          response: Response(
            requestOptions: RequestOptions(path: getPlanPurchasePath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage': 'There was an error getting the purchase invoice:: '
                  'PurchaseInvoice with id: '
                  'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720rr '
                  'was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.notFound);
    });

    test(
        'if the user sends a getPlanPurchaseInvoiceById service '
        'and service http response with a connection time out, the invoiceState'
        ' is a error', () async {
      when(mockDio.get(getPlanPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlanPurchasePath),
          response: Response(
              requestOptions: RequestOptions(path: getPlanPurchasePath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await purchaseInvoiceBLoC.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
    });
    test(
        'if the user sends a getPlanPurchaseInvoiceById service '
        'and service http response code is 502, the invoiceState is a '
        'unexpectedError', () async {
      when(mockDio.get(getPlanPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlanPurchasePath),
          response: Response(
              requestOptions: RequestOptions(path: getPlanPurchasePath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getPlanPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.unexpectedError);
    });
  });

  //==========GET LEVEL PURCHASE BY ID==========//
  group('get Level purchase', () {
    membershipId = 'CNOC-2022-01-24-00';
    purchaseInvoiceId =
        'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363872';
    final getLevelPurchasePath = '$managingPurchaseInvoicePath/level?'
        'membershipId=$membershipId&purchaseInvoiceId=$purchaseInvoiceId';

    test(
        'if the user sends a getLevelPurchaseInvoiceById service'
        'and service http response code is 200 and response is not null,'
        'the invoiceState is accomplished and purchaseInvoiceDetail is not null',
        () async {
      when(mockDio.get(getLevelPurchasePath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getLevelPurchasePath),
            statusCode: HttpStatus.ok,
            data: mockLevelPurchase,
          ));
      await purchaseInvoiceBLoC.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.accomplished);
      expect(purchaseInvoiceBLoC.invoice, isNotNull);
      expect(purchaseInvoiceBLoC.invoice!.purchaseInvoiceId, purchaseInvoiceId);
    });
    test(
        'if the user sends a getLevelPurchaseInvoiceById service'
        ' and service http response code is 200 and response is null,'
        ' the invoiceState is error and purchaseInvoiceDetail is null',
        () async {
      when(mockDio.get(getLevelPurchasePath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getLevelPurchasePath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await purchaseInvoiceBLoC.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
      expect(purchaseInvoiceBLoC.invoice, isNull);
    });

    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service'
        ' and service http response code is 404, the '
        'invoiceState is a notFound', () async {
      when(mockDio.get(getLevelPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelPurchasePath),
          response: Response(
            requestOptions: RequestOptions(path: getLevelPurchasePath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage': 'There was an error getting the purchase invoice:: '
                  'PurchaseInvoice with id: '
                  'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720rr '
                  'was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.notFound);
    });

    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service '
        'and service http response with a connection time out, the invoiceState'
        ' is a error', () async {
      when(mockDio.get(getLevelPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelPurchasePath),
          response: Response(
              requestOptions: RequestOptions(path: getLevelPurchasePath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await purchaseInvoiceBLoC.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState, InvoiceStateDeprecated.error);
    });
    test(
        'if the user sends a getPackageComboPurchaseInvoiceById service '
        'and service http response code is 502, the invoiceState is a '
        'unexpectedError', () async {
      when(mockDio.get(getLevelPurchasePath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelPurchasePath),
          response: Response(
              requestOptions: RequestOptions(path: getLevelPurchasePath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await purchaseInvoiceBLoC.getLevelPurchaseInvoiceById(
          membershipId: membershipId, purchaseInvoiceId: purchaseInvoiceId);
      expect(purchaseInvoiceBLoC.invoiceState,
          InvoiceStateDeprecated.unexpectedError);
    });
  });
}
