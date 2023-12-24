// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/protected_feature_deprecated/data/repository/protected_form_repository.dart';

extension ProtectedFormRepositoryTest on ProtectedFormRepository {
  Future<dynamic> getProtectedRegisterFormRequestedTest() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => fakeProtectedRegisterForm(),
    );
  }

  Map<String, dynamic> fakeProtectedRegisterForm() => {
        "mainUserInfoFormId": "basicProtectedForm",
        "name": "Formulario Básico para los Protegidos",
        "registerDate": "2022-12-29T02:00:18.000Z",
        "formFields": [
          {
            "formFieldId": "name",
            "name": "Nombre",
            "required": true,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 100,
            "isEditable": true
          },
          {
            "formFieldId": "middleName",
            "name": "Segundo Nombre",
            "required": false,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 100,
            "isEditable": true
          },
          {
            "formFieldId": "firstLastName",
            "name": "Apellido Paterno",
            "required": true,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 50,
            "isEditable": true
          },
          {
            "formFieldId": "secondLastName",
            "name": "Apellido Materno",
            "required": false,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 50,
            "isEditable": true
          },
          {
            "formFieldId": "email",
            "name": "Correo electrónico",
            "required": true,
            "dataTypeId": "string",
            "minLength": 6,
            "maxLength": 100,
            "isEditable": true
          },
          {
            "formFieldId": "phoneNumber",
            "name": "Teléfono",
            "required": true,
            "dataTypeId": "phone",
            "isEditable": true
          },
          {
            "formFieldId": "birthdate",
            "name": "Fecha de nacimiento",
            "required": true,
            "dataTypeId": "date",
            "isEditable": true
          },
          {
            "formFieldId": "planId",
            "name": "Plan",
            "required": true,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 100,
            "isEditable": true,
            "values": [
              {
                "valueId": "e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d",
                "folio": "plan-1",
                "name": "Individual",
                "registerDate": "2022-07-14T20:38:18.000Z"
              },
              {
                "valueId": "cdf8ef67d17c0b0c07f5eda9ff32acdaedadc73ccc77fec8eb",
                "folio": "PLN001",
                "name": "Titular de 0 a 17 años",
                "registerDate": "2023-01-03T21:29:40.000Z"
              },
              {
                "valueId": "193961dd198c192802fff752e3258c620841e2aa855c680dd0",
                "folio": "PLN002",
                "name": "Titular de 18 a 24 años",
                "registerDate": "2023-01-03T21:30:00.000Z"
              },
              {
                "valueId": "85d7cda18a85c11c410776cc78758c7ce55714d7ec3efb5a62",
                "folio": "PLN003",
                "name": "Titular de 25 a 30 años",
                "registerDate": "2023-01-03T21:30:14.000Z"
              },
              {
                "valueId": "f5d13717cb6d79f056494f2b6c93afcc638942b83fee0a549f",
                "folio": "PLN004",
                "name": "Titular de 31 a 40 años",
                "registerDate": "2023-01-03T21:30:33.000Z"
              },
              {
                "valueId": "cc8cb4faa79e56711a6102af16bdd3b76f38dbcbeef6eb3a00",
                "folio": "PLN005",
                "name": "Titular de 41 a 50 años",
                "registerDate": "2023-01-03T21:30:48.000Z"
              },
              {
                "valueId": "33afad8cbe553bd17cd6b19737eaf7f7e10708513f97960f9d",
                "folio": "PLN006",
                "name": "Titular de 51 a 60 años",
                "registerDate": "2023-01-03T21:31:04.000Z"
              },
              {
                "valueId": "34b398fa2fff3da6df9e847431e4fde1a14475e1c39bf156f0",
                "folio": "PLN007",
                "name": "Titular de 61 a 65 años",
                "registerDate": "2023-01-10T23:17:52.000Z"
              },
              {
                "valueId": "b440ada453d4c6f12c490597962dc4f1e332fd5fe6d980d829",
                "folio": "PLN008",
                "name": "Titular de 66 a 70 años",
                "registerDate": "2023-01-10T23:18:38.000Z"
              },
              {
                "valueId": "b7dbb7bd10c8a6a9d97498e6ea472d160bd744d1004e40c35f",
                "folio": "PLN009",
                "name": "Titular de 71 a 75 años",
                "registerDate": "2023-01-10T23:19:17.000Z"
              },
              {
                "valueId": "5e3bc0c087eebb5af9fc5c4f567f37d791efeab668c24a7f0a",
                "folio": "PLN010",
                "name": "Titular de 76 a 80 años",
                "registerDate": "2023-01-10T23:19:50.000Z"
              },
              {
                "valueId": "dc692ef9f763f69b57736b6584ce979c30fea45fc94eaff236",
                "folio": "PLN011",
                "name": "Titular de 81 a 85 años",
                "registerDate": "2023-01-10T23:20:20.000Z"
              },
              {
                "valueId": "bbc3a9439c251064ec3e668e803aa788966880c5d845c4b91b",
                "folio": "PLN012",
                "name": "Titular de 86 a 90 años",
                "registerDate": "2023-01-10T23:20:49.000Z"
              },
              {
                "valueId": "53de8f1b91d802eb2734a369441a58378a4efad14aa6cb9880",
                "folio": "PLN013",
                "name": "Titular de 91 a 95 años",
                "registerDate": "2023-01-10T23:21:15.000Z"
              },
              {
                "valueId": "08801725fd2b947c1fed8312aff44a5dbeab528be90c6645f0",
                "folio": "PLN014",
                "name": "Titular de 96 a 100 años",
                "registerDate": "2023-01-10T23:24:11.000Z"
              }
            ],
            "isArray": true,
            "isMultiple": false,
            "returnId": true
          },
          {
            "formFieldId": "genderId",
            "name": "Género",
            "required": true,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 100,
            "isEditable": true,
            "values": [
              {
                "valueId": "gender1",
                "name": "Masculino",
                "registerDate": "2022-02-19T01:39:12.000Z",
                "folio": "gender1"
              },
              {
                "valueId": "gender2",
                "name": "Femenino",
                "registerDate": "2022-02-19T01:39:12.000Z",
                "folio": "gender2"
              },
              {
                "valueId": "gender3",
                "name": "Otro",
                "registerDate": "2022-02-19T01:39:12.000Z",
                "folio": "gender3"
              }
            ],
            "isArray": true,
            "isMultiple": false,
            "returnId": true
          },
          {
            "formFieldId": "countryId",
            "name": "País",
            "required": true,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": false,
            "includesOtherOption": false,
            "minLength": 1,
            "maxLength": 20,
            "allRepetitionsAreRequired": false,
            "defaultValue": "México",
            "isEditable": true,
            "values": [
              {
                "valueId": "MEX",
                "folio": "MX",
                "name": "México",
                "currencyId": "MXN",
                "internationalPhoneCode": "+52",
                "registerDate": "2022-02-22T01:09:34.000Z",
                "updateDate": null,
                "deleteDate": null
              }
            ],
            "returnId": true
          },
          {
            "formFieldId": "stateId",
            "name": "Estado",
            "required": true,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": false,
            "includesOtherOption": false,
            "minLength": 1,
            "maxLength": 20,
            "allRepetitionsAreRequired": false,
            "isEditable": true,
            "values": [
              {
                "valueId": "MEXAGS",
                "folio": "MEXAGS",
                "name": "Aguascalientes",
                "registerDate": "2022-02-22T01:17:40.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXBCN",
                "folio": "MEXBCN",
                "name": "Baja California",
                "registerDate": "2022-02-22T01:17:40.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXBCS",
                "folio": "MEXBCS",
                "name": "Baja California Sur",
                "registerDate": "2022-02-22T01:17:40.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXCAM",
                "folio": "MEXCAM",
                "name": "Campeche",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXCDMX",
                "folio": "MEXCDMX",
                "name": "Ciudad de México",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXCHH",
                "folio": "MEXCHH",
                "name": "Chihuahua",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXCHP",
                "folio": "MEXCHP",
                "name": "Chiapas",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXCOA",
                "folio": "MEXCOA",
                "name": "Coahuila de Zaragoza",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXCOL",
                "folio": "MEXCOL",
                "name": "Colima",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXDUR",
                "folio": "MEXDUR",
                "name": "Durango",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXGRO",
                "folio": "MEXGRO",
                "name": "Guerrero",
                "registerDate": "2022-02-22T01:17:41.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXGUA",
                "folio": "MEXGUA",
                "name": "Guanajuato",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXHID",
                "folio": "MEXHID",
                "name": "Hidalgo",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXJAL",
                "folio": "MEXJAL",
                "name": "Jalisco",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXMEX",
                "folio": "MEXMEX",
                "name": "Mexico",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXMIC",
                "folio": "MEXMIC",
                "name": "Michoacán de Ocampo",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXMOR",
                "folio": "MEXMOR",
                "name": "Morelos",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXNAY",
                "folio": "MEXNAY",
                "name": "Nayarit",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXNLE",
                "folio": "MEXNLE",
                "name": "Nuevo León",
                "registerDate": "2022-02-22T01:17:42.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXOAX",
                "folio": "MEXOAX",
                "name": "Oaxaca",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXPUE",
                "folio": "MEXPUE",
                "name": "Puebla",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXQUE",
                "folio": "MEXQUE",
                "name": "Querétaro",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXROO",
                "folio": "MEXROO",
                "name": "Quintana Roo",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXSIN",
                "folio": "MEXSIN",
                "name": "Sinaloa",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXSLP",
                "folio": "MEXSLP",
                "name": "San Luis Potosí",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXSON",
                "folio": "MEXSON",
                "name": "Sonora",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXTAB",
                "folio": "MEXTAB",
                "name": "Tabasco",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXTAM",
                "folio": "MEXTAM",
                "name": "Tamaulipas",
                "registerDate": "2022-02-22T01:17:43.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXTLA",
                "folio": "MEXTLA",
                "name": "Tlaxcala",
                "registerDate": "2022-02-22T01:17:44.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXVER",
                "folio": "MEXVER",
                "name": "Veracruz",
                "registerDate": "2022-02-22T01:17:44.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXYUC",
                "folio": "MEXYUC",
                "name": "Yucatan",
                "registerDate": "2022-02-22T01:17:44.000Z",
                "typeId": "MEX"
              },
              {
                "valueId": "MEXZAC",
                "folio": "MEXZAC",
                "name": "Zacatecas",
                "registerDate": "2022-02-22T01:17:44.000Z",
                "typeId": "MEX"
              }
            ],
            "returnId": true
          },
          {
            "formFieldId": "zipCode",
            "name": "Código Postal",
            "required": true,
            "dataTypeId": "string",
            "minLength": 4,
            "maxLength": 6,
            "isEditable": true
          },
          {
            "formFieldId": "packageId",
            "name": "Paquete",
            "required": true,
            "dataTypeId": "string",
            "minLength": 1,
            "maxLength": 100,
            "isEditable": true
          },
          {
            "formFieldId": "user_validation_documents",
            "name": "Documento de identificación",
            "required": true,
            "dataTypeId": "camera_documents_picture",
            "isArray": false,
            "isMultiple": false,
            "includesOtherOption": false,
            "minPhotos": 2,
            "maxPhotos": 5,
            "allRepetitionsAreRequired": false,
            "isEditable": true
          },
          {
            "formFieldId": "protectedUniqueId",
            "name": "CURP",
            "required": true,
            "dataTypeId": "string",
            "isArray": false,
            "isMultiple": false,
            "includesOtherOption": false,
            "allRepetitionsAreRequired": false,
            "isEditable": true
          }
        ],
        "state": ProtectedFormState.retrieved,
      };
}
