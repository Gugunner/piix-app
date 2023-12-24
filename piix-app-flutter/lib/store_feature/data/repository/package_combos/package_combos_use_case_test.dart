import 'package:piix_mobile/store_feature/data/repository/package_combos/package_combos_repository.dart';

///Is a use case test extension of [PackageCombosRepository]
///Contains all api mock calls
///
extension PackageCombosUseCaseTest on PackageCombosRepository {
  ///Gets package combos by membership id mock
  ///
  Future<dynamic> getPackageCombosByMembershipTest(
      {required PackageCombosResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PackageCombosResponseTypes.empty:
          return [];
        case PackageCombosResponseTypes.success:
          return fakePackageCombosJson;
        case PackageCombosResponseTypes.error:
          return PackageCombosState.error;
        case PackageCombosResponseTypes.unexpectedError:
          return PackageCombosState.unexpectedError;
        case PackageCombosResponseTypes.conflict:
          return PackageCombosState.conflict;
      }
    });
  }

  ///Gets package combos whit details and prices by package combo id and
  ///membership id mock
  ///
  Future<dynamic> getPackageCombosWithDetailsAndPriceByMembershipTest(
      {required PackageCombosResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PackageCombosResponseTypes.success:
          return fakePackageComboByIdJson;
        case PackageCombosResponseTypes.error:
          return PackageCombosState.error;
        case PackageCombosResponseTypes.unexpectedError:
        default:
          return PackageCombosState.unexpectedError;
      }
    });
  }

  List<Map<String, dynamic>> get fakePackageCombosJson => [
        {
          'packageComboId': 'CNOC-2022-Combo3',
          'folio': 'CNOC-2022-Combo3',
          'name': 'Combo Servicios Tecnológicos',
          'description':
              'Soporte telefónico para descarga de aplicaciones, respaldo de contactos y recuperación de datos, en cualquier momento y lugar que lo necesites.',
          'comboDiscount': 0.2,
          'active': true,
          'registerDate': '2022-02-27T20:05:01.000Z',
          'updateDate': '2022-02-08T16:42:56.000Z',
          'additionalBenefitsPerSupplier': [
            {
              'additionalBenefitPerSupplierId': 'CNOC-2022-01-AOPS351200-000',
              'folio': 'CNOC-2022-01-AOPS351200-000',
              'wordingZero':
                  '<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de cómputo o celulares.<br>Respaldo de contactos. Se proporcionará asesoría para el respaldo de información en el caso de cambios de dispositivo móvil o en caso de formateo del equipo.</p><p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p> ',
              'wordingOne': 'Wording 1',
              'wordingTwo': 'Wording 2',
              'coverageOfferType': 'SUM_INSURED',
              'requiresAgeCompliance': false,
              'benefitImage':
                  'additional_benefits_per_supplier/CNOC-2022-01-AOPS351200-000/benefitImage.png',
              'pdfWording':
                  'additional_benefits_per_supplier/CNOC-2022-01-AOPS351200-000/pdfWording.pdf',
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
                'benefitId': 'AOPS351200-000',
                'name': 'Respaldo de Contactos',
                'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
              },
              'hasBenefitForm': false,
              'needsBenefitFormSignature': false
            },
            {
              'additionalBenefitPerSupplierId': 'CNOC-2022-01-AOPS351100-000',
              'folio': 'CNOC-2022-01-AOPS351100-000',
              'wordingZero':
                  '<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de cómputo o celulares.<br>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>',
              'wordingOne': 'Wording 1',
              'wordingTwo': 'Wording 2',
              'coverageOfferType': 'EVENTS',
              'requiresAgeCompliance': false,
              'benefitImage':
                  'additional_benefits_per_supplier/CNOC-2022-01-AOPS351100-000/benefitImage.png',
              'pdfWording':
                  'additional_benefits_per_supplier/CNOC-2022-01-AOPS351100-000/pdfWording.pdf',
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
              'needsBenefitFormSignature': false
            }
          ],
          'alreadyAcquired': false
        }
      ];
  Map<String, dynamic> get fakePackageComboByIdJson => {
        'packageComboId': 'CNOC-2022-Combo3',
        'folio': 'CNOC-2022-Combo3',
        'name': 'Combo Servicios Tecnológicos',
        'description':
            'Soporte telefónico para descarga de aplicaciones, respaldo de contactos y recuperación de datos, en cualquier momento y lugar que lo necesites.',
        'comboDiscount': 0.2,
        'active': true,
        'registerDate': '2022-02-27T20:05:01.000Z',
        'updateDate': '2022-02-08T16:42:56.000Z',
        'additionalBenefitsPerSupplier': [
          {
            'additionalBenefitPerSupplierId': 'CNOC-2022-01-AOPS351100-000',
            'folio': 'CNOC-2022-01-AOPS351100-000',
            'wordingZero':
                '<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de cómputo o celulares.<br>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>',
            'wordingOne': 'Wording 1',
            'wordingTwo': 'Wording 2',
            'coverageOfferType': 'EVENTS',
            'requiresAgeCompliance': false,
            'benefitImage':
                'additional_benefits_per_supplier/CNOC-2022-01-AOPS351100-000/benefitImage.png',
            'pdfWording':
                'additional_benefits_per_supplier/CNOC-2022-01-AOPS351100-000/pdfWording.pdf',
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
            'productRates': {
              'summedOriginalRiskPremium': 432,
              'summedRiskPremium': 317,
              'summedNetPremium': 396,
              'summedTotalPremium': 481,
              'marketDiscount': 0.01,
              'volumeDiscount': 0.002,
              'finalDiscount': 0.012,
              'finalTotalPremium': 475.23,
              'finalNetPremium': 391.25,
              'finalRiskPremium': 313.2,
              'finalOriginalRiskPremium': 426.82,
              'finalTotalDiscountAmount': 5.7,
              'finalMarketDiscountAmount': 4.75,
              'finalVolumeDiscountAmount': 0.95,
              'enrollerCommission': 19.0092,
              'sellerCommission': 4.7523,
              'officeCommission': 14.2569
            },
            'hasBenefitForm': false,
            'needsBenefitFormSignature': false,
            'alreadyAcquired': false,
            'coverageOfferValue': 2762
          },
          {
            'additionalBenefitPerSupplierId': 'CNOC-2022-01-AOPS351200-000',
            'folio': 'CNOC-2022-01-AOPS351200-000',
            'wordingZero':
                '<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de cómputo o celulares.<br>Respaldo de contactos. Se proporcionará asesoría para el respaldo de información en el caso de cambios de dispositivo móvil o en caso de formateo del equipo.</p><p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p> ',
            'wordingOne': 'Wording 1',
            'wordingTwo': 'Wording 2',
            'coverageOfferType': 'SUM_INSURED',
            'requiresAgeCompliance': false,
            'benefitImage':
                'additional_benefits_per_supplier/CNOC-2022-01-AOPS351200-000/benefitImage.png',
            'pdfWording':
                'additional_benefits_per_supplier/CNOC-2022-01-AOPS351200-000/pdfWording.pdf',
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
              'benefitId': 'AOPS351200-000',
              'name': 'Respaldo de Contactos',
              'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
              'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
              'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
            },
            'productRates': {
              'summedOriginalRiskPremium': 430,
              'summedRiskPremium': 451,
              'summedNetPremium': 372,
              'summedTotalPremium': 566,
              'marketDiscount': 0.01,
              'volumeDiscount': 0.002,
              'finalDiscount': 0.012,
              'finalTotalPremium': 559.21,
              'finalNetPremium': 367.54,
              'finalRiskPremium': 445.59,
              'finalOriginalRiskPremium': 424.84,
              'finalTotalDiscountAmount': 6.71,
              'finalMarketDiscountAmount': 5.59,
              'finalVolumeDiscountAmount': 1.12,
              'enrollerCommission': 22.3684,
              'sellerCommission': 5.5921,
              'officeCommission': 16.7763
            },
            'hasBenefitForm': false,
            'needsBenefitFormSignature': false,
            'alreadyAcquired': false,
            'coverageOfferValue': 4069
          }
        ],
        'productRates': {
          'summedOriginalRiskPremium': 862,
          'summedRiskPremium': 768,
          'summedNetPremium': 768,
          'summedTotalPremium': 1047,
          'enrollerCommission': 41.38,
          'sellerCommission': 10.34,
          'officeCommission': 31.03,
          'marketDiscount': 0.01,
          'volumeDiscount': 0.002,
          'finalDiscount': 0.212,
          'comboDiscount': 0.2,
          'finalTotalPremium': 825.04,
          'finalNetPremium': 605.18,
          'finalRiskPremium': 605.18,
          'finalOriginalRiskPremium': 679.26,
          'finalTotalDiscountAmount': 174.91,
          'finalMarketDiscountAmount': 8.25,
          'finalVolumeDiscountAmount': 1.65,
          'finalComboDiscountAmount': 165.01
        },
        'userQuotationId':
            '1d3cdb8786e0d1ae85401a663eea2c806401bd0f88b0ce10974208d608a3d959'
      };
}
