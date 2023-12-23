import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/env/dev.env.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_use_case_test.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_info_model.dart';

import '../../../general_app_feature/api/mock_dio.mocks.dart';

//TODO: Fix how the membership is being retrieved
void main() {
  setupGetIt();
  final appConfig = AppConfig.instance;
  appConfig
    ..setBackendEndPoint(DevEnv.backendEndpoint)
    ..setCatalogSQLURL(DevEnv.catalogEndpoint)
    ..setSignUpEndpoint(DevEnv.signUpEndpoint)
    ..setPaymentEndpoint(DevEnv.paymentEndpoint);
  final mockDio = MockDio();
  final membershipInfoBLoC = MembershipProviderDeprecated();
  final membershipInfoRepository = getIt<MembershipInfoRepositoryDeprecated>();
  final fakeJsonMembership = membershipInfoRepository.fakeMembershipInfoJson();
  final fakeJsonAdditionalMembership =
      membershipInfoRepository.fakeAdditionalMembershipInfoJson();
  const membershipId = '21e1f38b93f9c2c10adc58b9c1';
  const packageId = 'CNOC-2022-01';
  late RequestMembershipInfoModel requestModel;
  final membership = membershipInfoBLoC.selectedMembership;
  PiixApiDeprecated.setDio(mockDio);
  var path = '';
  group('get membership info', () {
    setUpAll(() {
      requestModel =
          const RequestMembershipInfoModel(membershipId: membershipId);
      path =
          '${appConfig.backendEndpoint}/membership/main-info?membershipId=${requestModel.membershipId}';
    });
    setUp(() {
      membershipInfoBLoC.membershipInfoState =
          MembershipInfoStateDeprecated.idle;
      membershipInfoBLoC.setSelectedMembership(null);
    });

    test(
        'when the service http code response is 200, and includes '
        'data for a valid MembershipInfoModel, the MembershipInfoState is retrieved',
        () async {
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.idle);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakeJsonMembership,
          ));
      await membershipInfoBLoC.getMembershipInfo(membership: membership!);
      expect(membership.folio, fakeJsonMembership['folio']);
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 but does not include '
        'data for a valid MembershipInfoModel, the MembershipInfoState is error',
        () async {
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.idle);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: null,
          ));
      await membershipInfoBLoC.getMembershipInfo(membership: membership!);
      expect(membership.folio, null);
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.error);
    });

    test(
        'when the service http code response is 404, '
        'the MembershipInfoState is notFound', () async {
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.idle);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.notFound,
          data: <String, dynamic>{
            'errorName': 'Piix Error Resource not found',
            'errorMessage':
                'There was an error finding the membership information',
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await membershipInfoBLoC.getMembershipInfo(membership: membership!);
      expect(membership.folio, null);
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.notFound);
    });
  });

  group('get membership info exceptions', () {
    setUpAll(() {
      requestModel =
          const RequestMembershipInfoModel(membershipId: membershipId);
      path =
          '${appConfig.backendEndpoint}/membership/main-info?membershipId=${requestModel.membershipId}';
    });
    setUp(() {
      membershipInfoBLoC.membershipInfoState =
          MembershipInfoStateDeprecated.idle;
      membershipInfoBLoC.setSelectedMembership(null);
    });

    test(
        'when the service http code response is 400, '
        'the MembershipInfoState is error', () async {
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.idle);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.badRequest,
          data: <String, dynamic>{
            'errorName': 'Piix Error Bad Request',
            'errorMessage': "The server can't send a response",
            'errorMessages': '[]'
          },
        ),
        type: DioErrorType.badResponse,
      ));
      await membershipInfoBLoC.getMembershipInfo(membership: membership!);
      expect(membership.folio, null);
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.error);
    });

    test(
        'when the app throws a DioErrorType ConnectionTimeout, '
        'the MembershipInfoState is error', () async {
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.idle);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(path: path),
        type: DioErrorType.connectionTimeout,
      ));
      await membershipInfoBLoC.getMembershipInfo(membership: membership!);
      expect(membership.folio, null);
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.error);
    });

    test(
        'when the app throws a DioErrorType Other, the MembershipInfoState is error',
        () async {
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.idle);
      when(mockDio.get(path)).thenThrow(DioError(
        requestOptions: RequestOptions(
          path: path,
        ),
        type: DioErrorType.sendTimeout,
      ));
      await membershipInfoBLoC.getMembershipInfo(membership: membership!);
      expect(membership.folio, null);
      expect(membershipInfoBLoC.membershipInfoState,
          MembershipInfoStateDeprecated.error);
    });
  });
}
