// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/user_credential_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/domain/model/update_credential_model.dart';

//TODO: Add documentation
extension UserRepositoryUseCaseTest on UserRepositoryDeprecated {
  Future<dynamic> getUserByEmailRequestedTest(
      UserCredentialModel credentialModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      if (credentialModel.usernameCredential.contains('error')) {
        return UserActionStateDeprecated.error;
      } else if (credentialModel.usernameCredential.contains('found')) {
        return UserActionStateDeprecated.notFound;
      }
      return fakeJsonUser();
    });
  }

  Future<dynamic> getUserByPhoneRequestedTest(
      UserCredentialModel credentialModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      if (credentialModel.usernameCredential.contains('666')) {
        return UserActionStateDeprecated.error;
      } else if (credentialModel.usernameCredential.contains('000')) {
        return UserActionStateDeprecated.notFound;
      }
      return fakeJsonUser();
    });
  }

  Future<dynamic> getUserLevelsAndPlansRequestedTest() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return fakeJsonUserLevelsAndPlans();
    });
  }

  Future<UserActionStateDeprecated> updateUserEmailRequestedTest(
      UpdateEmailRequestModel requestModel) async {
    final newEmail = requestModel.newEmail;
    if (newEmail.contains('error')) {
      return UserActionStateDeprecated.errorUpdating;
    } else if (newEmail.contains('conflict')) {
      return UserActionStateDeprecated.alreadyExists;
    } else if (newEmail.contains('found')) {
      return UserActionStateDeprecated.notFound;
    }
    return UserActionStateDeprecated.updated;
  }

  Future<UserActionStateDeprecated> updateUserPhoneNumberRequestedTest(
      UpdatePhoneNumberRequestModel requestModel) async {
    final newPhoneNumber = requestModel.newPhoneNumber;
    if (newPhoneNumber.contains('666')) {
      return UserActionStateDeprecated.errorUpdating;
    } else if (newPhoneNumber.contains('000')) {
      return UserActionStateDeprecated.alreadyExists;
    } else if (newPhoneNumber.contains('111')) {
      return UserActionStateDeprecated.notFound;
    }
    return UserActionStateDeprecated.updated;
  }

  //TODO: Change fake json to new model
  Map<String, dynamic> fakeJsonUser() {
    // ignore: omit_local_variable_types
    final List<Map<String, dynamic>> memberships = [
      {
        "membershipId": "cbb3c0b45ccf0871d8bf101c1",
        "mainSerialNumber": 1,
        "additionalSerialNumber": 0,
        "isActive": false,
        "status": "inactive",
        "package": {
          "packageId": "CNOC-2022-01",
          "countryId": "cbb3c0b45ccf0871d8bf101c",
          "name": "Grupo Mexico para las familias empoderadas",
          "maxProtectedPerMain": 12,
        },
        "usersMembershipLevel": {
          "levelId": "level1",
          "folio": "level1",
          "name": "Blue1",
          "pseudonym": "Basico del Paquete Asignado.",
          "membershipLevelImage": "levels/level1/membershipLevelImage.png"
        },
        "usersMembershipPlans": [
          {
            "planId": "cbb3c0b45ccf0871d8bf101c",
            "folio": "Individual",
            "name": "Individual",
            "pseudonym": "Individual",
            "maxUsersInPlan": 1,
            "kinshipId": "kinship1",
            "registerDate": "2022-02-22T02:37:29.000Z",
            "kinship": {
              "kinshipId": "cbb3c0b45ccf0871d8bf101c",
              "folio": "spouse-000.00001",
              "name": "Conyuge",
              "registerDate": "2022-02-22T02:42:08.000Z"
            },
            "protectedAcquired": 1
          }
        ]
      },
      {
        "membershipId": "cbb3c0b45ccf0871d8bf101c2",
        "mainSerialNumber": 1,
        "additionalSerialNumber": 0,
        "isActive": true,
        "status": "active",
        "package": {
          "packageId": "21e1f38b93f9c2c10adc58b9c2",
          "countryId": "cbb3c0b45ccf0871d8bf101c",
          "name": "Grupo Mexico para las familias no encontradas",
          "maxProtectedPerMain": 12,
          "packagePosterURL": "packages/CNC2021/packagePoster.png"
        },
        "usersMembershipLevel": {
          "levelId": "level1",
          "folio": "level1",
          "name": "Blue1",
          "pseudonym": "Basico del Paquete Asignado.",
          "membershipLevelImage": "levels/level1/membershipLevelImage.png"
        },
        "usersMembershipPlans": [
          {
            "planId": "cbb3c0b45ccf0871d8bf101c",
            "folio": "marriage-0000.0001",
            "name": "Individual",
            "pseudonym": "Individual",
            "maxUsersInPlan": 1,
            "kinshipId": "kinship1",
            "registerDate": "2022-02-22T02:37:29.000Z",
            "kinship": {
              "kinshipId": "cbb3c0b45ccf0871d8bf101c",
              "folio": "spouse-000.00001",
              "name": "Conyuge",
              "registerDate": "2022-02-22T02:42:08.000Z"
            },
            "protectedAcquired": 1
          },
        ]
      },
      {
        "membershipId": "cbb3c0b45ccf0871d8bf101c2",
        "mainSerialNumber": 1,
        "additionalSerialNumber": 0,
        "isActive": true,
        "status": "active",
        "package": {
          "packageId": "cbb3c0b45ccf0871d8bf101c",
          "countryId": "cbb3c0b45ccf0871d8bf101c",
          "name": "Grupo Mexico para las familias erroneas",
          "maxProtectedPerMain": 12,
          "packagePosterURL": "packages/CNC2021/packagePoster.png"
        },
        "usersMembershipLevel": {
          "levelId": "level1",
          "folio": "level1",
          "name": "Blue1",
          "pseudonym": "Basico del Paquete Asignado.",
          "membershipLevelImage": "levels/level1/membershipLevelImage.png"
        },
        "usersMembershipPlans": [
          {
            "planId": "cbb3c0b45ccf0871d8bf101c",
            "folio": "marriage-0000.0001",
            "name": "Individual",
            "pseudonym": "Individual",
            "maxUsersInPlan": 1,
            "kinshipId": "kinship1",
            "registerDate": "2022-02-22T02:37:29.000Z",
            "kinship": {
              "kinshipId": "cbb3c0b45ccf0871d8bf101c",
              "folio": "spouse-000.00001",
              "name": "Conyuge",
              "registerDate": "2022-02-22T02:42:08.000Z"
            },
            "protectedAcquired": 1
          }
        ]
      }
    ];
    //TODO: Add another userId for future app tests
    return <String, dynamic>{
      "userId": "cbb3c0b45ccf0871d8bf101c",
      "email": "mich.bubbla@g.com",
      "internationalPhoneCode": "+52",
      "phoneNumber": "5555555555",
      "names": "Michelle Desire Maria Concepcion",
      "lastNames": "Kawalimpuki Bubbla Rodriguez",
      "genderId": "gender1",
      "countryId": "MEX",
      "stateId": "MEXCDMX",
      "zipCode": "01021",
      "birthdate": "2004-01-24T00:00:00.000Z",
      "needsToRefreshPage": false,
      "uniqueId": "BBMB890124",
      "genderName": "Femenino",
      "countryName": "Mexico",
      "stateName": "CDMX",
      "userAlreadyHasBasicMainInfoForm": false,
      "isMainUser": true,
      "memberships": memberships,
      'state': UserActionStateDeprecated.retrieved,
    };
  }

  Map<String, dynamic> fakeJsonUserLevelsAndPlans() => {
        'memberships': [
          {
            "membershipId": "cbb3c0b45ccf0871d8bf101c1",
            "mainSerialNumber": 0,
            "additionalSerialNumber": 0,
            "isActive": true,
            "status": "active",
            "package": {
              "packageId": "CNOC-2022-01",
              "countryId": "MEX",
              "name": "Desarrollo, salud y protección",
              "maxProtectedPerMain": 12
            },
            "usersMembershipLevel": {
              "levelId": "level2",
              "folio": "level2",
              "name": "Silver1",
              "pseudonym": "Plateado del Paquete Asignado.",
              "membershipLevelImage": "levels/level2/membershipLevelImage.png"
            },
            "usersMembershipPlans": [
              {
                "planId": "cbb3c0b45ccf0871d8bf101c",
                "folio": "marriage-0000.0001",
                "name": "Individual",
                "pseudonym": "Individual",
                "maxUsersInPlan": 1,
                "kinshipId": "kinship1",
                "registerDate": "2022-02-22T02:37:29.000Z",
                "kinship": {
                  "kinshipId": "cbb3c0b45ccf0871d8bf101c",
                  "folio": "spouse-000.00001",
                  "name": "Conyuge",
                  "registerDate": "2022-02-22T02:42:08.000Z"
                },
                "protectedAcquired": 1
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
                "protectedAcquired": 1
              }
            ]
          }
        ],
        'state': UserActionStateDeprecated.retrieved,
      };
}
