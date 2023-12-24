import 'package:piix_mobile/store_feature/data/repository/additional_benefits_per_supplier/additional_benefits_per_supplier_repository_deprecated.dart';

///Is a use case test extension of [AdditionalBenefitsPerSupplierRepositoryDeprecated]
///Contains all api mock calls
///
extension AdditionalBenefitsPerSupplierUseCaseTest
    on AdditionalBenefitsPerSupplierRepositoryDeprecated {
  ///Gets additional benefits per supplier by membership id mock
  ///
  Future<dynamic> getAdditionalBenefitsPerSupplierByMembershipRequestedTest(
      {required AdditionalBenefitsPerSupplierResponseTypesDeprecated
          type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated.empty:
          return [];
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated.success:
          return fakeAdditionalBenefitsJson;
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated.error:
          return AdditionalBenefitsPerSupplierStateDeprecated.error;
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated
              .unexpectedError:
          return AdditionalBenefitsPerSupplierStateDeprecated.unexpectedError;
      }
    });
  }

  ///Gets additional benefits per supplier whit details and prices by additional
  /// benefit per supplier id and membership id mock
  ///
  Future<dynamic> getAdditionalBenefitPerSupplierDetailsAndPriceRequestedTest(
      {required AdditionalBenefitsPerSupplierResponseTypesDeprecated
          type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated.success:
          return fakeAdditionalBenefitByIdJson;
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated.error:
          return AdditionalBenefitsPerSupplierStateDeprecated.error;
        case AdditionalBenefitsPerSupplierResponseTypesDeprecated
              .unexpectedError:
        default:
          return AdditionalBenefitsPerSupplierStateDeprecated.unexpectedError;
      }
    });
  }

  List<Map<String, dynamic>> get fakeAdditionalBenefitsJson => [
        {
          'additionalBenefitPerSupplierId': 'CNC2021-AOPS061100-000',
          'folio': 'CNC2021-AOPS061100-000',
          'wordingZero': '<p>TEST WORDING 0</p>\n',
          'wordingOne': '<p>TEST WORDING 1</p>\n',
          'wordingTwo': '<p>TEST WORDING 2</p>\n',
          'coverageOfferType': 'EVENTS',
          'requiresAgeCompliance': false,
          'benefitType': {'benefitTypeId': 'A', 'name': 'Asistencias'},
          'supplier': {
            'supplierId': 'PCS-2022-01',
            'folio': 'PCS-2022-01',
            'personTypeId': 'C',
            'shortName': 'Seguros Argos',
            'name': 'Seguros Argos S.A de C.V',
            'internationalLada': '+52',
            'phoneNumber': '1234567890',
            'taxId': 'XAXX010101000',
            'logo': 'suppliers/PCS-2022-01/logo.jpg'
          },
          'benefitImage': 'benefits/AOPS061100-000-001/image.png',
          'benefit': {
            'benefitId': 'AOPS061100-000',
            'name': 'Asistencias Tecnológicas Telefónicas',
            'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
            'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
            'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
          },
          'hasBenefitForm': false,
          'alreadyAcquired': false
        },
        {
          'additionalBenefitPerSupplierId': 'CNC2021-AOPS351100-000',
          'folio': 'CNC2021-AOPS351100-000',
          'wordingZero': '<p>TEST WORDING 0</p>\n',
          'wordingOne': '<p>TEST WORDING 1</p>\n',
          'wordingTwo': '<p>TEST WORDING 2</p>\n',
          'coverageOfferType': 'EVENTS',
          'requiresAgeCompliance': false,
          'benefitType': {'benefitTypeId': 'A', 'name': 'Asistencias'},
          'supplier': {
            'supplierId': 'PCS-2022-01',
            'folio': 'PCS-2022-01',
            'personTypeId': 'C',
            'shortName': 'Seguros Argos',
            'name': 'Seguros Argos S.A de C.V',
            'internationalLada': '+52',
            'phoneNumber': '1234567890',
            'taxId': 'XAXX010101000',
            'logo': 'suppliers/PCS-2022-01/logo.jpg'
          },
          'benefit': {
            'benefitId': 'AOPS351100-000',
            'name': 'Descarga de Aplicaciones',
            'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
            'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
            'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
          },
          'hasBenefitForm': false,
          'alreadyAcquired': false
        },
        {
          'additionalBenefitPerSupplierId': 'CNC2021-SOPS331000-000',
          'folio': 'CNC2021-SOPS331000-000',
          'wordingZero': '<p>TEST WORDING 0</p>\n',
          'wordingOne': '<p>TEST WORDING 1</p>\n',
          'wordingTwo': '<p>TEST WORDING 2</p>\n',
          'coverageOfferType': 'SUM_INSURED',
          'requiresAgeCompliance': false,
          'benefitType': {'benefitTypeId': 'S', 'name': 'Seguros'},
          'supplier': {
            'supplierId': 'PCS-2022-01',
            'folio': 'PCS-2022-01',
            'personTypeId': 'C',
            'shortName': 'Seguros Argos',
            'name': 'Seguros Argos S.A de C.V',
            'internationalLada': '+52',
            'phoneNumber': '1234567890',
            'taxId': 'XAXX010101000',
            'logo': 'suppliers/PCS-2022-01/logo.jpg'
          },
          'benefit': {
            'benefitId': 'SOPS331000-000',
            'name': 'Gastos Médicos Menores',
            'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
            'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
            'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
          },
          'hasBenefitForm': false,
          'alreadyAcquired': false
        },
      ];

  Map<String, dynamic> get fakeAdditionalBenefitByIdJson => {
        'additionalBenefitPerSupplierId': 'CNC2021-AOPS061100-000',
        'folio': 'CNC2021-AOPS061100-000',
        'wordingZero': '<p>TEST WORDING 0</p>\n',
        'wordingOne': '<p>TEST WORDING 1</p>\n',
        'wordingTwo': '<p>TEST WORDING 2</p>\n',
        'coverageOfferType': 'EVENTS',
        'requiresAgeCompliance': false,
        'benefitType': {'benefitTypeId': 'A', 'name': 'Asistencias'},
        'supplier': {
          'supplierId': 'PCS-2022-01',
          'folio': 'PCS-2022-01',
          'personTypeId': 'C',
          'shortName': 'Seguros Argos',
          'name': 'Seguros Argos S.A de C.V',
          'internationalLada': '+52',
          'phoneNumber': '1234567890',
          'taxId': 'XAXX010101000',
          'logo': 'suppliers/PCS-2022-01/logo.jpg'
        },
        'benefitImage': 'benefits/AOPS061100-000-001/image.png',
        'benefit': {
          'benefitId': 'AOPS061100-000',
          'name': 'Asistencias Tecnológicas Telefónicas',
          'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
          'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
          'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
        },
        'productRates': {
          'summedOriginalRiskPremium': 762,
          'summedRiskPremium': 810,
          'summedNetPremium': 766,
          'summedTotalPremium': 972,
          'marketDiscount': 0,
          'volumeDiscount': 0.004,
          'finalDiscount': 0.004,
          'finalTotalPremium': 968.11,
          'finalNetPremium': 762.94,
          'finalRiskPremium': 806.76,
          'finalOriginalRiskPremium': 758.95,
          'finalTotalDiscountAmount': 3.87,
          'finalMarketDiscountAmount': 0,
          'finalVolumeDiscountAmount': 3.87,
          'enrollerCommission': 0,
          'sellerCommission': 48.41,
          'officeCommission': 77.45
        },
        'intermediaryFees': [
          {
            'intermediaryFeeId': 'CNC2021-AOPS061100-000_intermediaryFee_2',
            'intermediaryTypeId': 'B',
            'feePercent': 0.05,
            'registerDate': '2022-07-21T15:57:03.000Z'
          },
          {
            'intermediaryFeeId': 'CNC2021-AOPS061100-000_intermediaryFee_1',
            'intermediaryTypeId': 'S',
            'feePercent': 0.05,
            'registerDate': '2022-07-21T15:57:03.000Z'
          },
          {
            'intermediaryFeeId': 'CNC2021-AOPS061100-000_intermediaryFee_0',
            'intermediaryTypeId': 'O',
            'feePercent': 0.08,
            'registerDate': '2022-07-21T15:57:03.000Z'
          }
        ],
        'coverageOfferValue': 2146,
        'hasBenefitForm': false,
        'userQuotationId':
            '1a4b9c0e6fe1a40ffa1259f56e40f1758660cf5e46bfb2b375e38af181899d1b',
        'quotationRegisterDate': '2022-10-13T00:32:24.531Z'
      };
}
