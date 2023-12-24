// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_info_model.dart';

///Handles fake api service implementation calls for membership information
extension MembershipInfoRepositoryUseCaseTest
    on MembershipInfoRepositoryDeprecated {
  Future<dynamic> getMembershipInfoRequestedTest(
      RequestMembershipInfoModel requestModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return fakeMembershipInfoJson();
    });
  }

  Future<dynamic> getAdditionalMembershipInfoRequestedTest(
      RequestMembershipInfoModel requestModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return fakeAdditionalMembershipInfoJson();
    });
  }

  //TODO: Change fake json to new model
  Map<String, dynamic> fakeMembershipInfoJson() => {
        "folio": "CNOC-2022-01",
        "clientId": "CNOC-2022-01",
        "name": "Desarrollo, salud y protección",
        "claimPhoneNumber": "+525520921678",
        "claimChatNumber": "+525520921678",
        "fromDate": "2022-02-02T00:00:00.000Z",
        "toDate": "2024-01-02T00:00:00.000Z",
        "maxProtectedPerMain": 12,
        "maxAgeCompliance": 0,
        "packageIsActive": true,
        "activeEcommerce": false,
        "registerDate": "2022-02-23T23:17:40.000Z",
        "clientName": "Consejo Nacional de Organizaciones Campesinas",
        "benefitsPerSupplier": [
          {
            "benefitPerSupplierId": "CNOC-2022-01-AOPS211000-000",
            "wordingZero":
                "<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: plomería, electricista, cerrajería y vidriería para su domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n",
            "requiresAgeCompliance": false,
            "benefitImage":
                "benefits_per_supplier/CNOC-2022-01-AOPS211000-000/benefitImage.png",
            "pdfWording":
                "benefits_per_supplier/CNOC-2022-01-AOPS211000-000/pdfWording.pdf",
            "benefit": {
              "benefitId": "AOPS211000-000",
              "name": "Asistencia en el Hogar",
              "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
            },
            "benefitType": {"benefitTypeId": "A", "name": "Asistencias"},
            "hasBenefitForm": false,
            "needsBenefitFormSignature": false,
            "userHasAlreadySignedTheBenefitForm": false,
            "hasCobenefits": true
          },
          {
            "benefitPerSupplierId": "CNOC-2022-01-SOPS311000-000",
            "wordingZero":
                "<p>Si el socio o sus protegidos (según el plan elegido) durante la vigencia de la póliza a consecuencia de un accidente cubierto y a causa de ello: el asegurado queda incapacitado permanentemente, genera gastos médicos o fallece; la compañía pagará al titular o beneficiario la cantidad de dinero que convino en su póliza.</p>\n<p>En todos los casos aplican exclusiones y condiciones estipuladas en la póliza.</p>\n",
            "requiresAgeCompliance": false,
            "benefitImage":
                "benefits_per_supplier/CNOC-2022-01-SOPS311000-000/benefitImage.png",
            "pdfWording":
                "benefits_per_supplier/CNOC-2022-01-SOPS311000-000/pdfWording.png",
            "benefit": {
              "benefitId": "SOPS311000-000",
              "name": "Accidentes Personales",
              "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
            },
            "benefitType": {"benefitTypeId": "S", "name": "Seguros"},
            "hasBenefitForm": false,
            "needsBenefitFormSignature": false,
            "userHasAlreadySignedTheBenefitForm": false,
            "hasCobenefits": true
          },
          {
            "benefitPerSupplierId": "CNOC-2022-01-XOPS411000-000",
            "wordingZero":
                "<p>Cubre los servicios de víales para los vehículos del socio y sus protegidos (según el plan elegido) en caso de requerir servicios de: grúa por avería, envío de gasolina y paso de corriente.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n",
            "requiresAgeCompliance": false,
            "benefitImage":
                "benefits_per_supplier/CNOC-2022-01-XOPS411000-000/benefitImage.png",
            "pdfWording":
                "benefits_per_supplier/CNOC-2022-01-XOPS411000-000/pdfWording.pdf",
            "benefit": {
              "benefitId": "XOPS411000-000",
              "name": "Servicios Viales",
              "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
            },
            "benefitType": {"benefitTypeId": "X", "name": "Servicios"},
            "hasBenefitForm": false,
            "needsBenefitFormSignature": false,
            "userHasAlreadySignedTheBenefitForm": false,
            "hasCobenefits": true
          },
          {
            "benefitPerSupplierId": "CNOC-2022-01-ZOPS511000-000",
            "benefitFormId": "CNOC-2022-Indemnizatorio",
            "wordingZero":
                "<p>Recompensa. Este beneficio otorga al socio y sus protegidos (según el plan seleccionado) acceso a descuentos y servicios a través de una membresía digital MAS DESCUENTOS, los cuales consisten en:</p>\n<ol>\n<li>Alimentos y bebidas</li>\n<li>Salud</li>\n<li>Belleza</li>\n<li>Educación</li>\n<li>Entretenimiento</li>\n<li>Moda y hogar</li>\n<li>Servicios</li>\n<li>Tecnología</li>\n<li>Turismo.</li>\n</ol>\n",
            "requiresAgeCompliance": false,
            "benefitImage":
                "benefits_per_supplier/CNOC-2022-01-ZOPS511000-000/benefitImage.png",
            "pdfWording":
                "benefits_per_supplier/CNOC-2022-01-ZOPS511000-000/pdfWording.pdf",
            "benefit": {
              "benefitId": "ZOPS511000-000",
              "name": "MAS Descuentos Comerciales",
              "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
            },
            "benefitType": {"benefitTypeId": "Z", "name": "Recompensas"},
            "hasBenefitForm": true,
            "needsBenefitFormSignature": true,
            "userHasAlreadySignedTheBenefitForm": false,
            "hasCobenefits": false
          }
        ],
        "kinshipId": "kinship1",
        "kinshipName": "Individual",
        'state': MembershipInfoStateDeprecated.retrieved,
      };

  Map<String, dynamic> fakeAdditionalMembershipInfoJson() => {
        "intermediaries": [
          {
            "intermediaryId": "B1000-99998",
            "folio": "B1000-99998",
            "personTypeId": "C",
            "name": "User",
            "firstLastName": "Intermediary",
            "internationalLada": "",
            "phoneNumber": "",
            "taxAddressId":
                "3a7e4b77c01640370e2db782ef7d70f4efb5b765e055fa1d4e9892f80d8e0339",
            "officeAddressId":
                "3a7e4b77c01640370e2db782ef7d70f4efb5b765e055fa1d4e9892f80d8e0339",
            "taxId": "",
            "needsToRefreshPage": false,
            "taxAddress": {
              "street": "",
              "externalNumber": "",
              "countryId": "MEX",
              "stateId": "MEXCDMX",
              "zipCode": "55555"
            },
            "officeAddress": {
              "street": "",
              "externalNumber": "",
              "countryId": "MEX",
              "stateId": "MEXCDMX",
              "zipCode": "55555"
            },
            "intermediaryTypes": [
              {"intermediaryTypeId": "E", "name": "Matriculador"}
            ]
          },
          {
            "intermediaryId": "B1000-99999",
            "folio": "B1000-99999",
            "personTypeId": "C",
            "shortName": "Gus",
            "name": "Gustavo",
            "internationalLada": "+52",
            "phoneNumber": "",
            "taxAddressId":
                "db5ad4d0183749da60736ec993fb58bb8f269167328f79b477abbeddd5821e5c",
            "officeAddressId":
                "db5ad4d0183749da60736ec993fb58bb8f269167328f79b477abbeddd5821e5c",
            "taxId": "GUS90875",
            "needsToRefreshPage": false,
            "taxAddress": {
              "street": "Pedregal",
              "externalNumber": "43",
              "countryId": "MEX",
              "stateId": "MEXCDMX",
              "city": "Alvaro Obregon",
              "zipCode": "01020"
            },
            "officeAddress": {
              "street": "Pedregal",
              "externalNumber": "43",
              "countryId": "MEX",
              "stateId": "MEXCDMX",
              "city": "Alvaro Obregon",
              "zipCode": "01020"
            },
            "intermediaryTypes": [
              {"intermediaryTypeId": "O", "name": "Oficina"},
              {"intermediaryTypeId": "E", "name": "Matriculador"}
            ]
          }
        ],
        "client": <String, dynamic>{
          "clientId": "CNOC-2022-01",
          "folio": "CNOC-2022-01",
          "personTypeId": "C",
          "shortName": "CNOC",
          "name": "Consejo Nacional de Organizaciones Campesinas",
          "internationalLada": "+52",
          "phoneNumber": "1234567890",
          "taxId": "XAXX010101000",
          "registerDate": "2022-02-23T00:41:28.000Z",
          "taxAddress": {
            "street": "Victoria",
            "externalNumber": "200",
            "subThoroughFare": "Guadalupe",
            "thoroughFare": "Ciudad de México",
            "countryId": "MEX",
            "stateId": "MEXCDMX",
            "city": "Ciudad de México",
            "zipCode": "01000"
          },
          "officeAddress": {
            "street": "Victoria",
            "externalNumber": "200",
            "subThoroughFare": "Guadalupe",
            "thoroughFare": "Ciudad de México",
            "countryId": "MEX",
            "stateId": "MEXCDMX",
            "city": "Ciudad de México",
            "zipCode": "01000"
          },
        },
        'state': MembershipInfoStateDeprecated.retrieved,
      };
}
