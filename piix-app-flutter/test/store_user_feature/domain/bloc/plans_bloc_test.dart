import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_use_case_test.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/plans_quote_price_request_model_deprecated.dart';

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
  final plansBLoC = PlansBLoCDeprecated();
  final managingPlansPath = '${appConfig.backendEndpoint}/plans/user';
  final plansRepository = getIt<PlansRepositoryDeprecated>();
  final mockPlansList = plansRepository.fakePlansJson;
  final mockEmptyPlansList = plansRepository.fakePlansEmptyJson;
  final mockPlanQuotationByIds = plansRepository.fakePlanQuotationJson;
  final mockEmptyPlanQuotationByIds =
      plansRepository.fakePlanEmptyQuotationJson;
  PiixApiDeprecated.setDio(mockDio);
  late PlansQuotePriceRequestModel requestModel;
  late String membershipId;

  //=======================GET PLANS BY MEMBERSHIP ID========================//
  group('get plans', () {
    membershipId = 'CNOC-2022-01-24-00';
    final getPlansPath = '$managingPlansPath/all?membershipId=$membershipId';

    test(
        'if the user sends a getPlansByMembership service'
        ' and service http response code is 200 and response list is not empty, '
        'the planState is accomplished and '
        'plansList list is not empty', () async {
      when(mockDio.get(getPlansPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPlansPath),
            statusCode: HttpStatus.ok,
            data: mockPlansList,
          ));
      await plansBLoC.getPlansByMembership(membershipId: membershipId);
      expect(plansBLoC.planState, PlanStateDeprecated.accomplished);
      expect(plansBLoC.plansList!.plans, isNotEmpty);
      //The mock data has two plans that is why the length is expected to be 2
      expect(plansBLoC.plansList!.plans.length, 2);
    });
    test(
        'if the user sends a getPlansByMembership service'
        ' and service http response code is 200 and response list is empty,'
        ' the planState is empty and '
        'plansList list is empty', () async {
      when(mockDio.get(getPlansPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getPlansPath),
            statusCode: HttpStatus.ok,
            data: mockEmptyPlansList,
          ));
      await plansBLoC.getPlansByMembership(membershipId: membershipId);
      expect(plansBLoC.planState, PlanStateDeprecated.empty);
      expect(plansBLoC.plansList!.plans, isEmpty);
    });

    test(
        'if the user sends a getPlansByMembership service'
        ' and service http response code is 404, the '
        'planState is a notFound', () async {
      when(mockDio.get(getPlansPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlansPath),
          response: Response(
            requestOptions: RequestOptions(path: getPlansPath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the plans info:: Membership with'
                      ' id: CNOC-2022-01-24-00pp was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await plansBLoC.getPlansByMembership(membershipId: membershipId);
      expect(plansBLoC.planState, PlanStateDeprecated.notFound);
    });

    test(
        'if the user sends a getPlansByMembership service'
        ' and service http response code is 409, the '
        'planState is a userNotMatchError', () async {
      when(mockDio.get(getPlansPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlansPath),
          response: Response(
            requestOptions: RequestOptions(path: getPlansPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the plans info:: The current '
                      "user's memberships does't match with the given"
                      'membershipId.',
              'errorName': "Piix Error Membership does't match.",
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await plansBLoC.getPlansByMembership(membershipId: membershipId);
      expect(plansBLoC.planState, PlanStateDeprecated.conflict);
    });
    test(
        'if the user sends a getPlansByMembership service'
        ' and service http response with a conection time out, the '
        'planState is a error', () async {
      when(mockDio.get(getPlansPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlansPath),
          response: Response(
              requestOptions: RequestOptions(path: getPlansPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await plansBLoC.getPlansByMembership(membershipId: membershipId);
      expect(plansBLoC.planState, PlanStateDeprecated.error);
    });
    test(
        'if the user sends a getPlansByMembership service'
        ' and service http response code is 502, the '
        'planState is a unexpectedError', () async {
      when(mockDio.get(getPlansPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getPlansPath),
          response: Response(
              requestOptions: RequestOptions(path: getPlansPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await plansBLoC.getPlansByMembership(membershipId: membershipId);
      expect(plansBLoC.planState, PlanStateDeprecated.unexpectedError);
    });
  });

  //=======================GET PLAN QUOTATION BY ID===========================//
  group('get plans quotation by id', () {
    requestModel = PlansQuotePriceRequestModel(
        planIds: 'd34662902dc43f109ff0e0440b1d18ecb226019e5f520ef9be',
        membershipId: 'CNOC-2022-01-24-00');
    final getQuotationPath = '$managingPlansPath/membership/quotation?'
        'membershipId=${requestModel.membershipId}&'
        'planIds=${requestModel.planIds}';

    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response code is 200 and response list is not empty,'
        'the planState is accomplished and '
        'planQuotation is not null', () async {
      when(mockDio.get(getQuotationPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.ok,
            data: mockPlanQuotationByIds,
          ));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.accomplished);
      expect(plansBLoC.planQuotation, isNotNull);
      expect(plansBLoC.planQuotation!.plans[0].planId, requestModel.planIds);
    });
    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response code is 200 and response null,'
        ' the planState is error and '
        'planQuotation is null', () async {
      when(mockDio.get(getQuotationPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.error);
      expect(plansBLoC.planQuotation, null);
    });

    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response code is 200 and response is not empty,'
        'but list of plans is empty, the planState is empty', () async {
      when(mockDio.get(getQuotationPath)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.ok,
            data: mockEmptyPlanQuotationByIds,
          ));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.empty);
      expect(plansBLoC.planQuotation!.plans, isEmpty);
    });

    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response code is 404, the '
        'planState is a notFound', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.notFound,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the plans quotation:: Membership '
                      'with id: CNOC-2022-01-00-00pp was not found.',
              'errorName': 'Piix Error Resource not found',
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.notFound);
    });

    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response code is 409, the '
        'planState is a userNotMatchError', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
            requestOptions: RequestOptions(path: getQuotationPath),
            statusCode: HttpStatus.conflict,
            data: <String, dynamic>{
              'errorMessage':
                  'There was an error getting the plans quotation:: The current'
                      "user's memberships does't match with the given"
                      'membershipId.',
              'errorName': "Piix Error Membership does't match.",
              'errorMessages': []
            },
          ),
          type: DioErrorType.badResponse));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.conflict);
    });
    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response with a conection time out, the '
        'planState is  a error', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
              requestOptions: RequestOptions(path: getQuotationPath),
              statusCode: HttpStatus.networkConnectTimeoutError,
              data: <String, dynamic>{
                'errorMessage': 'Connection time out',
              }),
          type: DioErrorType.connectionTimeout));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.error);
    });
    test(
        'if the user sends a getPlansQuotationByMembership service'
        ' and service http response code is 502, the '
        'planState is a unexpectedError', () async {
      when(mockDio.get(getQuotationPath)).thenThrow(DioError(
          requestOptions: RequestOptions(path: getQuotationPath),
          response: Response(
              requestOptions: RequestOptions(path: getQuotationPath),
              statusCode: HttpStatus.badGateway,
              data: <String, dynamic>{
                'errorMessage': 'There was an unexpected error',
              }),
          type: DioErrorType.badResponse));
      await plansBLoC.getPlansQuotationByMembership(requestModel: requestModel);
      expect(plansBLoC.planState, PlanStateDeprecated.unexpectedError);
    });
  });
}
