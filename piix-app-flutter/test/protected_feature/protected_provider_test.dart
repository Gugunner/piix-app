import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository_test.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/bloc/protected_provider.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/request_available_protected_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../general_app_feature/api/mock_dio.mocks.dart';
import '../general_app_feature/api/test_endpoints.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  setupGetIt();
  setEndpoints();
  final appConfig = AppConfig.instance;
  final mockDio = MockDio();
  PiixApiDeprecated.setDio(mockDio);
  final protectedProvider = getIt<ProtectedProvider>();
  final protectedRepository = getIt<ProtectedRepository>();
  late RequestAvailableProtectedModel requestModel;
  final fakeAvailableProtected = protectedRepository.fakeAvailableProtected();
  const membershipId = 'piix_01_09_02';
  var path = '';
  group('user retrieves available protected', () {
    setUpAll(() {
      requestModel =
          const RequestAvailableProtectedModel(membershipId: membershipId);
      path =
          '${appConfig.backendEndpoint}/protected/slots/byMembership?membershipId=${requestModel.membershipId}';
    });
    setUp(() {
      protectedProvider.clearProvider();
    });

    test(
      'user retrieves available protected successfuly',
      () async {
        expect(protectedProvider.protectedState, ProtectedState.idle);
        when(mockDio.get(path)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: path,
            ),
            statusCode: HttpStatus.ok,
            data: fakeAvailableProtected,
          ),
        );
        await protectedProvider.getAvailableProtected(
          membershipId: membershipId,
          useFirebase: false,
        );
        expect(protectedProvider.protectedsInfo, isNotNull);
        expect(
            protectedProvider.protectedsInfo!.slots.protectedSlots, isNotEmpty);
        expect(protectedProvider.protectedsInfo!.protected, isNotEmpty);
        expect(protectedProvider.protectedsInfo!.slots.totalAvailableSlots, 2);
        expect(protectedProvider.protectedWithActiveMembership, isNotEmpty);
        expect(protectedProvider.protectedWithInactiveMembership, isNotEmpty);
        expect(protectedProvider.protectedState, ProtectedState.retrieved);
      },
    );

    test(
      'user retrieves no data when requesting for the available protected',
      () async {
        expect(protectedProvider.protectedState, ProtectedState.idle);
        when(mockDio.get(path)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: path,
            ),
            statusCode: HttpStatus.ok,
            data: null,
          ),
        );
        await protectedProvider.getAvailableProtected(
          membershipId: membershipId,
          useFirebase: false,
        );
        expect(protectedProvider.protectedsInfo, isNull);
        expect(protectedProvider.protectedWithActiveMembership, isEmpty);
        expect(protectedProvider.protectedWithInactiveMembership, isEmpty);
        expect(protectedProvider.protectedState, ProtectedState.error);
      },
    );
  });

  group('user can\'t retrieve available protected', () {
    setUpAll(() {
      requestModel =
          const RequestAvailableProtectedModel(membershipId: membershipId);
      path =
          '${appConfig.backendEndpoint}/protected/slots/byMembership?membershipId=${requestModel.membershipId}';
    });
    setUp(() {
      protectedProvider.clearProvider();
    });

    test(
      'the service responds with a 409',
      () async {
        expect(protectedProvider.protectedState, ProtectedState.idle);
        when(mockDio.get(path)).thenThrow(
          DioError(
            requestOptions: RequestOptions(path: path),
            response: Response(
              requestOptions: RequestOptions(
                path: path,
              ),
              statusCode: HttpStatus.conflict,
              data: <String, dynamic>{
                'errorName': 'Piix Error Resource has conflict',
                'errorMessage': 'There was an error with the '
                    'protected you wanted to retrieve',
                'errorMessages': '["Membership Id is missing from params"]',
              },
            ),
            type: DioErrorType.badResponse,
          ),
        );
        await protectedProvider.getAvailableProtected(
          membershipId: membershipId,
          useFirebase: false,
        );
        expect(protectedProvider.protectedsInfo, isNull);
        expect(protectedProvider.protectedWithActiveMembership, isEmpty);
        expect(protectedProvider.protectedWithInactiveMembership, isEmpty);
        expect(protectedProvider.protectedState, ProtectedState.error);
      },
    );

    test('the app throws a DioError connection timeout or other', () async {
      expect(protectedProvider.protectedState, ProtectedState.idle);
      when(mockDio.get(path)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout,
        ),
      );
      await protectedProvider.getAvailableProtected(
        membershipId: membershipId,
        useFirebase: false,
      );
      expect(protectedProvider.protectedsInfo, isNull);
      expect(protectedProvider.protectedWithActiveMembership, isEmpty);
      expect(protectedProvider.protectedWithInactiveMembership, isEmpty);
      expect(protectedProvider.protectedState, ProtectedState.error);
    });
  });
}
