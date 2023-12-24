// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';


@Deprecated('Will be removed in 4.0')
extension AuthServiceRepositoryTestDeprecated on AuthServiceRepository {
  Future<CredentialState> sendCredentialRequestedTest(
      AuthUserModel authModel) async {
    return Future.delayed(const Duration(seconds: 1), () {
      final credential = authModel.phoneNumber ?? '';
      if (credential.contains('conflict') || credential.contains('000')) {
        return CredentialState.conflict;
      } else if (credential.contains('error') || credential.contains('666')) {
        return CredentialState.error;
      }
      return CredentialState.sent;
    });
  }

  Future<dynamic> sendVerificationCodeRequestedTest(
      AuthUserModel authModel) async {
    return Future.delayed(const Duration(seconds: 1), () {
      final verificationCode = authModel.verificationCode ?? '666';
      if (verificationCode.contains('000')) {
        return VerificationCodeState.conflict;
      } else if (verificationCode.contains('666')) {
        return VerificationCodeState.error;
      } else if (verificationCode.contains('123')) {
        return fakeInactiveUserAppModel();
      }
      return fakeActiveUserAppModel();
    });
  }

  Future<dynamic> sendHashableAuthValuesRequestedTest(
      AuthUserModel authModel) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        final data = fakeInactiveUserAppModel();
        data['state'] = data['authState'];
        return data;
      },
    );
  }

  Map<String, dynamic> fakeInactiveUserAppModel() => {
        "customAccessToken":
            "0e13314ed9a5018f369072c44ce241ed0975cd8057367369aef5b6e9f405807a",
        "userId":
            "0e13314ed9a5018f369072c44ce241ed0975cd8057367369aef5b6e9f405807a",
        //Personal Information
        "email": "test@test.com",
        "internationalPhoneCode": "",
        "phoneNumber": "",
        "state": VerificationCodeState.verified,
        "authState": AuthState.authorized,
        "verifiedPhone": false,
        "verifiedEmail": true,
        "processingStatus": "IDLE",
      };

  Map<String, dynamic> fakeActiveUserAppModel() => {
        "customAccessToken":
            "0e13314ed9a5018f369072c44ce241ed0975cd8057367369aef5b6e9f405807a",
        "userId":
            "0e13314ed9a5018f369072c44ce241ed0975cd8057367369aef5b6e9f405807a",
        //Personal Information
        "email": "test@test.com",
        "internationalPhoneCode": "+52",
        "phoneNumber": "5478547854",
        "name": "Michelle",
        "middleName": "Michelle",
        "firstLastName": "Bubbla",
        "secondLastName": "Bubbla",
        "countryId": "MEX",
        "stateId": "MEXCDMX",
        "zipCode": "01030",
        "uniqueId": "0940219629000000",
        "countryName": "México",
        "stateName": "Ciudad de México",
        "userAlreadyHasBasicMainInfoForm": true,
        "status": "revised",
        "memberships": fakeMemberships(),
        "state": VerificationCodeState.verified,
        "authState": AuthState.authorized,
        "processingStatus": "REVISION",
      };

  List<dynamic> fakeMemberships() => [
        {
          "membershipId": "PIIXINT2021-00-00",
          "mainSerialNumber": 0,
          "additionalSerialNumber": 0,
          "isActive": true,
          "status": "active",
          "registerDate": "2022-02-25T00:01:22.000Z",
          "isMainUser": true,
          "package": {
            "packageId": "PIIXINT2021",
            "countryId": "MEX",
            "name": "PIIX INTERNAL",
            "maxProtectedPerMain": 12
          },
          "usersMembershipLevel": {
            "levelId": "level1",
            "folio": "level1",
            "name": "Blue",
            "pseudonym": "Basico del Paquete Asignado.",
            "membershipLevelImage": "levels/level1/membershipLevelImage.png"
          },
          "usersMembershipPlans": [
            {
              "planId": "e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d",
              "folio": "plan-1",
              "name": "Individual",
              "pseudonym": "Individual",
              "maxUsersInPlan": 1,
              "kinshipId": "kinship1",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship1",
                "folio": "kinship1",
                "name": "Individual",
                "registerDate": "2022-02-22T02:42:08.000Z"
              },
              "protectedAcquired": 1
            }
          ]
        },
        {
          "membershipId": "CNOC-2022-01-25-00",
          "mainSerialNumber": 25,
          "additionalSerialNumber": 0,
          "isActive": true,
          "status": "active",
          "registerDate": "2022-08-11T00:20:46.000Z",
          "isMainUser": true,
          "package": {
            "packageId": "CNOC-2022-01",
            "countryId": "MEX",
            "name": "Desarrollo, salud y protección",
            "maxProtectedPerMain": 5
          },
          "usersMembershipLevel": {
            "levelId": "level1",
            "folio": "level1",
            "name": "Blue",
            "pseudonym": "Basico del Paquete Asignado.",
            "membershipLevelImage": "levels/level1/membershipLevelImage.png"
          },
          "usersMembershipPlans": [
            {
              "planId": "e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d",
              "folio": "plan-1",
              "name": "Individual",
              "pseudonym": "Individual",
              "maxUsersInPlan": 1,
              "kinshipId": "kinship1",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship1",
                "folio": "kinship1",
                "name": "Individual",
                "registerDate": "2022-02-22T02:42:08.000Z"
              },
              "protectedAcquired": 1
            }
          ]
        },
        {
          "membershipId": "CNC2021-01-00",
          "mainSerialNumber": 1,
          "additionalSerialNumber": 0,
          "isActive": true,
          "status": "active",
          "registerDate": "2022-02-25T00:01:24.000Z",
          "isMainUser": true,
          "package": {
            "packageId": "CNC2021",
            "countryId": "MEX",
            "name": "Protección y Bienestar",
            "maxProtectedPerMain": 12,
            "packagePosterURL": "packages/CNC2021/packagePoster.png"
          },
          "usersMembershipLevel": {
            "levelId": "level2",
            "folio": "level2",
            "name": "Silver",
            "pseudonym": "Nivel 2 del Paquete Asignado.",
            "membershipLevelImage": "levels/level2/membershipLevelImage.png"
          },
          "usersMembershipPlans": [
            {
              "planId": "e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d",
              "folio": "plan-1",
              "name": "Individual",
              "pseudonym": "Individual",
              "maxUsersInPlan": 1,
              "kinshipId": "kinship1",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship1",
                "folio": "kinship1",
                "name": "Individual",
                "registerDate": "2022-02-22T02:42:08.000Z"
              },
              "protectedAcquired": 2
            },
            {
              "planId": "f45d5921fa5d6d2af44fcf9c91c76fa8a3d7ac9d686881a1e1",
              "folio": "plan-8",
              "name": "Conyuge",
              "pseudonym": "Conyuge",
              "maxUsersInPlan": 1,
              "kinshipId": "kinship2",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship2",
                "folio": "kinship2",
                "name": "Conyuge",
                "registerDate": "2022-02-22T02:42:08.000Z"
              },
              "protectedAcquired": 2
            }
          ]
        }
      ];
}
