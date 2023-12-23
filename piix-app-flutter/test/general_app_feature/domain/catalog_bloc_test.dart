import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository_app-use_test.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/model/country_model.dart';

import '../api/mock_dio.mocks.dart';

void main() {
  setupGetIt();
  final appConfig = AppConfig.instance;
  appConfig
    ..setBackendEndPoint(DevEnv.backendEndpoint)
    ..setCatalogSQLURL(DevEnv.catalogEndpoint)
    ..setSignUpEndpoint(DevEnv.signUpEndpoint)
    ..setPaymentEndpoint(DevEnv.paymentEndpoint);
  final catalogBLoC = CatalogBLoC();
  final mockDio = MockDio();
  PiixApiDeprecated.setDio(mockDio);
  const countryId = 'MEX';
  var path = '';
  late CatalogName catalogName;
  final catalogRepository = getIt<CatalogRepository>();
  final fakeCountries = catalogRepository.fakeJsonCountries();
  final fakeGenders = catalogRepository.fakeJsonGenders();
  final fakeKinships = catalogRepository.fakeJsonKinships();
  final fakePrefixes = catalogRepository.fakeJsonPrefixes();
  final fakeStates = catalogRepository.fakeJsonStates();
  late CountryModel countryModel;

  group('get all from catalog name', () {
    setUpAll(() {
      countryModel = CountryModel(countryId: countryId);
    });

    setUp(() {
      catalogBLoC
        ..catalogState = CatalogStateDeprecated.idle
        ..countries = []
        ..genders = []
        ..kinships = []
        ..prefixes = []
        ..states = [];
    });

    test(
        'when the service http code response is 200 and includes valid data '
        'for a SelectorsModel of countries, CatalogBLoC countries property is filled and '
        'the CatalogState is retrieved', () async {
      path = 'https://${appConfig.catalogEndpoint}/country/getAll';
      catalogName = CatalogName.countries;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.countries.isEmpty, true);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakeCountries,
          ));
      await catalogBLoC.getAllFromCatalogName(catalogName);
      expect(catalogBLoC.countries.isNotEmpty, true);
      expect(catalogBLoC.countries.first.id, fakeCountries.first['countryId']);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 and includes valid data '
        'for a SelectorsModel of genders, CatalogBLoC genders property is filled and '
        'the CatalogState is retrieved', () async {
      path = 'https://${appConfig.catalogEndpoint}/gender/getAll';
      catalogName = CatalogName.genders;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.genders.isEmpty, true);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakeGenders,
          ));
      await catalogBLoC.getAllFromCatalogName(catalogName);
      expect(catalogBLoC.genders.isNotEmpty, true);
      expect(catalogBLoC.genders.first.id, fakeGenders.first['genderId']);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 and includes valid data '
        'for a SelectorsModel of kinships, CatalogBLoC kinships property is filled and '
        'the CatalogState is retrieved', () async {
      path = 'https://${appConfig.catalogEndpoint}/kinship/getAll';
      catalogName = CatalogName.kinships;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.kinships.isEmpty, true);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakeKinships,
          ));
      await catalogBLoC.getAllFromCatalogName(catalogName);
      expect(catalogBLoC.kinships.isNotEmpty, true);
      expect(catalogBLoC.kinships.first.id, fakeKinships.first['kinshipId']);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 and includes valid data '
        'for a SelectorsModel of prefixes, CatalogBLoC prefixes property is filled and '
        'the CatalogState is retrieved', () async {
      path = 'https://${appConfig.catalogEndpoint}/prefix/getAll';
      catalogName = CatalogName.prefixes;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.prefixes.isEmpty, true);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakePrefixes,
          ));
      await catalogBLoC.getAllFromCatalogName(catalogName);
      expect(catalogBLoC.prefixes.isNotEmpty, true);
      expect(catalogBLoC.prefixes.first.id, fakePrefixes.first['prefixId']);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 and includes valid data '
        'for a SelectorsModel of states, CatalogBLoC states property is filled and '
        'the CatalogState is retrieved', () async {
      path =
          'https://${appConfig.catalogEndpoint}/state/getAllByCountryId?countryId=${countryModel.countryId}';
      catalogName = CatalogName.states;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.states.isEmpty, true);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakeStates,
          ));
      await catalogBLoC.getAllFromCatalogName(catalogName, countryId);
      expect(catalogBLoC.states.isNotEmpty, true);
      expect(catalogBLoC.states.first.id, fakeStates.first['stateId']);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.retrieved);
    });
  });

  group('get all from catalog name exceptions', () {
    setUpAll(() {
      countryModel = CountryModel(countryId: countryId);
    });

    setUp(() {
      catalogBLoC
        ..catalogState = CatalogStateDeprecated.idle
        ..countries = []
        ..genders = []
        ..kinships = []
        ..prefixes = []
        ..states = [];
    });
    test(
        'when the service http code response is 409, whatever CatalogBLoC property of SelectorsModel was called '
        'is empty and the CatalogState is empty', () async {
      path =
          'https://${appConfig.catalogEndpoint}/state/getAllByCountryId?countryId=${countryModel.countryId}';
      catalogName = CatalogName.states;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.states.isEmpty, true);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.conflict,
          data: <String, dynamic>{
            'errorName': 'Piix Error Resource Conflict',
            'errorMessage': 'There was an error with the catalog requested',
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await catalogBLoC.getAllFromCatalogName(catalogName, countryId);
      expect(catalogBLoC.states.isNotEmpty, false);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.isEmpty);
    });

    test(
        'when the service http code response is 400, whatever CatalogBLoC property of SelectorsModel was called '
        'is empty and the CatalogState is error', () async {
      path =
          'https://${appConfig.catalogEndpoint}/state/getAllByCountryId?countryId=${countryModel.countryId}';
      catalogName = CatalogName.states;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.states.isEmpty, true);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.badRequest,
          data: <String, dynamic>{
            'errorName': 'Piix Error Bad Request',
            'errorMessage': "The catalog can't be requested this way",
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await catalogBLoC.getAllFromCatalogName(catalogName, countryId);
      expect(catalogBLoC.states.isNotEmpty, false);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.error);
    });

    test(
        'when the app throws a DioErrorType connection timeout, the CatalogState is error',
        () async {
      path =
          'https://${appConfig.catalogEndpoint}/state/getAllByCountryId?countryId=${countryModel.countryId}';
      catalogName = CatalogName.states;
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.idle);
      expect(catalogBLoC.states.isEmpty, true);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        type: DioErrorType.connectionTimeout,
      ));
      await catalogBLoC.getAllFromCatalogName(catalogName, countryId);
      expect(catalogBLoC.states.isNotEmpty, false);
      expect(catalogBLoC.catalogState, CatalogStateDeprecated.error);
    });
  });
}
