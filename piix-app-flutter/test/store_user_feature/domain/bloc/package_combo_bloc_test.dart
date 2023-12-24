import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_repository.dart';
import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_use_case_test.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/combo_quote_price_request_model.dart';

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
  final packageComboBLoC = PackageComboBLoC();
  final managingPackageComboPath =
      '${appConfig.backendEndpoint}/package-combos/user';
  final packageComboRepository = getIt<PackageCombosRepository>();
  final mockPackageComboList = packageComboRepository.fakePackageCombosJson;
  final mockPackageComboById = packageComboRepository.fakePackageComboByIdJson;
  PiixApiDeprecated.setDio(mockDio);
  late ComboQuotePriceRequestModel requestModel;
  late String membershipId;

  //==========GET PACKAGE COMBOS BY MEMBERSHIP ID==========//
  group('get package combos', () {
    membershipId = 'CNOC-2022-01-24-00';
    final getAllPath = '$managingPackageComboPath/byMembership?'
        'membershipId=$membershipId';

    test(
        'if the user sends a getPackageCombosByMembership service'
        ' and service http response code is 200 and response list is not empty, '
        'the packageComboState is accomplished and '
        'packageCombosList list is not empty', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: mockPackageComboList,
          ));
      await packageComboBLoC.getPackageCombosByMembership(
          membershipId: membershipId);
      expect(
          packageComboBLoC.packageComboState, PackageCombosState.accomplished);
      expect(packageComboBLoC.packageCombosList, isNotEmpty);
      //The mock data has ine pacakage combo that is why the length is expected to be 3
      expect(packageComboBLoC.packageCombosList.length, 1);
    });
    test(
        'if the user sends a getPackageCombosByMembership service'
        ' and service http response code is 200 and response list is empty,'
        ' the packageComboState is empty and '
        'packageCombosList list is empty', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: [],
          ));
      await packageComboBLoC.getPackageCombosByMembership(
          membershipId: membershipId);
      expect(packageComboBLoC.packageComboState, PackageCombosState.empty);
      expect(packageComboBLoC.packageCombosList, isEmpty);
    });

    test(
        'if the user sends a getPackageCombosByMembership service'
        ' and service http response code is 404, the '
        'packageComboState is a notFound', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the package combos:: Resource '
                      "with id 'CNOC-2022-01-24-00' not found",
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await packageComboBLoC.getPackageCombosByMembership(
          membershipId: membershipId);
      expect(packageComboBLoC.packageComboState, PackageCombosState.notFound);
    });

    test(
        'if the user sends a getPackageCombosByMembership service'
        ' and service http response code is 409, the '
        'packageComboState is a userNotMatchError', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage': 'There was an error getting the package combos:: The '
                  "current user's memberships does't match with the given membershipId.",
              'errorName': "Piix Error Membership does't match.",
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await packageComboBLoC.getPackageCombosByMembership(
          membershipId: membershipId);
      expect(packageComboBLoC.packageComboState, PackageCombosState.conflict);
    });
    test(
        'if the user sends a getPackageCombosByMembership service'
        ' and service http response with a conection time out, the '
        'packageComboState is a error', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await packageComboBLoC.getPackageCombosByMembership(
          membershipId: membershipId);
      expect(packageComboBLoC.packageComboState, PackageCombosState.error);
    });
    test(
        'if the user sends a getPackageCombosByMembership service'
        ' and service http response code is 502, the '
        'packageComboState is a unexpectedError', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await packageComboBLoC.getPackageCombosByMembership(
          membershipId: membershipId);
      expect(packageComboBLoC.packageComboState,
          PackageCombosState.unexpectedError);
    });
  });

  //=====GET PACKAGE COMBOS WITH DETAIL AND PRICE BY ID=====//
  group('get package combo with detail an price by id', () {
    requestModel = ComboQuotePriceRequestModel(
        packageComboId: 'CNOC-2022-Combo3', membershipId: 'CNOC-2022-01-24-00');
    final getAllPath = '$managingPackageComboPath/membership/'
        'detailsAndPrices?membershipId=${requestModel.membershipId}&'
        'packageComboId=${requestModel.packageComboId}';

    test(
        'if the user sends a getPackageCombosWithDetailsAndPriceByMembership service'
        ' and service http response code is 200 and response list is not empty, '
        'the packageComboState is accomplished and '
        'packageComboById is not null', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: mockPackageComboById,
          ));
      await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel);
      expect(
          packageComboBLoC.packageComboState, PackageCombosState.accomplished);
      expect(packageComboBLoC.packageComboWithPrices, isNotNull);
      expect(packageComboBLoC.packageComboWithPrices!.packageComboId,
          requestModel.packageComboId);
    });
    test(
        'if the user sends a getPackageCombosWithDetailsAndPriceByMembership service'
        ' and service http response code is 200 and response null,'
        ' the packageComboState is empty and '
        'packageComboById is null', () async {
      when(mockDio.get(getAllPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel);
      expect(packageComboBLoC.packageComboState, PackageCombosState.empty);
      expect(packageComboBLoC.packageComboWithPrices, null);
    });

    test(
        'if the user sends a getPackageCombosWithDetailsAndPriceByMembership service'
        ' and service http response code is 404, the '
        'packageComboState is a notFound', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the package combo:: Membership '
                      'with id: CNOC-2022-01-24-00 was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel);
      expect(packageComboBLoC.packageComboState, PackageCombosState.notFound);
    });

    test(
        'if the user sends a getPackageCombosWithDetailsAndPriceByMembership service'
        ' and service http response code is 409, the '
        'packageComboState is a userNotMatchError', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
            requestOptions: RequestOptions(path: getAllPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the package combo:: The given '
                      "combo does not belongs to the package of the user's membership.",
              'errorName': 'Piix Error Invalid combo.',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel);
      expect(packageComboBLoC.packageComboState, PackageCombosState.conflict);
    });
    test(
        'if the user sends a getPackageCombosWithDetailsAndPriceByMembership service'
        ' and service http response with a conection time out, the '
        'packageComboState is  a error', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel);
      expect(packageComboBLoC.packageComboState, PackageCombosState.error);
    });
    test(
        'if the user sends a getPackageCombosWithDetailsAndPriceByMembership service'
        ' and service http response code is 502, the '
        'packageComboState is a unexpectedError', () async {
      when(mockDio.get(getAllPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getAllPath),
          response: Response(
              requestOptions: RequestOptions(path: getAllPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await packageComboBLoC.getPackageCombosWithDetailsAndPriceByMembership(
          requestModel: requestModel);
      expect(packageComboBLoC.packageComboState,
          PackageCombosState.unexpectedError);
    });
  });
}
