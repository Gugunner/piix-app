import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';

///Is a use case test extension of [PurchaseInvoiceRepositoryDeprecated]
///Contains all api mock calls
///
extension LevelsUseCaseTest on PurchaseInvoiceRepositoryDeprecated {
  ///Gets purchase invoice by membership id mock
  ///
  Future<dynamic> getPurchaseInvoiceByMembershipRequestedTest(
      {required InvoiceResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case InvoiceResponseTypes.empty:
          return [];
        case InvoiceResponseTypes.success:
          return fakeInvoicesJson;
        case InvoiceResponseTypes.error:
          return LevelStateDeprecated.error;
        case InvoiceResponseTypes.unexpectedError:
          return LevelStateDeprecated.unexpectedError;
        case InvoiceResponseTypes.conflict:
          return LevelStateDeprecated.conflict;
      }
    });
  }

  ///Get Additional Benefit Purchase Invoice By Id mock
  ///
  Future<dynamic> getAdditionalBenefitPurchaseInvoiceRequestedTest(
      {required InvoiceResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case InvoiceResponseTypes.empty:
          return [];
        case InvoiceResponseTypes.success:
          return fakeAdditionalBenefitPurchaseJson;
        case InvoiceResponseTypes.error:
          return LevelStateDeprecated.error;
        case InvoiceResponseTypes.unexpectedError:
          return LevelStateDeprecated.unexpectedError;
        case InvoiceResponseTypes.conflict:
          return LevelStateDeprecated.conflict;
      }
    });
  }

  ///Get Package Combo Purchase Invoice By Id mock
  ///
  Future<dynamic> getPackageComboPurchaseInvoiceByIdTest(
      {required InvoiceResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case InvoiceResponseTypes.empty:
          return [];
        case InvoiceResponseTypes.success:
          return fakePackageComboPurchaseJson;
        case InvoiceResponseTypes.error:
          return LevelStateDeprecated.error;
        case InvoiceResponseTypes.unexpectedError:
          return LevelStateDeprecated.unexpectedError;
        case InvoiceResponseTypes.conflict:
          return LevelStateDeprecated.conflict;
      }
    });
  }

  ///Get Level Purchase Invoice By Id
  ///
  Future<dynamic> getLevelPurchaseInvoiceByIdTest(
      {required InvoiceResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case InvoiceResponseTypes.empty:
          return [];
        case InvoiceResponseTypes.success:
          return fakeLevelPurchaseJson;
        case InvoiceResponseTypes.error:
          return LevelStateDeprecated.error;
        case InvoiceResponseTypes.unexpectedError:
          return LevelStateDeprecated.unexpectedError;
        case InvoiceResponseTypes.conflict:
          return LevelStateDeprecated.conflict;
      }
    });
  }

  ///Get Plan Purchase Invoice By Id
  ///
  Future<dynamic> getPlanPurchaseInvoiceByIdTest(
      {required InvoiceResponseTypes type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case InvoiceResponseTypes.empty:
          return [];
        case InvoiceResponseTypes.success:
          return fakePlanPurchaseJson;
        case InvoiceResponseTypes.error:
          return LevelStateDeprecated.error;
        case InvoiceResponseTypes.unexpectedError:
          return LevelStateDeprecated.unexpectedError;
        case InvoiceResponseTypes.conflict:
          return LevelStateDeprecated.conflict;
      }
    });
  }

  List<Map<String, dynamic>> get fakeInvoicesJson => [
        {
          'purchaseInvoiceId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363422',
          'userId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
          'packageId': 'CNOC-2022-01',
          'paymentId': '1246363407',
          'paymentMethodId': 'oxxo',
          'paymentMethodReferenceId': '6003025189',
          'paymentStatus': 'approved',
          'controlStatus': 'ACTIVE',
          'expirationDate': '2022-02-28T18:21:06.000Z',
          'approvedDate': '2022-03-02T01:01:55.000Z',
          'registerDate': '2022-03-01T01:01:55.000Z',
          'updateDate': '2022-02-23T18:23:05.000Z',
          'userQuotation': {
            'userQuotationId':
                'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363422',
            'productType': 'COMBO',
            'totalPremium': 1080,
            'totalNetPremium': 0,
            'totalRiskPremium': 0,
            'totalOriginalRiskPremium': 0,
            'marketDiscountAmount': 0,
            'volumeDiscountAmount': 0,
            'comboDiscountAmount': 0,
            'totalDiscountAmount': 0
          },
          'products': {
            'PackageCombo': {
              'packageComboId': 'CNOC-2022-Combo3',
              'folio': 'CNOC-2022-Combo3',
              'name': 'Combo Servicios Tecnológicos'
            }
          }
        },
        {
          'purchaseInvoiceId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363872',
          'userId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
          'packageId': 'CNOC-2022-01',
          'paymentId': '1246363872',
          'paymentMethodId': 'serfin',
          'accountNumber': '0906',
          'paymentMethodReferenceId': '60030252003',
          'paymentStatus': 'approved',
          'controlStatus': 'ACTIVE',
          'expirationDate': '2022-03-25T18:41:47.000Z',
          'registerDate': '2022-03-01T01:01:58.000Z',
          'updateDate': '2022-02-23T18:43:02.000Z',
          'userQuotation': {
            'userQuotationId':
                'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363872',
            'productType': 'LEVEL',
            'totalPremium': 400,
            'totalNetPremium': 0,
            'totalRiskPremium': 0,
            'totalOriginalRiskPremium': 0,
            'marketDiscountAmount': 0,
            'volumeDiscountAmount': 0,
            'comboDiscountAmount': 0,
            'totalDiscountAmount': 0
          },
          'products': {
            'Level': {
              'levelId': 'level3',
              'folio': 'level3',
              'name': 'Gold',
              'membershipLevelImage': 'levels/level3/membershipLevelImage.png'
            }
          }
        },
        {
          'purchaseInvoiceId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720',
          'userId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
          'packageId': 'CNOC-2022-01',
          'paymentId': '1246364720',
          'paymentMethodId': 'banamex',
          'accountNumber': '0165-7806117',
          'paymentMethodReferenceId': '6003025195-46',
          'paymentStatus': 'approved',
          'controlStatus': 'ACTIVE',
          'expirationDate': '2022-03-25T18:30:39.000Z',
          'approvedDate': '2022-02-22T01:02:01.000Z',
          'registerDate': '2022-02-20T01:02:01.000Z',
          'updateDate': '2022-02-23T18:32:45.000Z',
          'userQuotation': {
            'userQuotationId':
                'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720',
            'productType': 'ADDITIONAL',
            'totalPremium': 60,
            'totalNetPremium': 0,
            'totalRiskPremium': 0,
            'totalOriginalRiskPremium': 0,
            'marketDiscountAmount': 0,
            'volumeDiscountAmount': 0,
            'comboDiscountAmount': 0,
            'totalDiscountAmount': 0
          },
          'products': {
            'AdditionalBenefitsPerSupplier': [
              {
                'additionalBenefitPerSupplierId': 'CNOC-2022-01-AOPS051100-000',
                'folio': 'CNOC-2022-01-AOPS051100-000',
                'wordingZero':
                    '<p>Esta asistencia cubre los <u>servicios de orientación psicológica telefónica del socio y sus protegidos</u> (según el plan elegido) únicamente de contención.<br >En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>',
                'benefitImage':
                    'additional_benefits_per_supplier/CNOC-2022-01-AOPS051100-000/benefitImage.png',
                'pdfWording':
                    'additional_benefits_per_supplier/CNOC-2022-01-AOPS051100-000/pdfWording.pdf',
                'supplier': {
                  'supplierId': 'PCS-2022-01',
                  'folio': 'PCS-2022-01',
                  'personTypeId': 'C',
                  'shortName': 'Seguros Argos',
                  'name': 'Seguros Argos S.A de C.V',
                  'logo': 'suppliers/PCS-2022-01/logo.jpg'
                },
                'benefit': {
                  'benefitId': 'AOPS051100-000',
                  'name': 'Asistencia Psicológica vía Telefónica'
                },
                'hasBenefitForm': false
              }
            ]
          }
        },
        {
          'purchaseInvoiceId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946',
          'userId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
          'packageId': 'CNOC-2022-01',
          'paymentId': '1246364946',
          'paymentMethodId': 'bancomer',
          'accountNumber': '0641375',
          'paymentMethodReferenceId': '60030251973',
          'paymentStatus': 'approved',
          'controlStatus': 'ACTIVE',
          'expirationDate': '2022-03-25T18:36:03.000Z',
          'registerDate': '2022-03-01T01:02:04.000Z',
          'updateDate': '2022-02-23T18:37:34.000Z',
          'userQuotation': {
            'userQuotationId':
                'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946',
            'productType': 'PLAN',
            'totalPremium': 350,
            'totalNetPremium': 0,
            'totalRiskPremium': 0,
            'totalOriginalRiskPremium': 0,
            'marketDiscountAmount': 0,
            'volumeDiscountAmount': 0,
            'comboDiscountAmount': 0,
            'totalDiscountAmount': 0,
            'planIds': ['167544008c2dd51966c030b5321b36212022a1b32830c3c0e6']
          },
          'products': {
            'Plans': [
              {
                'planId': '167544008c2dd51966c030b5321b36212022a1b32830c3c0e6',
                'folio': 'plan-27',
                'name': 'Concubina'
              }
            ],
            'protectedAcquired': 1
          }
        }
      ];

  Map<String, dynamic> get fakeAdditionalBenefitPurchaseJson => {
        'purchaseInvoiceId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946',
        'userId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
        'packageId': 'CNOC-2022-01',
        'paymentId': '1246364720',
        'paymentMethodId': 'banamex',
        'accountNumber': '0165-7806117',
        'paymentMethodReferenceId': '6003025195-46',
        'paymentStatus': 'approved',
        'controlStatus': 'ACTIVE',
        'expirationDate': '2022-03-25T18:30:39.000Z',
        'approvedDate': '2022-02-22T01:02:01.000Z',
        'registerDate': '2022-02-20T01:02:01.000Z',
        'updateDate': '2022-02-23T18:32:45.000Z',
        'userQuotation': {
          'userQuotationId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364720',
          'membershipLevelId': 'level1',
          'membershipPlanIds': [
            'e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d'
          ],
          'productType': 'ADDITIONAL',
          'totalPremium': 60,
          'totalNetPremium': 0,
          'totalRiskPremium': 0,
          'totalOriginalRiskPremium': 0,
          'marketDiscountAmount': 0,
          'volumeDiscountAmount': 0,
          'comboDiscountAmount': 0,
          'totalDiscountAmount': 0,
          'additionalBenefitsPerSupplierIds': ['CNOC-2022-01-AOPS051100-000'],
          'intermediariesCommissions': [],
          'quotationStatus': 'PURCHASED',
          'registerDate': '2022-09-09T17:53:09.000Z'
        },
        'products': {
          'AdditionalBenefitsPerSupplier': [
            {
              'additionalBenefitPerSupplierId': 'CNOC-2022-01-AOPS051100-000',
              'folio': 'CNOC-2022-01-AOPS051100-000',
              'wordingZero':
                  '<p>Esta asistencia cubre los <u>servicios de orientación psicológica telefónica del socio y sus protegidos</u> (según el plan elegido) únicamente de contención.<br >En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>',
              'wordingOne': 'Wording 1',
              'wordingTwo': 'Wording 2',
              'coverageOfferType': 'EVENTS',
              'requiresAgeCompliance': false,
              'benefitImage':
                  'additional_benefits_per_supplier/CNOC-2022-01-AOPS051100-000/benefitImage.png',
              'pdfWording':
                  'additional_benefits_per_supplier/CNOC-2022-01-AOPS051100-000/pdfWording.pdf',
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
                'benefitId': 'AOPS051100-000',
                'name': 'Asistencia Psicológica vía Telefónica',
                'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
              },
              'hasBenefitForm': false,
              'coverageOfferValue': 2306
            }
          ]
        },
        'protectedQuantityInCoverage': {
          'includesMainUser': true,
          'protectedQuantity': 0
        }
      };
  Map<String, dynamic> get fakePackageComboPurchaseJson => {
        'purchaseInvoiceId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363422',
        'userId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
        'packageId': 'CNOC-2022-01',
        'paymentId': '1246363407',
        'paymentMethodId': 'oxxo',
        'barcode': '78000000600302518928022201080002',
        'barcodeType': 'Code128C',
        'paymentMethodReferenceId': '6003025189',
        'paymentStatus': 'approved',
        'controlStatus': 'ACTIVE',
        'expirationDate': '2022-02-28T18:21:06.000Z',
        'approvedDate': '2022-03-02T01:01:55.000Z',
        'registerDate': '2022-03-01T01:01:55.000Z',
        'updateDate': '2022-02-23T18:23:05.000Z',
        'userQuotation': {
          'userQuotationId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363422',
          'membershipLevelId': 'level1',
          'membershipPlanIds': [
            'e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d'
          ],
          'productType': 'COMBO',
          'totalPremium': 1080,
          'totalNetPremium': 0,
          'totalRiskPremium': 0,
          'totalOriginalRiskPremium': 0,
          'marketDiscountAmount': 0,
          'volumeDiscountAmount': 0,
          'comboDiscountAmount': 0,
          'totalDiscountAmount': 0,
          'additionalBenefitsPerSupplierIds': [
            'CNOC-2022-01-AOPS351100-000',
            'CNOC-2022-01-AOPS351200-000'
          ],
          'packageComboId': 'CNOC-2022-Combo3',
          'intermediariesCommissions': [],
          'quotationStatus': 'PURCHASED',
          'registerDate': '2022-09-09T17:53:09.000Z'
        },
        'products': {
          'PackageCombo': {
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
                'hasBenefitForm': false,
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
                'hasBenefitForm': false,
                'coverageOfferValue': 4069
              }
            ]
          }
        },
        'protectedQuantityInCoverage': {
          'includesMainUser': true,
          'protectedQuantity': 0
        }
      };
  Map<String, dynamic> get fakePlanPurchaseJson => {
        'purchaseInvoiceId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946',
        'userId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
        'packageId': 'CNOC-2022-01',
        'paymentId': '1246364946',
        'paymentMethodId': 'bancomer',
        'accountNumber': '0641375',
        'paymentMethodReferenceId': '60030251973',
        'paymentStatus': 'approved',
        'controlStatus': 'ACTIVE',
        'expirationDate': '2022-03-25T18:36:03.000Z',
        'registerDate': '2022-03-01T01:02:04.000Z',
        'updateDate': '2022-02-23T18:37:34.000Z',
        'userQuotation': {
          'userQuotationId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246364946',
          'membershipLevelId': 'level1',
          'membershipPlanIds': [
            'e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d'
          ],
          'productType': 'PLAN',
          'totalPremium': 350,
          'totalNetPremium': 0,
          'totalRiskPremium': 0,
          'totalOriginalRiskPremium': 0,
          'marketDiscountAmount': 0,
          'volumeDiscountAmount': 0,
          'comboDiscountAmount': 0,
          'totalDiscountAmount': 0,
          'planIds': ['167544008c2dd51966c030b5321b36212022a1b32830c3c0e6'],
          'intermediariesCommissions': [],
          'quotationStatus': 'PURCHASED',
          'registerDate': '2022-09-09T17:53:09.000Z'
        },
        'products': {
          'Plans': [
            {
              'planId': '167544008c2dd51966c030b5321b36212022a1b32830c3c0e6',
              'folio': 'plan-27',
              'name': 'Concubina',
              'pseudonym': 'Concubina',
              'maxUsersInPlan': 1,
              'kinshipId': 'kinship81',
              'registerDate': '2022-07-14T15:38:18.000Z',
              'kinship': {
                'kinshipId': 'kinship81',
                'folio': 'kinship81',
                'name': 'Concubina',
                'registerDate': '2022-02-22T02:42:11.000Z'
              },
              'protectedAcquired': 1
            }
          ],
          'TotalProtectedAcquired': 1
        },
        'protectedQuantityInCoverage': {
          'includesMainUser': true,
          'protectedQuantity': 0
        }
      };

  Map<String, dynamic> get fakeLevelPurchaseJson => {
        'purchaseInvoiceId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363872',
        'userId':
            'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60',
        'packageId': 'CNOC-2022-01',
        'paymentId': '1246363872',
        'paymentMethodId': 'serfin',
        'accountNumber': '0906',
        'paymentMethodReferenceId': '60030252003',
        'paymentStatus': 'approved',
        'controlStatus': 'ACTIVE',
        'expirationDate': '2022-03-25T18:41:47.000Z',
        'registerDate': '2022-03-01T01:01:58.000Z',
        'updateDate': '2022-02-23T18:43:02.000Z',
        'userQuotation': {
          'userQuotationId':
              'b48678cd40feb620894ec9b87c0ca9c9474b7708e75ff18358ccadb945072c60-1246363872',
          'membershipLevelId': 'level1',
          'membershipPlanIds': [
            'e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d'
          ],
          'productType': 'LEVEL',
          'totalPremium': 400,
          'totalNetPremium': 0,
          'totalRiskPremium': 0,
          'totalOriginalRiskPremium': 0,
          'marketDiscountAmount': 0,
          'volumeDiscountAmount': 0,
          'comboDiscountAmount': 0,
          'totalDiscountAmount': 0,
          'levelId': 'level3',
          'intermediariesCommissions': [],
          'quotationStatus': 'PURCHASED',
          'registerDate': '2022-09-09T17:53:09.000Z'
        },
        'products': {
          'Level': {
            'levelId': 'level3',
            'folio': 'level3',
            'name': 'Gold',
            'pseudonym': 'Nivel 3 del Paquete Asignado.',
            'registerDate': '2022-02-18T21:42:45.000Z',
            'updateDate': '2022-02-18T00:00:00.000Z',
            'membershipLevelImage': 'levels/level3/membershipLevelImage.png',
            'comparisonInformation': {
              'newBenefits': [],
              'existingAdditionalBenefitsWithCoverageOfferValues': [
                {
                  'additionalBenefitPerSupplierId':
                      'CNOC-2022-01-AOPS051100-000',
                  'folio': 'CNOC-2022-01-AOPS051100-000',
                  'wordingZero':
                      '<p>Esta asistencia cubre los <u>servicios de orientación psicológica telefónica del socio y sus protegidos</u> (según el plan elegido) únicamente de contención.<br >En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>',
                  'coverageOfferType': 'EVENTS',
                  'newCoverageOfferValue': 4064,
                  'oldCoverageOfferValue': 2306,
                  'benefitName': 'Asistencia Psicológica vía Telefónica',
                  'benefitId': 'AOPS051100-000',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'additionalBenefitPerSupplierId':
                      'CNOC-2022-01-AOPS351100-000',
                  'folio': 'CNOC-2022-01-AOPS351100-000',
                  'wordingZero':
                      '<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de cómputo o celulares.<br>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>',
                  'coverageOfferType': 'EVENTS',
                  'newCoverageOfferValue': 2152,
                  'oldCoverageOfferValue': 2762,
                  'benefitName': 'Descarga de Aplicaciones',
                  'benefitId': 'AOPS351100-000',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'additionalBenefitPerSupplierId':
                      'CNOC-2022-01-AOPS351200-000',
                  'folio': 'CNOC-2022-01-AOPS351200-000',
                  'wordingZero':
                      '<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de cómputo o celulares.<br>Respaldo de contactos. Se proporcionará asesoría para el respaldo de información en el caso de cambios de dispositivo móvil o en caso de formateo del equipo.</p><p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p> ',
                  'coverageOfferType': 'SUM_INSURED',
                  'newCoverageOfferValue': 2448,
                  'oldCoverageOfferValue': 4069,
                  'benefitName': 'Respaldo de Contactos',
                  'benefitId': 'AOPS351200-000',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                }
              ],
              'existingBenefitsAndCobenefitsWithCoverageOfferValues': [
                {
                  'benefitPerSupplierId': 'CNOC-2022-01-ZOPS511000-000',
                  'wordingZero':
                      '<p>Recompensa. Este beneficio otorga al socio y sus protegidos (según el plan seleccionado) acceso a descuentos y servicios a través de una membresía digital MAS DESCUENTOS, los cuales consisten en:</p>\n<ol>\n<li>Alimentos y bebidas</li>\n<li>Salud</li>\n<li>Belleza</li>\n<li>Educación</li>\n<li>Entretenimiento</li>\n<li>Moda y hogar</li>\n<li>Servicios</li>\n<li>Tecnología</li>\n<li>Turismo.</li>\n</ol>\n',
                  'hasCobenefits': false,
                  'coverageOfferType': 'SUM_INSURED',
                  'newCoverageOfferValue': 2623,
                  'oldCoverageOfferValue': 1493,
                  'benefitName': 'MAS Descuentos Comerciales',
                  'benefitId': 'ZOPS511000-000',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-003',
                  'wordingZero':
                      '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: Cerrajería para tu domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                  'coverageOfferType': 'SUM_INSURED',
                  'newCoverageOfferValue': 2156,
                  'oldCoverageOfferValue': 1863,
                  'benefitName': 'Asistencia en el Hogar Cerrajería',
                  'benefitId': 'AOPS211000-003',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-002',
                  'wordingZero':
                      '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: Electricista para tu domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                  'coverageOfferType': 'SUM_INSURED',
                  'newCoverageOfferValue': 2761,
                  'oldCoverageOfferValue': 4014,
                  'benefitName': 'Asistencia en el Hogar Electricista',
                  'benefitId': 'AOPS211000-002',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-001',
                  'wordingZero':
                      '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: plomería para su domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                  'coverageOfferType': 'SUM_INSURED',
                  'newCoverageOfferValue': 2303,
                  'oldCoverageOfferValue': 510,
                  'benefitName': 'Asistencia en el Hogar Plomería',
                  'benefitId': 'AOPS211000-001',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'cobenefitPerSupplierId': 'CNOC-2022-01-SOPS311000-001',
                  'wordingZero':
                      '<p>Suma asegurada: \$200,000.00 (doscientos mil/pesos).</p>\n<p>Si el socio o sus protegidos (según el plan elegido) a consecuencia de un accidente cubierto, sufriera una pérdida orgánica, dentro de los 90 días de ocurrido el accidente, recibirá un monto indemnizable de acuerdo con la tabla de indemnizaciones Escala B.</p>\n<p>En todos los casos aplican exclusiones y condiciones estipuladas en la póliza.</p>\n',
                  'coverageOfferType': 'EVENTS',
                  'newCoverageOfferValue': 648,
                  'oldCoverageOfferValue': 3813,
                  'benefitName': 'Pérdidas Orgánicas',
                  'benefitId': 'SOPS311000-001',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                },
                {
                  'cobenefitPerSupplierId': 'CNOC-2022-01-XOPS411000-001',
                  'wordingZero':
                      '<p>Cubre los servicios de víales para los vehículos del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias Viales (según el nivel que seleccione) en caso de requerir servicios de: Grúa por avería.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                  'coverageOfferType': 'SUM_INSURED',
                  'newCoverageOfferValue': 6131,
                  'oldCoverageOfferValue': 3977,
                  'benefitName': 'Grúa por Avería',
                  'benefitId': 'XOPS411000-001',
                  'supplierName': 'Seguros Argos S.A de C.V',
                  'supplierId': 'PCS-2022-01'
                }
              ]
            }
          }
        },
        'protectedQuantityInCoverage': {
          'includesMainUser': true,
          'protectedQuantity': 0
        }
      };
}
