import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_use_case_test.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/request_benefit_per_supplier_model.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';

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
  final benefitPerSupplierBLoC = BenefitPerSupplierBLoCDeprecated();
  var fakeBenefitPerSupplierJson = <String, dynamic>{};
  var benefitPerSupplierId = '';
  var path = '';
  PiixApiDeprecated.setDio(mockDio);
  const userId = 'cbb3c0b45ccf0871d8bf101c';
  const levelId = 'cbb3c0b45ccf0871d8bf101g';
  const membershipId = 'cbb3c0b45ccf0871d8bf101t';
  late RequestBenefitPerSupplierModel requestModel;

  group('get benefit per supplier without cobenefits', () {
    setUpAll(() {
      benefitPerSupplierId = 'Preview123-A020520000-000';
      requestModel = RequestBenefitPerSupplierModel(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      fakeBenefitPerSupplierJson =
          getIt<BenefitPerSupplierRepositoryDeprecated>()
              .fakeBenefitPerSupplierJson(benefitPerSupplierId);
      path = '${appConfig.backendEndpoint}/package/supplier/benefit?'
          'benefitPerSupplierId=${requestModel.benefitPerSupplierId}&userId=${requestModel.userId}';
    });

    setUp(() {
      benefitPerSupplierBLoC.benefitPerSupplierState =
          BenefitPerSupplierStateDeprecated.idle;
      benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(null);
    });

    test(
        'when the service http code response is 200 and includes '
        'data for a valid BenefitPerSupplierModel the BenefitPerSupplierState is retrieved',
        () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);

      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 200,
            data: fakeBenefitPerSupplierJson,
          ));
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      expect(
          benefitPerSupplierBLoC.selectedBenefitPerSupplier
              ?.mapOrNull((value) => value)
              ?.benefitPerSupplierId,
          fakeBenefitPerSupplierJson['benefitPerSupplierId']);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 and does not include '
        'data for a valid BenefitPerSupplierModel the BenefitPerSupplierState is error',
        () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);

      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 200,
            data: null,
          ));
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.error);
    });

    test(
        'when the service http code response is 404, '
        'the BenefitPerSupplierState is notFound', () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);

      when(mockDio.get(path)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 404,
            data: <String, dynamic>{
              'errorName': 'Piix Error Resource not found',
              'errorMessage':
                  'There was an error finding the benefit per supplier information',
              'errorMessages': '[]'
            },
          ),
          type: DioErrorType.badResponse,
        ),
      );
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.notFound);
    });
  });

  group('get benefit per supplier with cobenefits', () {
    setUpAll(() {
      benefitPerSupplierId = 'OpsPaqueteEnrique-Z900204000-000';
      requestModel = RequestBenefitPerSupplierModel(
          benefitPerSupplierId: benefitPerSupplierId,
          userId: userId,
          membershipId: levelId);
      fakeBenefitPerSupplierJson =
          getIt<BenefitPerSupplierRepositoryDeprecated>()
              .fakeBenefitPerSupplierJson(benefitPerSupplierId);
      path = '${appConfig.backendEndpoint}/package/supplier/benefit?'
          'benefitPerSupplierId=${requestModel.benefitPerSupplierId}&userId=${requestModel.userId}&levelId=${requestModel.membershipId}';
    });

    setUp(() {
      benefitPerSupplierBLoC.benefitPerSupplierState =
          BenefitPerSupplierStateDeprecated.idle;
      benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(null);
    });

    test(
        'when the service http code response is 200 and includes '
        'data for a valid BenefitPerSupplierModel the BenefitPerSupplierState is retrieved',
        () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 200,
            data: fakeBenefitPerSupplierJson,
          ));
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
          benefitPerSupplierId: benefitPerSupplierId,
          userId: userId,
          membershipId: levelId);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.retrieved);
      expect(
          benefitPerSupplierBLoC.selectedBenefitPerSupplier
              ?.mapOrNull((value) => value)
              ?.benefitPerSupplierId,
          fakeBenefitPerSupplierJson['benefitPerSupplierId']);
    });
    test(
        'when the service http code response is 200 and does not include '
        'data for a valid BenefitPerSupplierModel the BenefitPerSupplierState is error',
        () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 200,
            data: null,
          ));
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
          benefitPerSupplierId: benefitPerSupplierId,
          userId: userId,
          membershipId: levelId);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.error);
    });
    test(
        'when the service http code response is 404, '
        'the BenefitPerSupplierState is notFound', () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);

      when(mockDio.get(path)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 404,
            data: <String, dynamic>{
              'errorName': 'Piix Error Resource not found',
              'errorMessage':
                  'There was an error finding the benefit per supplier information',
              'errorMessages': '[]'
            },
          ),
          type: DioErrorType.badResponse,
        ),
      );
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
          benefitPerSupplierId: benefitPerSupplierId,
          userId: userId,
          membershipId: levelId);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.notFound);
    });
  });

  group('get benefit per supplier exceptions', () {
    setUpAll(() {
      benefitPerSupplierId = 'OpsPaqueteEnrique-Z900204000-000';
      requestModel = RequestBenefitPerSupplierModel(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      fakeBenefitPerSupplierJson =
          getIt<BenefitPerSupplierRepositoryDeprecated>()
              .fakeBenefitPerSupplierJson(benefitPerSupplierId);
      path = '${appConfig.backendEndpoint}/package/supplier/benefit?'
          'benefitPerSupplierId=${requestModel.benefitPerSupplierId}&userId=${requestModel.userId}';
    });

    setUp(() {
      benefitPerSupplierBLoC.benefitPerSupplierState =
          BenefitPerSupplierStateDeprecated.idle;
      benefitPerSupplierBLoC.setSelectedBenefitPerSupplier(null);
    });

    test(
        'when the service http code response is 400, '
        'the BenefitPerSupplierState is error', () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: 400,
          data: <String, dynamic>{
            'errorName': 'Piix Error Bad Request',
            'errorMessage': "The server can't send a response",
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.error);
    });

    test(
        'when the app throws a DioErrorType ConnectionTimeout, '
        'the BenefitPerSupplierState is error', () async {
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.idle);
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        type: DioErrorType.connectionTimeout,
      ));
      await benefitPerSupplierBLoC.getBenefitPerSupplier(
        benefitPerSupplierId: benefitPerSupplierId,
        userId: userId,
        membershipId: membershipId,
      );
      expect(benefitPerSupplierBLoC.selectedBenefitPerSupplier, null);
      expect(benefitPerSupplierBLoC.benefitPerSupplierState,
          BenefitPerSupplierStateDeprecated.error);
    });
  });
}
