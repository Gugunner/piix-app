import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_use_case_test.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/additional_benefit_per_supplier_quote_price_request_model_deprecated.dart';

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
  final additionalBenefitsPerSupplierBLoC =
      AdditionalBenefitsPerSupplierBLoCDeprecated();
  final managingAdditionalBenefitPerSupplierPath =
      '${appConfig.backendEndpoint}/additional-benefits-per-supplier/user';
  final additionalBenefitPerSupplierRepository =
      getIt<AdditionalBenefitsPerSupplierRepositoryDeprecated>();
  final mockAdditionalBenefitPerSupplierList =
      additionalBenefitPerSupplierRepository.fakeAdditionalBenefitsJson;
  final mockAdditionalBenefitPerSupplierById =
      additionalBenefitPerSupplierRepository.fakeAdditionalBenefitByIdJson;
  PiixApiDeprecated.setDio(mockDio);
  late AdditionalBenefitPerSupplierQuotePriceRequestModel requestModel;
  late String membershipId;

  //==========GET ADDITIONAL BENEFITS PER SUPPLIER BY MEMBERSHIP ID==========//
  group('get additional benefits per supplier', () {
    membershipId = 'CNC2021-01-00';
    final getAllPath = '$managingAdditionalBenefitPerSupplierPath/byMembership?'
        'membershipId=$membershipId';

    test(
        'if the user sends a getAdditionalBenefitsPerSupplierByMembership service'
        ' and service http response code is 200 and response list is not empty, '
        'the additionalBenefitPerSupplierState is accomplished and '
        'additionalBenefitsPerSupplierList list is not empty', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: mockAdditionalBenefitPerSupplierList,
          ));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitsPerSupplierByMembership(
              membershipId: membershipId);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.accomplished);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitsPerSupplierList,
          isNotEmpty);
      //The mock data has three additionalBenefitsPerSupplier that is why the length is expected to be 3
      expect(
          additionalBenefitsPerSupplierBLoC
              .additionalBenefitsPerSupplierList.length,
          3);
    });
    test(
        'if the user sends a getAdditionalBenefitsPerSupplierByMembership service'
        ' and service http response code is 200 and response list is empty,'
        ' the additionalBenefitPerSupplierState is empty and '
        'additionalBenefitsPerSupplierList list is empty', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: [],
          ));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitsPerSupplierByMembership(
              membershipId: membershipId);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.empty);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitsPerSupplierList,
          isEmpty);
    });

    test(
        'if the user sends a getAdditionalBenefitsPerSupplierByMembership service'
        ' and service http response code is 404, the '
        'additionalBenefitPerSupplierStateis State is a notFound', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.notFound,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error getting the additional benefits per '
                        "supplier:: Resource with id 'CNC2021-01-00' not found",
                'errorName': 'Piix Error Resource not found',
                'errorMessages': []
              }),
          type: DioErrorType.badResponse));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitsPerSupplierByMembership(
              membershipId: membershipId);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.notFound);
    });

    test(
        'if the user sends a getAdditionalBenefitsPerSupplierByMembership service'
        ' and service http response code is 409, the '
        'additionalBenefitPerSupplierStateis State is a userNotMatchError',
        () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.conflict,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error getting the additional benefits per '
                        "supplier:: The current user's memberships does't match "
                        'with the given membershipId.',
                'errorName': "Piix Error Membership does't match.",
                'errorMessages': []
              }),
          type: DioErrorType.badResponse));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitsPerSupplierByMembership(
              membershipId: membershipId);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.userNotMatchError);
    });
    test(
        'if the user sends a getAdditionalBenefitsPerSupplierByMembership service'
        ' and service http response with a conection time out, the '
        'additionalBenefitPerSupplierStateis a error', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitsPerSupplierByMembership(
              membershipId: membershipId);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.error);
    });
    test(
        'if the user sends a getAdditionalBenefitsPerSupplierByMembership service'
        ' and service http response code is 502, the '
        'additionalBenefitPerSupplierStateis State is a unexpectedError',
        () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitsPerSupplierByMembership(
              membershipId: membershipId);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.unexpectedError);
    });
  });

  //=====GET ADDITIONAL BENEFITS PER SUPPLIER WITH DETAIL AND PRICE BY ID=====//
  group('get additional benefits per supplier with detail an price by id', () {
    requestModel = AdditionalBenefitPerSupplierQuotePriceRequestModel(
        additionalBenefitPerSupplierId: 'CNC2021-AOPS061100-000',
        membershipId: 'CNC2021-01-00');
    final getAllPath = '$managingAdditionalBenefitPerSupplierPath/membership/'
        'detailsAndPrices?membershipId=${requestModel.membershipId}&'
        'additionalBenefitPerSupplierId=${requestModel.additionalBenefitPerSupplierId}';

    test(
        'if the user sends a getAdditionalBenefitPerSupplierDetailsAndPrice service'
        ' and service http response code is 200 and response list is not empty, '
        'the additionalBenefitPerSupplierState is accomplished and '
        'additionalBenefitsPerSupplierById is not null', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: mockAdditionalBenefitPerSupplierById,
          ));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitPerSupplierDetailsAndPrice(
              requestModel: requestModel);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.accomplished);
      expect(
          additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier,
          isNotNull);
      expect(
          additionalBenefitsPerSupplierBLoC
              .currentAdditionalBenefitPerSupplier!.benefitPerSupplierId,
          requestModel.additionalBenefitPerSupplierId);
    });
    test(
        'if the user sends a getAdditionalBenefitPerSupplierDetailsAndPrice service'
        ' and service http response code is 200 and response null,'
        ' the additionalBenefitPerSupplierState is empty and '
        'additionalBenefitsPerSupplierById is null', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitPerSupplierDetailsAndPrice(
              requestModel: requestModel);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.empty);
      expect(
          additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier,
          null);
    });

    test(
        'if the user sends a getAdditionalBenefitPerSupplierDetailsAndPrice service'
        ' and service http response code is 404, the '
        'additionalBenefitPerSupplierStateis State is a notFound', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.notFound,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error getting the additional benefit per '
                        'supplier:: Membership with id: CNC2021-01-00 was not found.',
                'errorName': 'Piix Error Resource not found',
                'errorMessages': []
              }),
          type: DioErrorType.badResponse));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitPerSupplierDetailsAndPrice(
              requestModel: requestModel);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.notFound);
    });

    test(
        'if the user sends a getAdditionalBenefitPerSupplierDetailsAndPrice service'
        ' and service http response code is 409, the '
        'additionalBenefitPerSupplierStateis State is a userNotMatchError',
        () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the additional benefit per '
                      'supplier:: The given additional benefit does not belongs to '
                      "the package of the user's membership.",
              'errorName': 'Piix Error Invalid additional benefit.',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitPerSupplierDetailsAndPrice(
              requestModel: requestModel);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.userNotMatchError);
    });
    test(
        'if the user sends a getAdditionalBenefitPerSupplierDetailsAndPrice service'
        ' and service http response with a conection time out, the '
        'additionalBenefitPerSupplierStateis a error', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitPerSupplierDetailsAndPrice(
              requestModel: requestModel);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.error);
    });
    test(
        'if the user sends a getAdditionalBenefitPerSupplierDetailsAndPrice service'
        ' and service http response code is 502, the '
        'additionalBenefitPerSupplierStateis State is a unexpectedError',
        () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await additionalBenefitsPerSupplierBLoC
          .getAdditionalBenefitPerSupplierDetailsAndPrice(
              requestModel: requestModel);
      expect(
          additionalBenefitsPerSupplierBLoC.additionalBenefitPerSupplierState,
          AdditionalBenefitsPerSupplierStateDeprecated.unexpectedError);
    });
  });
}
