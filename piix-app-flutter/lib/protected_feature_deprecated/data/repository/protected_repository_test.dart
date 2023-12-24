// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_repository.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/request_available_protected_model.dart';

extension ProtectedRepositoryTest on ProtectedRepository {
  Future<dynamic> getAvailableProtectedRequestedTest({
    required RequestAvailableProtectedModel requestModel,
  }) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => fakeAvailableProtected(),
    );
  }

  Map<String, dynamic> fakeAvailableProtected() => {
        "slots": {
          "protectedSlots": [
            {
              "planId": "669608d7e8979c36109db8b4dfea828d959d6cc299f4d639f3",
              "folio": "plan-3",
              "name": "Hijo",
              "pseudonym": "Hijo",
              "maxUsersInPlan": 4,
              "kinshipId": "kinship12",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship12",
                "folio": "kinship12",
                "name": "Hijo",
                "registerDate": "2022-02-22T02:42:08.000Z"
              },
              "protectedAcquired": 4,
              "kinshipsWithMembership": [
                {"membershipId": "OPS2-02-04", "kinshipId": "kinship12"},
                {"membershipId": "OPS2-02-03", "kinshipId": "kinship12"},
                {"membershipId": "OPS2-02-02", "kinshipId": "kinship12"}
              ],
              "usedSlots": 3,
              "availableSlots": 1
            },
            {
              "planId": "9c92239a0be7657a70c3adc08400f20407b8ab6f50b0b61672",
              "folio": "plan-20",
              "name": "Abuelo",
              "pseudonym": "Abuelo",
              "maxUsersInPlan": 2,
              "kinshipId": "kinship52",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship52",
                "folio": "kinship52",
                "name": "Abuelo",
                "registerDate": "2022-02-22T02:42:10.000Z"
              },
              "protectedAcquired": 2,
              "kinshipsWithMembership": [
                {"membershipId": "OPS2-02-07", "kinshipId": "kinship52"},
                {"membershipId": "OPS2-02-05", "kinshipId": "kinship52"}
              ],
              "usedSlots": 2,
              "availableSlots": 0
            },
            {
              "planId": "aec780bfe53753c70a6a604f1203e511debe2c33a30c571dd4",
              "folio": "plan-19",
              "name": "Abuela",
              "pseudonym": "Abuela",
              "maxUsersInPlan": 2,
              "kinshipId": "kinship51",
              "registerDate": "2022-07-14T15:38:18.000Z",
              "kinship": {
                "kinshipId": "kinship51",
                "folio": "kinship51",
                "name": "Abuela",
                "registerDate": "2022-02-22T02:42:10.000Z"
              },
              "protectedAcquired": 2,
              "kinshipsWithMembership": [
                {"membershipId": "OPS2-02-06", "kinshipId": "kinship51"}
              ],
              "usedSlots": 1,
              "availableSlots": 1
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
              "protectedAcquired": 1,
              "kinshipsWithMembership": [
                {"membershipId": "OPS2-02-01", "kinshipId": "kinship2"}
              ],
              "usedSlots": 1,
              "availableSlots": 0
            }
          ],
          "totalAvailableSlots": 2,
          "totalUsedSlots": 7
        },
        "protected": [
          {
            "userId":
                "03645ed88c5d969188ea77ff8f190464c6ff4f17505afd5db5d5cc7427e720db",
            "email": "ramiro.perez@yopmail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "6565656565",
            "name": "Ramiro",
            "firstLastName": "Perez",
            "secondLastName": "Perez",
            "genderId": "gender1",
            "street": "aaaa",
            "countryId": "MEX",
            "stateId": "MEXCOL",
            "zipCode": "45645",
            "birthdate": "2004-05-28T18:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "06e283097d7044ca9f3ed95a2413f85b",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Colima",
            "userAlreadyHasBasicMainInfoForm": true,
            "membership": {
              "membershipId": "OPS2-02-04",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 4,
              "isActive": false,
              "status": "active",
              "registerDate": "2022-02-24T23:51:56.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "669608d7e8979c36109db8b4dfea828d959d6cc299f4d639f3",
                  "folio": "plan-3",
                  "name": "Hijo",
                  "pseudonym": "Hijo",
                  "maxUsersInPlan": 4,
                  "kinshipId": "kinship12",
                  "registerDate": "2022-07-14T15:38:18.000Z",
                  "kinship": {
                    "kinshipId": "kinship12",
                    "folio": "kinship12",
                    "name": "Hijo",
                    "registerDate": "2022-02-22T02:42:08.000Z"
                  },
                  "protectedAcquired": 1
                }
              ]
            }
          },
          {
            "userId":
                "82206bc06c9eb1d4d00077c8a6e9027cec0468d22d7f959da31e34c434ca1b8e",
            "email": "petra.perez@yopmail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "4454545454",
            "name": "Petra",
            "firstLastName": "Perez",
            "secondLastName": "Perez",
            "genderId": "gender1",
            "governmentNumber": "KOLU965454HHGPMM98",
            "street": "Abedúl",
            "externalNumber": "85",
            "countryId": "MEX",
            "stateId": "MEXCDMX",
            "city": "Ixtapa",
            "zipCode": "98521",
            "birthdate": "1997-02-14T00:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "1cbd9d57f8c449e68c9ad9d5e09e4ba5",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Ciudad de México",
            "userAlreadyHasBasicMainInfoForm": false,
            "membership": {
              "membershipId": "OPS2-02-03",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 3,
              "isActive": true,
              "status": "active",
              "registerDate": "2022-02-24T23:52:13.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "669608d7e8979c36109db8b4dfea828d959d6cc299f4d639f3",
                  "folio": "plan-3",
                  "name": "Hijo",
                  "pseudonym": "Hijo",
                  "maxUsersInPlan": 4,
                  "kinshipId": "kinship12",
                  "registerDate": "2022-07-14T15:38:18.000Z",
                  "kinship": {
                    "kinshipId": "kinship12",
                    "folio": "kinship12",
                    "name": "Hijo",
                    "registerDate": "2022-02-22T02:42:08.000Z"
                  },
                  "protectedAcquired": 1
                }
              ]
            }
          },
          {
            "userId":
                "eab3a2cef7a5e06c6160ad7886193ae487e1d637f87fb859f98875932ef328bf",
            "email": "Fermín.perez@yomail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "5555555555",
            "name": "Fermin",
            "firstLastName": "Perez",
            "genderId": "gender1",
            "governmentNumber": "POIU949485JJKPMM87",
            "street": "Abeto",
            "externalNumber": "1",
            "countryId": "MEX",
            "stateId": "MEXCOL",
            "zipCode": "12312",
            "birthdate": "2004-05-26T00:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "da8f94bcfced485fbc550ed4b9418354",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Colima",
            "userAlreadyHasBasicMainInfoForm": false,
            "membership": {
              "membershipId": "OPS2-02-02",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 2,
              "isActive": false,
              "status": "active",
              "registerDate": "2022-02-24T23:52:30.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "669608d7e8979c36109db8b4dfea828d959d6cc299f4d639f3",
                  "folio": "plan-3",
                  "name": "Hijo",
                  "pseudonym": "Hijo",
                  "maxUsersInPlan": 4,
                  "kinshipId": "kinship12",
                  "registerDate": "2022-07-14T15:38:18.000Z",
                  "kinship": {
                    "kinshipId": "kinship12",
                    "folio": "kinship12",
                    "name": "Hijo",
                    "registerDate": "2022-02-22T02:42:08.000Z"
                  },
                  "protectedAcquired": 1
                }
              ]
            }
          },
          {
            "userId":
                "4d6c88af0dbf3b70e05ac28eca57e8559fab3348f3994c47e725902648eb31aa",
            "email": "enriqueta.castillo@yopmail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "1111111110",
            "name": "Enriqueta",
            "firstLastName": "Castillo",
            "secondLastName": "Peña",
            "genderId": "gender1",
            "street": "fdsafdsa",
            "externalNumber": "fsdfdsa",
            "countryId": "MEX",
            "stateId": "MEXCDMX",
            "city": "fdasfdsa",
            "zipCode": "23233",
            "birthdate": "1991-02-01T00:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "770c007939814f239093ff3f81a9c12b",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Ciudad de México",
            "userAlreadyHasBasicMainInfoForm": false,
            "membership": {
              "membershipId": "OPS2-02-01",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 1,
              "isActive": true,
              "status": "active",
              "registerDate": "2022-02-24T23:52:04.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "f45d5921fa5d6d2af44fcf9c91c76fa8a3d7ac9d686881a1e1",
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
          },
          {
            "userId":
                "d5bd30d5e38d627df0e92fd58efa147bc853b036483cef3a716651a2909434bd",
            "email": "rosario@yopmail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "5568954256",
            "name": "Rosario",
            "firstLastName": "Perez",
            "secondLastName": "Duran",
            "genderId": "gender1",
            "countryId": "MEX",
            "stateId": "MEXCDMX",
            "zipCode": "555555",
            "birthdate": "1943-02-11T00:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "1cdc2800a3df4323a9ee8dbcf5e8f943",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Ciudad de México",
            "userAlreadyHasBasicMainInfoForm": false,
            "membership": {
              "membershipId": "OPS2-02-06",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 6,
              "isActive": true,
              "status": "active",
              "registerDate": "2022-02-24T23:52:28.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "aec780bfe53753c70a6a604f1203e511debe2c33a30c571dd4",
                  "folio": "plan-19",
                  "name": "Abuela",
                  "pseudonym": "Abuela",
                  "maxUsersInPlan": 2,
                  "kinshipId": "kinship51",
                  "registerDate": "2022-07-14T15:38:18.000Z",
                  "kinship": {
                    "kinshipId": "kinship51",
                    "folio": "kinship51",
                    "name": "Abuela",
                    "registerDate": "2022-02-22T02:42:10.000Z"
                  },
                  "protectedAcquired": 1
                }
              ]
            }
          },
          {
            "userId":
                "21e1f38b93f9c2c10adc58b9c2665cf958980806c6e419137822339b5c35cbd5",
            "email": "dario@yopmail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "5589456878",
            "name": "Dario",
            "firstLastName": "Perez",
            "secondLastName": "Duran",
            "genderId": "gender1",
            "governmentNumber": "KOIU987665JJGYII94",
            "countryId": "MEX",
            "stateId": "MEXDUR",
            "zipCode": "123123",
            "birthdate": "2004-05-26T00:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "638e2bdb34f7491ea764bbf0f1f9e6b1",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Durango",
            "userAlreadyHasBasicMainInfoForm": true,
            "membership": {
              "membershipId": "OPS2-02-07",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 7,
              "isActive": true,
              "status": "active",
              "registerDate": "2022-02-24T23:51:59.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "9c92239a0be7657a70c3adc08400f20407b8ab6f50b0b61672",
                  "folio": "plan-20",
                  "name": "Abuelo",
                  "pseudonym": "Abuelo",
                  "maxUsersInPlan": 2,
                  "kinshipId": "kinship52",
                  "registerDate": "2022-07-14T15:38:18.000Z",
                  "kinship": {
                    "kinshipId": "kinship52",
                    "folio": "kinship52",
                    "name": "Abuelo",
                    "registerDate": "2022-02-22T02:42:10.000Z"
                  },
                  "protectedAcquired": 1
                }
              ]
            }
          },
          {
            "userId":
                "1989402269f24a9931b15d41126aee78b720568d54aad0b4fc434f27451a9d3e",
            "email": "martin.juarez@yopmail.com",
            "internationalPhoneCode": "+52",
            "phoneNumber": "6666666666",
            "name": "Martín",
            "firstLastName": "Juarez",
            "secondLastName": "Perez",
            "genderId": "gender1",
            "countryId": "MEX",
            "stateId": "MEXCDMX",
            "zipCode": "555555",
            "birthdate": "1970-02-28T00:00:00.000Z",
            "contactName": "Wesley",
            "contactLastName": "Ibanez",
            "needsToRefreshPage": false,
            "uniqueId": "3c5c0e69c03248cdbef7511f0102c87e",
            "processingStatus": "APPROVED",
            "genderName": "Masculino",
            "countryName": "México",
            "stateName": "Ciudad de México",
            "userAlreadyHasBasicMainInfoForm": false,
            "membership": {
              "membershipId": "OPS2-02-05",
              "mainSerialNumber": 2,
              "additionalSerialNumber": 5,
              "isActive": false,
              "status": "active",
              "registerDate": "2022-02-24T23:51:59.000Z",
              "isMainUser": false,
              "package": {
                "packageId": "OPS2",
                "countryId": "MEX",
                "name": "OPS 2",
                "maxProtectedPerMain": 12,
                "packagePosterURL": "packages/OPS2/packagePoster.png"
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
                  "planId":
                      "9c92239a0be7657a70c3adc08400f20407b8ab6f50b0b61672",
                  "folio": "plan-20",
                  "name": "Abuelo",
                  "pseudonym": "Abuelo",
                  "maxUsersInPlan": 2,
                  "kinshipId": "kinship52",
                  "registerDate": "2022-07-14T15:38:18.000Z",
                  "kinship": {
                    "kinshipId": "kinship52",
                    "folio": "kinship52",
                    "name": "Abuelo",
                    "registerDate": "2022-02-22T02:42:10.000Z"
                  },
                  "protectedAcquired": 1
                }
              ]
            }
          }
        ],
        "canAddProtected": true,
        "state": ProtectedState.retrieved,
      };
}
