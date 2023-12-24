import 'package:piix_mobile/store_feature/data/repository/levels_deprecated/levels_repository_deprecated.dart';

///Is a use case test extension of [LevelsRepositoryDeprecated]
///Contains all api mock calls
///
extension LevelsUseCaseTest on LevelsRepositoryDeprecated {
  ///Gets levles by membership id mock
  ///
  Future<dynamic> getLevelsByMembershipTest(
      {required LevelResponseTypesDeprecated type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case LevelResponseTypesDeprecated.empty:
          return [];
        case LevelResponseTypesDeprecated.success:
          return fakeLevelsJson;
        case LevelResponseTypesDeprecated.error:
          return LevelStateDeprecated.error;
        case LevelResponseTypesDeprecated.unexpectedError:
          return LevelStateDeprecated.unexpectedError;
        case LevelResponseTypesDeprecated.conflict:
          return LevelStateDeprecated.conflict;
      }
    });
  }

  ///Gets level quotation by level id and
  ///membership id mock
  ///
  Future<dynamic> getLevelQuotationByMembershipTest(
      {required LevelResponseTypesDeprecated type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case LevelResponseTypesDeprecated.success:
          return fakeLevelQuotationJson;
        case LevelResponseTypesDeprecated.empty:
          return LevelStateDeprecated.empty;
        case LevelResponseTypesDeprecated.error:
          return LevelStateDeprecated.error;
        case LevelResponseTypesDeprecated.unexpectedError:
        default:
          return LevelStateDeprecated.unexpectedError;
      }
    });
  }

  Map<String, dynamic> get fakeLevelsJson => {
        'levelList': [
          {
            'levelId': 'level1',
            'folio': 'level1',
            'name': 'Blue',
            'pseudonym': 'Basico del Paquete Asignado.',
            'registerDate': '2022-02-18T21:40:45.000Z',
            'updateDate': '2022-02-18T00:00:00.000Z',
            'membershipLevelImage': 'levels/level1/membershipLevelImage.png',
            'alreadyAcquired': true,
            'benefits': [
              {
                'benefitPerSupplierId': 'CNOC-2022-01-AOPS211000-000',
                'wordingZero':
                    '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: plomería, electricista, cerrajería y vidriería para su domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                'coverageOfferType': 'SUM_INSURED',
                'requiresAgeCompliance': false,
                'benefitImage':
                    'benefits_per_supplier/CNOC-2022-01-AOPS211000-000/benefitImage.png',
                'pdfWording':
                    'benefits_per_supplier/CNOC-2022-01-AOPS211000-000/pdfWording.pdf',
                'benefit': {
                  'benefitId': 'AOPS211000-000',
                  'name': 'Asistencia en el Hogar',
                  'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                },
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
                'cobenefitsPerSupplier': [
                  {
                    'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-003',
                    'wordingZero':
                        '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: Cerrajería para tu domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                    'coverageOfferType': 'SUM_INSURED',
                    'requiresAgeCompliance': false,
                    'benefitImage':
                        'benefits_per_supplier/CNOC-2022-01-AOPS211000-003/benefitImage.png',
                    'pdfWording':
                        'benefits_per_supplier/CNOC-2022-01-AOPS211000-003/pdfWording.pdf',
                    'benefit': {
                      'benefitId': 'AOPS211000-003',
                      'name': 'Asistencia en el Hogar Cerrajería',
                      'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                      'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                      'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                    },
                    'supplier': {
                      'supplierId': 'PCS-2022-01',
                      'folio': 'PCS-2022-01',
                      'personTypeId': 'C',
                      'shortName': 'Seguros Argos',
                      'name': 'Seguros Argos S.A de C.V',
                      'internationalLada': '+52',
                      'phoneNumber': '1234567890',
                      'taxId': 'XAXX010101000'
                    },
                    'benefitType': {'benefitTypeId': 'A', 'name': 'Asistencias'}
                  },
                ],
                'hasCobenefits': true
              },
              {
                'benefitPerSupplierId': 'CNOC-2022-01-SOPS311000-000',
                'wordingZero':
                    '<p>Si el socio o sus protegidos (según el plan elegido) durante la vigencia de la póliza a consecuencia de un accidente cubierto y a causa de ello: el asegurado queda incapacitado permanentemente, genera gastos médicos o fallece; la compañía pagará al titular o beneficiario la cantidad de dinero que convino en su póliza.</p>\n<p>En todos los casos aplican exclusiones y condiciones estipuladas en la póliza.</p>\n',
                'coverageOfferType': 'SUM_INSURED',
                'requiresAgeCompliance': false,
                'benefitImage':
                    'benefits_per_supplier/CNOC-2022-01-SOPS311000-000/benefitImage.png',
                'pdfWording':
                    'benefits_per_supplier/CNOC-2022-01-SOPS311000-000/pdfWording.png',
                'benefit': {
                  'benefitId': 'SOPS311000-000',
                  'name': 'Accidentes Personales',
                  'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                },
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
                'cobenefitsPerSupplier': [],
                'hasCobenefits': false
              },
            ]
          },
          {
            'levelId': 'level2',
            'folio': 'level2',
            'name': 'Silver',
            'pseudonym': 'Nivel 2 del Paquete Asignado.',
            'registerDate': '2022-02-18T21:41:45.000Z',
            'updateDate': '2022-06-28T21:01:07.000Z',
            'membershipLevelImage': 'levels/level2/membershipLevelImage.png',
            'alreadyAcquired': false,
            'benefits': []
          },
          {
            'levelId': 'level3',
            'folio': 'level3',
            'name': 'Gold',
            'pseudonym': 'Nivel 3 del Paquete Asignado.',
            'registerDate': '2022-02-18T21:42:45.000Z',
            'updateDate': '2022-02-18T00:00:00.000Z',
            'membershipLevelImage': 'levels/level3/membershipLevelImage.png',
            'alreadyAcquired': false,
            'benefits': []
          },
          {
            'levelId': 'level4',
            'folio': 'level4',
            'name': 'Platinum',
            'pseudonym': 'Nivel 4 del Paquete Asignado.',
            'registerDate': '2022-02-18T21:43:45.000Z',
            'updateDate': '2022-02-18T00:00:00.000Z',
            'membershipLevelImage': 'levels/level4/membershipLevelImage.png',
            'alreadyAcquired': false,
            'benefits': [
              {
                'benefitPerSupplierId': 'CNOC-2022-01-AOPS212000-000',
                'wordingZero':
                    '<p>Esta asistencia cubre los servicios de traslado a centro hospitalario del socio y sus protegidos. En caso de que el usuario sufra un accidente o enfermedad que requiera el traslado. Se coordinará el envío de una ambulancia básica terrestre para ser trasladado al nosocomio más cercano de su elección.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                'coverageOfferType': 'EVENTS',
                'requiresAgeCompliance': false,
                'benefitImage':
                    'benefits_per_supplier/CNOC-2022-01-AOPS212000-000/benefitImage.png',
                'pdfWording':
                    'benefits_per_supplier/CNOC-2022-01-AOPS212000-000/pdfWording.pdf',
                'benefit': {
                  'benefitId': 'AOPS212000-000',
                  'name': 'Ambulancia Terrestre',
                  'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                },
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
                'hasBenefitForm': false,
                'needsBenefitFormSignature': false,
                'userHasAlreadySignedTheBenefitForm': false,
                'hasCobenefits': false
              }
            ]
          },
          {
            'levelId': 'level5',
            'folio': 'level5',
            'name': 'Negra',
            'pseudonym': 'Nivel 5 del Paquete Asignado.',
            'registerDate': '2022-02-18T21:44:45.000Z',
            'membershipLevelImage': 'levels/level5/membershipLevelImage.jpg',
            'alreadyAcquired': false,
            'benefits': [
              {
                'benefitPerSupplierId': 'CNOC-2022-01-AOPS111000-000',
                'wordingZero':
                    '<p>Esta asistencia cubre los servicios de asesoría jurídica telefónica de un profesional en derecho para el socio y sus protegidos (según el plan elegido), cuando se trate de actos, hechos, servicios o productos que se encuentren comprendidos en normativas aplicables, vigentes en territorio nacional.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                'coverageOfferType': 'SUM_INSURED',
                'requiresAgeCompliance': false,
                'benefitImage':
                    'benefits_per_supplier/CNOC-2022-01-AOPS111000-000/benefitImage.png',
                'pdfWording':
                    'benefits_per_supplier/CNOC-2022-01-AOPS111000-000/pdfWording.pdf',
                'benefit': {
                  'benefitId': 'AOPS111000-000',
                  'name': 'Asistencia Legal Telefónica',
                  'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                },
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
                'cobenefitsPerSupplier': [
                  {
                    'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS111000-001',
                    'wordingZero':
                        '<p>Esta asistencia cubre los servicios de <u>asesoría jurídica telefónica de un profesional en derecho</u> para el socio y sus protegidos (según el plan elegido), cuando se trate de actos, hechos, servicios o productos que se encuentren comprendidos en normativas aplicables, vigentes en territorio nacional, en las materias de: <u>Sucesión</u></p>\n<p>En todos los casos aplican condiciones y exclusiones</p>\n',
                    'coverageOfferType': 'SUM_INSURED',
                    'requiresAgeCompliance': false,
                    'benefitImage':
                        'benefits_per_supplier/CNOC-2022-01-AOPS111000-001/benefitImage.png',
                    'pdfWording':
                        'benefits_per_supplier/CNOC-2022-01-AOPS111000-001/pdfWording.pdf',
                    'benefit': {
                      'benefitId': 'AOPS111000-001',
                      'name': 'Asistencia Legal de Sucesión Telefónica',
                      'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                      'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                      'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                    },
                    'supplier': {
                      'supplierId': 'PCS-2022-01',
                      'folio': 'PCS-2022-01',
                      'personTypeId': 'C',
                      'shortName': 'Seguros Argos',
                      'name': 'Seguros Argos S.A de C.V',
                      'internationalLada': '+52',
                      'phoneNumber': '1234567890',
                      'taxId': 'XAXX010101000'
                    },
                    'benefitType': {'benefitTypeId': 'A', 'name': 'Asistencias'}
                  }
                ],
                'hasCobenefits': true
              },
              {
                'benefitPerSupplierId': 'CNOC-2022-01-AOPS212000-000',
                'wordingZero':
                    '<p>Esta asistencia cubre los servicios de traslado a centro hospitalario del socio y sus protegidos. En caso de que el usuario sufra un accidente o enfermedad que requiera el traslado. Se coordinará el envío de una ambulancia básica terrestre para ser trasladado al nosocomio más cercano de su elección.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
                'coverageOfferType': 'EVENTS',
                'requiresAgeCompliance': false,
                'benefitImage':
                    'benefits_per_supplier/CNOC-2022-01-AOPS212000-000/benefitImage.png',
                'pdfWording':
                    'benefits_per_supplier/CNOC-2022-01-AOPS212000-000/pdfWording.pdf',
                'benefit': {
                  'benefitId': 'AOPS212000-000',
                  'name': 'Ambulancia Terrestre',
                  'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                },
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
                'hasBenefitForm': false,
                'needsBenefitFormSignature': false,
                'userHasAlreadySignedTheBenefitForm': false,
                'hasCobenefits': false
              },
              {
                'benefitPerSupplierId': 'CNOC-2022-01-SOPS311000-000',
                'wordingZero':
                    '<p>Si el socio o sus protegidos (según el plan elegido) durante la vigencia de la póliza a consecuencia de un accidente cubierto y a causa de ello: el asegurado queda incapacitado permanentemente, genera gastos médicos o fallece; la compañía pagará al titular o beneficiario la cantidad de dinero que convino en su póliza.</p>\n<p>En todos los casos aplican exclusiones y condiciones estipuladas en la póliza.</p>\n',
                'coverageOfferType': 'SUM_INSURED',
                'requiresAgeCompliance': false,
                'benefitImage':
                    'benefits_per_supplier/CNOC-2022-01-SOPS311000-000/benefitImage.png',
                'pdfWording':
                    'benefits_per_supplier/CNOC-2022-01-SOPS311000-000/pdfWording.png',
                'benefit': {
                  'benefitId': 'SOPS311000-000',
                  'name': 'Accidentes Personales',
                  'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                  'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                },
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
                'cobenefitsPerSupplier': [
                  {
                    'cobenefitPerSupplierId': 'CNOC-2022-01-SOPS311000-002',
                    'wordingZero':
                        '<p>Suma asegurada: \$300.00 (trescientos/pesos) por día, hasta por 7 días.</p>\n<p>Si el socio o sus protegidos (según el plan elegido) durante la vigencia de la póliza a consecuencia de un accidente cubierto, tuviera que ser internado en un hospital, la compañía pagará al titular su incapacidad.</p>\n<p>En todos los casos aplican exclusiones y condiciones estipuladas en la póliza.</p>\n',
                    'coverageOfferType': 'SUM_INSURED',
                    'requiresAgeCompliance': false,
                    'benefitImage':
                        'benefits_per_supplier/CNOC-2022-01-SOPS311000-002/benefitImage.png',
                    'pdfWording':
                        'benefits_per_supplier/CNOC-2022-01-SOPS311000-002/pdfWording.pdf',
                    'benefit': {
                      'benefitId': 'SOPS311000-002',
                      'name': 'Indemnización Diaria por Hospitalización',
                      'haveGuide': [
                        'Numero de tu membresía PIIX',
                        'Nombre completo de la persona que requiere  el '
                            'beneficio',
                        'Dirección donde te encuentras',
                        'Tu teléfono de contacto'
                      ],
                      'askGuide': [
                        'Número o folio de solicitud',
                        'Nombre y ubicación del hospital destino (en caso de '
                            'tener)'
                      ],
                      'considerGuide': [
                        'Si tu membresía cuenta con seguro de gastos médicos '
                            'indemnizatorios',
                        'Si tu membresía cuenta con seguro de accidentes '
                            'personales'
                      ]
                    },
                    'supplier': {
                      'supplierId': 'PCS-2022-01',
                      'folio': 'PCS-2022-01',
                      'personTypeId': 'C',
                      'shortName': 'Seguros Argos',
                      'name': 'Seguros Argos S.A de C.V',
                      'internationalLada': '+52',
                      'phoneNumber': '1234567890',
                      'taxId': 'XAXX010101000'
                    },
                    'benefitType': {'benefitTypeId': 'S', 'name': 'Seguros'}
                  }
                ],
                'hasCobenefits': true
              }
            ]
          }
        ],
        'membershipBenefits': [
          {
            'benefitPerSupplierId': 'CNOC-2022-01-ZOPS511000-000',
            'wordingZero':
                '<p>Recompensa. Este beneficio otorga al socio y sus protegidos (según el plan seleccionado) acceso a descuentos y servicios a través de una membresía digital MAS DESCUENTOS, los cuales consisten en:</p>\n<ol>\n<li>Alimentos y bebidas</li>\n<li>Salud</li>\n<li>Belleza</li>\n<li>Educación</li>\n<li>Entretenimiento</li>\n<li>Moda y hogar</li>\n<li>Servicios</li>\n<li>Tecnología</li>\n<li>Turismo.</li>\n</ol>\n',
            'hasCobenefits': false,
            'coverageOfferValue': 1493,
            'coverageOfferType': 'SUM_INSURED',
            'benefitName': 'MAS Descuentos Comerciales',
            'benefitId': 'ZOPS511000-000',
            'supplierName': 'Seguros Argos S.A de C.V',
            'supplierId': 'PCS-2022-01'
          },
          {
            'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-003',
            'wordingZero':
                '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: Cerrajería para tu domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
            'coverageOfferValue': 1863,
            'coverageOfferType': 'SUM_INSURED',
            'benefitName': 'Asistencia en el Hogar Cerrajería',
            'benefitId': 'AOPS211000-003',
            'supplierName': 'Seguros Argos S.A de C.V',
            'supplierId': 'PCS-2022-01'
          },
          {
            'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-002',
            'wordingZero':
                '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: Electricista para tu domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
            'coverageOfferValue': 4014,
            'coverageOfferType': 'SUM_INSURED',
            'benefitName': 'Asistencia en el Hogar Electricista',
            'benefitId': 'AOPS211000-002',
            'supplierName': 'Seguros Argos S.A de C.V',
            'supplierId': 'PCS-2022-01'
          },
          {
            'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-001',
            'wordingZero':
                '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: plomería para su domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
            'coverageOfferValue': 510,
            'coverageOfferType': 'SUM_INSURED',
            'benefitName': 'Asistencia en el Hogar Plomería',
            'benefitId': 'AOPS211000-001',
            'supplierName': 'Seguros Argos S.A de C.V',
            'supplierId': 'PCS-2022-01'
          },
          {
            'cobenefitPerSupplierId': 'CNOC-2022-01-SOPS311000-001',
            'wordingZero':
                '<p>Suma asegurada: \$200,000.00 (doscientos mil/pesos).</p>\n<p>Si el socio o sus protegidos (según el plan elegido) a consecuencia de un accidente cubierto, sufriera una pérdida orgánica, dentro de los 90 días de ocurrido el accidente, recibirá un monto indemnizable de acuerdo con la tabla de indemnizaciones Escala B.</p>\n<p>En todos los casos aplican exclusiones y condiciones estipuladas en la póliza.</p>\n',
            'coverageOfferValue': 3813,
            'coverageOfferType': 'EVENTS',
            'benefitName': 'Pérdidas Orgánicas',
            'benefitId': 'SOPS311000-001',
            'supplierName': 'Seguros Argos S.A de C.V',
            'supplierId': 'PCS-2022-01'
          },
          {
            'cobenefitPerSupplierId': 'CNOC-2022-01-XOPS411000-001',
            'wordingZero':
                '<p>Cubre los servicios de víales para los vehículos del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias Viales (según el nivel que seleccione) en caso de requerir servicios de: Grúa por avería.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
            'coverageOfferValue': 3977,
            'coverageOfferType': 'SUM_INSURED',
            'benefitName': 'Grúa por Avería',
            'benefitId': 'XOPS411000-001',
            'supplierName': 'Seguros Argos S.A de C.V',
            'supplierId': 'PCS-2022-01'
          }
        ]
      };

  Map<String, dynamic> get fakeLevelsEmptyJson =>
      {'levelList': [], 'membershipBenefits': []};

  Map<String, dynamic> get fakeLevelQuotationJson => {
        'level': {
          'levelId': 'level2',
          'folio': 'level2',
          'name': 'Silver',
          'pseudonym': 'Nivel 2 del Paquete Asignado.',
          'registerDate': '2022-02-18T21:41:45.000Z',
          'updateDate': '2022-06-28T21:01:07.000Z',
          'productRates': {
            'summedOriginalRiskPremium': 2847,
            'summedRiskPremium': 2381,
            'summedNetPremium': 2339,
            'summedTotalPremium': 2632,
            'marketDiscount': 0.01,
            'volumeDiscount': 0.002,
            'finalDiscount': 0.012,
            'finalTotalPremium': 2600.42,
            'finalNetPremium': 2310.93,
            'finalRiskPremium': 2352.43,
            'finalOriginalRiskPremium': 2812.84,
            'finalTotalDiscountAmount': 31.21,
            'finalMarketDiscountAmount': 26,
            'finalVolumeDiscountAmount': 5.2
          }
        },
        'comparisonInformation': {
          'newBenefits': [
            {
              'benefitPerSupplierId': 'CNOC-2022-01-AOPS111000-000',
              'wordingZero':
                  '<p>Esta asistencia cubre los servicios de asesoría jurídica telefónica de un profesional en derecho para el socio y sus protegidos (según el plan elegido), cuando se trate de actos, hechos, servicios o productos que se encuentren comprendidos en normativas aplicables, vigentes en territorio nacional.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
              'coverageOfferType': 'SUM_INSURED',
              'requiresAgeCompliance': false,
              'benefitImage':
                  'benefits_per_supplier/CNOC-2022-01-AOPS111000-000/benefitImage.png',
              'pdfWording':
                  'benefits_per_supplier/CNOC-2022-01-AOPS111000-000/pdfWording.pdf',
              'benefit': {
                'benefitId': 'AOPS111000-000',
                'name': 'Asistencia Legal Telefónica',
                'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
              },
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
              'cobenefitsPerSupplier': [
                {
                  'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS111000-001',
                  'wordingZero':
                      '<p>Esta asistencia cubre los servicios de <u>asesoría jurídica telefónica de un profesional en derecho</u> para el socio y sus protegidos (según el plan elegido), cuando se trate de actos, hechos, servicios o productos que se encuentren comprendidos en normativas aplicables, vigentes en territorio nacional, en las materias de: <u>Sucesión</u></p>\n<p>En todos los casos aplican condiciones y exclusiones</p>\n',
                  'coverageOfferType': 'SUM_INSURED',
                  'requiresAgeCompliance': false,
                  'benefitImage':
                      'benefits_per_supplier/CNOC-2022-01-AOPS111000-001/benefitImage.png',
                  'pdfWording':
                      'benefits_per_supplier/CNOC-2022-01-AOPS111000-001/pdfWording.pdf',
                  'benefit': {
                    'benefitId': 'AOPS111000-001',
                    'name': 'Asistencia Legal de Sucesión Telefónica',
                    'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                    'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                    'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
                  },
                  'supplier': {
                    'supplierId': 'PCS-2022-01',
                    'folio': 'PCS-2022-01',
                    'personTypeId': 'C',
                    'shortName': 'Seguros Argos',
                    'name': 'Seguros Argos S.A de C.V',
                    'internationalLada': '+52',
                    'phoneNumber': '1234567890',
                    'taxId': 'XAXX010101000'
                  },
                  'benefitType': {'benefitTypeId': 'A', 'name': 'Asistencias'},
                  'coverageOfferValue': 1432
                }
              ],
              'hasCobenefits': true
            },
            {
              'benefitPerSupplierId': 'CNOC-2022-01-AOPS212000-000',
              'benefitFormId':
                  'benefitForm_CNOC-2022-01-AOPS212000-000_CNOC-2022-',
              'wordingZero':
                  '<p>Esta asistencia cubre los servicios de traslado a centro hospitalario del socio y sus protegidos. En caso de que el usuario sufra un accidente o enfermedad que requiera el traslado. Se coordinará el envío de una ambulancia básica terrestre para ser trasladado al nosocomio más cercano de su elección.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
              'coverageOfferType': 'EVENTS',
              'requiresAgeCompliance': false,
              'benefitImage':
                  'benefits_per_supplier/CNOC-2022-01-AOPS212000-000/benefitImage.png',
              'pdfWording':
                  'benefits_per_supplier/CNOC-2022-01-AOPS212000-000/pdfWording.pdf',
              'benefit': {
                'benefitId': 'AOPS212000-000',
                'name': 'Ambulancia Terrestre',
                'haveGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'askGuide': ['Punto 1', 'Punto 2', 'Punto 3'],
                'considerGuide': ['Punto 1', 'Punto 2', 'Punto 3']
              },
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
              'hasBenefitForm': true,
              'needsBenefitFormSignature': false,
              'userHasAlreadySignedTheBenefitForm': false,
              'hasCobenefits': false,
              'coverageOfferValue': 2285
            },
          ],
          'existingAdditionalBenefitsWithCoverageOfferValues': [
            {
              'cobenefitPerSupplierId': 'CNOC-2022-01-AOPS211000-001',
              'wordingZero':
                  '<p>Esta asistencia cubre los servicios de asistencia en el hogar del socio y sus protegidos (según el plan elegido). Un evento al año a elegir para todas las Asistencias del hogar (según el nivel que seleccione) en caso de requerir servicios de: plomería para su domicilio.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n',
              'coverageOfferType': 'SUM_INSURED',
              'newCoverageOfferValue': 3665,
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
              'newCoverageOfferValue': 750,
              'oldCoverageOfferValue': 3813,
              'benefitName': 'Pérdidas Orgánicas',
              'benefitId': 'SOPS311000-001',
              'supplierName': 'Seguros Argos S.A de C.V',
              'supplierId': 'PCS-2022-01'
            },
          ],
          'existingBenefitsAndCobenefitsWithCoverageOfferValues': [
            {
              'benefitPerSupplierId': 'CNOC-2022-01-ZOPS511000-000',
              'wordingZero':
                  '<p>Recompensa. Este beneficio otorga al socio y sus protegidos (según el plan seleccionado) acceso a descuentos y servicios a través de una membresía digital MAS DESCUENTOS, los cuales consisten en:</p>\n<ol>\n<li>Alimentos y bebidas</li>\n<li>Salud</li>\n<li>Belleza</li>\n<li>Educación</li>\n<li>Entretenimiento</li>\n<li>Moda y hogar</li>\n<li>Servicios</li>\n<li>Tecnología</li>\n<li>Turismo.</li>\n</ol>\n',
              'hasCobenefits': false,
              'coverageOfferType': 'SUM_INSURED',
              'newCoverageOfferValue': 2179,
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
              'newCoverageOfferValue': 3770,
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
              'newCoverageOfferValue': 1763,
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
              'newCoverageOfferValue': 2179,
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
              'newCoverageOfferValue': 840,
              'oldCoverageOfferValue': 3813,
              'benefitName': 'Pérdidas Orgánicas',
              'benefitId': 'SOPS311000-001',
              'supplierName': 'Seguros Argos S.A de C.V',
              'supplierId': 'PCS-2022-01'
            },
            {
              'cobenefitPerSupplierId': 'CNOC-2022-01-XOPS411000-001',
              'wordingZero':
                  '<p>Cubre los servicios de víales para los vehículos del '
                      'socio y sus protegidos (según el plan elegido). Un '
                      'evento al año a elegir para todas las Asistencias Viales'
                      ' (según el nivel que seleccione) en caso de requerir '
                      'servicios de: Grúa por avería.</p>\n<p>En todos los '
                      'casos aplican condiciones y exclusiones descritas en la'
                      ' póliza de servicio.</p>\n',
              'coverageOfferType': 'SUM_INSURED',
              'newCoverageOfferValue': 2241,
              'oldCoverageOfferValue': 3977,
              'benefitName': 'Grúa por Avería',
              'benefitId': 'XOPS411000-001',
              'supplierName': 'Seguros Argos S.A de C.V',
              'supplierId': 'PCS-2022-01'
            }
          ]
        },
        'userQuotationId':
            '9f0d00236a48a0bbbe4c4ac609c694cf59e48b700ad2aa6a719d3d17d536d6b8',
        'quotationRegisterDate': '2022-10-19T17:20:35.310Z'
      };
}
