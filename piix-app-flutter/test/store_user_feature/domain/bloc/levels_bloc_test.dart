import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_use_case_test.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/level_quote_price_request_model_deprecated.dart';

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
  final levelsBLoC = LevelsBLoCDeprecated();
  final managingLevelsPath = '${appConfig.backendEndpoint}/levels/user';
  final levelsRepository = getIt<LevelsRepositoryDeprecated>();
  final mockEcommerceLevels = levelsRepository.fakeLevelsJson;
  final mockEmptyEcommerceLevels = levelsRepository.fakeLevelsEmptyJson;
  final mockLevelQuotationByIds = levelsRepository.fakeLevelQuotationJson;
  PiixApiDeprecated.setDio(mockDio);
  late LevelQuotePriceRequestModel requestModel;
  late String membershipId;

  //=======================GET LEVELS BY MEMBERSHIP ID========================//
  group('get levels', () {
    membershipId = 'CNOC-2022-01-24-00';
    final getLevelsPath = '$managingLevelsPath/all?membershipId=$membershipId';

    test(
        'if the user sends a getLevelsByMembership service'
        'and service http response code is 200 and response list is not empty,'
        'the levelState is accomplished and '
        'levelList list is not empty', () async {
      when(mockDio.get(getLevelsPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getLevelsPath),
            statusCode: HttpStatus.ok,
            data: mockEcommerceLevels,
          ));
      await levelsBLoC.getLevelsByMembership(membershipId: membershipId);
      expect(levelsBLoC.levelState, LevelStateDeprecated.accomplished);
      expect(levelsBLoC.userEcommerceLevels!.levelList, isNotEmpty);
      //The mock data has fivelevels that is why the length is expected to be 5
      expect(levelsBLoC.userEcommerceLevels!.levelList.length, 5);
    });
    test(
        'if the user sends a getLevelsByMembership service'
        ' and service http response code is 200 and response list is empty,'
        ' the levelState is empty and '
        'levelList list is empty', () async {
      when(mockDio.get(getLevelsPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getLevelsPath),
            statusCode: HttpStatus.ok,
            data: mockEmptyEcommerceLevels,
          ));
      await levelsBLoC.getLevelsByMembership(membershipId: membershipId);
      expect(levelsBLoC.levelState, LevelStateDeprecated.empty);
      expect(levelsBLoC.userEcommerceLevels!.levelList, isEmpty);
    });

    test(
        'if the user sends a getLevelsByMembership service'
        ' and service http response code is 404, the '
        'levelState is a notFound', () async {
      when(mockDio.get(getLevelsPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelsPath),
          response: Response(
            requestOptions: RequestOptions(path: getLevelsPath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the levels info:: Membership with'
                      ' id: CNOC-2022-01-24-00 was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await levelsBLoC.getLevelsByMembership(membershipId: membershipId);
      expect(levelsBLoC.levelState, LevelStateDeprecated.notFound);
    });

    test(
        'if the user sends a getLevelsByMembership service'
        ' and service http response code is 409, the '
        'levelState is a userNotMatchError', () async {
      when(mockDio.get(getLevelsPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelsPath),
          response: Response(
            requestOptions: RequestOptions(path: getLevelsPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the levels info:: The current '
                      "user's memberships does't match with the given"
                      'membershipId.',
              'errorName': "Piix Error Membership does't match.",
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await levelsBLoC.getLevelsByMembership(membershipId: membershipId);
      expect(levelsBLoC.levelState, LevelStateDeprecated.conflict);
    });
    test(
        'if the user sends a getLevelsByMembership service'
        ' and service http response with a conection time out, the '
        'levelState is a error', () async {
      when(mockDio.get(getLevelsPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelsPath),
          response: Response(
              requestOptions: RequestOptions(path: getLevelsPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await levelsBLoC.getLevelsByMembership(membershipId: membershipId);
      expect(levelsBLoC.levelState, LevelStateDeprecated.error);
    });
    test(
        'if the user sends a getLevelsByMembership service'
        ' and service http response code is 502, the '
        'levelState is a unexpectedError', () async {
      when(mockDio.get(getLevelsPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getLevelsPath),
          response: Response(
              requestOptions: RequestOptions(path: getLevelsPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await levelsBLoC.getLevelsByMembership(membershipId: membershipId);
      expect(levelsBLoC.levelState, LevelStateDeprecated.unexpectedError);
    });
  });

  //=======================GET LEVEL QUOTATION BY ID==========================//
  group('get level quotation by id', () {
    requestModel = LevelQuotePriceRequestModel(
        levelId: 'level2', membershipId: 'CNOC-2022-01-24-00');
    final getQuotationPath = '$managingLevelsPath/membership/quotation?'
        'membershipId=${requestModel.membershipId}&'
        'levelId=${requestModel.levelId}';

    test(
        'if the user sends a getLevelQuotationByMembership service'
        ' and service http response code is 200 and response list is not empty,'
        'the levelState is accomplished and '
        'levelQuotation is not null', () async {
      when(mockDio.get(getQuotationPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.ok,
            data: mockLevelQuotationByIds,
          ));
      await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel);
      expect(levelsBLoC.levelState, LevelStateDeprecated.accomplished);
      expect(levelsBLoC.levelQuotation, isNotNull);
      expect(levelsBLoC.levelQuotation!.level.levelId, requestModel.levelId);
    });
    test(
        'if the user sends a getLevelQuotationByMembership service'
        ' and service http response code is 200 and response null,'
        ' the levelState is error and '
        'levelQuotation is null', () async {
      when(mockDio.get(getQuotationPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel);
      expect(levelsBLoC.levelState, LevelStateDeprecated.error);
      expect(levelsBLoC.levelQuotation, null);
    });

    test(
        'if the user sends a getLevelQuotationByMembership service'
        ' and service http response code is 404, the '
        'levelState is a notFound', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the level quotation:: Membership '
                      'with id: CNOC-2022-01-00-00 was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel);
      expect(levelsBLoC.levelState, LevelStateDeprecated.notFound);
    });

    test(
        'if the user sends a getLevelQuotationByMembership service'
        ' and service http response code is 409, the '
        'levelState is a userNotMatchError', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the level quotation:: The current'
                      "user's memberships does't match with the given"
                      'membershipId.',
              'errorName': "Piix Error Membership does't match.",
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel);
      expect(levelsBLoC.levelState, LevelStateDeprecated.conflict);
    });
    test(
        'if the user sends a getLevelQuotationByMembership service'
        ' and service http response with a conection time out, the '
        'levelState is  a error', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
              requestOptions: RequestOptions(path: getQuotationPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel);
      expect(levelsBLoC.levelState, LevelStateDeprecated.error);
    });
    test(
        'if the user sends a getLevelQuotationByMembership service'
        ' and service http response code is 502, the '
        'levelState is a unexpectedError', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
              requestOptions: RequestOptions(path: getQuotationPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await levelsBLoC.getLevelQuotationByMembership(
          requestModel: requestModel);
      expect(levelsBLoC.levelState, LevelStateDeprecated.unexpectedError);
    });
  });
}
