// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_per_supplier_repository.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/request_benefit_per_supplier_model.dart';

extension BenefitPerSupplierUseCaseTest
    on BenefitPerSupplierRepositoryDeprecated {
  Future<dynamic> getBenefitPerSupplierRequestedTest(
      RequestBenefitPerSupplierModel requestModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return fakeBenefitPerSupplierJson(requestModel.benefitPerSupplierId);
    });
  }

  Map<String, dynamic> fakeBenefitPerSupplierJson(String benefitPerSupplierId) {
    if (benefitPerSupplierId.compareTo('OpsPaqueteEnrique-Z900204000-000') ==
        0) {
      return <String, dynamic>{
        "benefitPerSupplierId": "OpsPaqueteEnrique-Z900204000-000",
        "benefitFormId": "FormularioOps-07",
        "wordingZero":
            "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido)</p>\n",
        "wordingOne":
            "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caos de requerir los siguientes servicios para sus equipos de computo o celulares.\nDescarga de aplicaciones (android o ios); Dudas de hardware; respaldo de contactos. Configuración de mail (yahoo, hotmail, gmail o icloud); Configuración de móvil: Wifi; Antivirus; Recuperación de datos y Sincronización smartwatch/software.</p>\n",
        "wordingTwo":
            "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caos de requerir los siguientes servicios para sus equipos de computo o celulares.</p>\n<p><strong>I. DESCARGA DE APLICACIONES.</strong></p>\n<p>Se proporcionará asesoría a través de una llamada telefónica para poder descargar aplicaciones gratuitas, considerando el sistema operativo que tenga el Titular (Android o iOS).</p>\n<p><strong>II. DUDAS DE HARDWARE.</",
        "requiresAgeCompliance": false,
        "benefitImage":
            "benefits_per_supplier/OpsPaqueteEnrique-Z900204000-000/benefitImage.png",
        "pdfWording":
            "benefits_per_supplier/OpsPaqueteEnrique-Z900204000-000/pdfWording.pdf",
        "benefit": {
          "benefitId": "Z900204000-000",
          "name": "Beneficio de Recompensas Ops 4",
          "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
          "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
          "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
        },
        "benefitType": {"benefitTypeId": "Z", "name": "Recompensas"},
        "supplier": {
          "supplierId": "OPSProveedoprueba",
          "folio": "OPSProveedoprueba",
          "personTypeId": "C",
          "shortName": "Enrique OPS",
          "name": "Enrique",
          "internationalLada": "+52",
          "phoneNumber": "2711260651",
          "taxId": "MAPE960218CS7",
          "logo": "suppliers/OPSProveedoprueba/logo.png"
        },
        "cobenefitsPerSupplier": [
          {
            "cobenefitPerSupplierId": "OpsPaqueteEnrique-Z900204000-002",
            "wordingZero":
                "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido)</p>\n",
            "wordingOne":
                "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de computo o celulares.\nRecuperación de datos. Se asesorará para darle a conocer si hubo un respaldo previo, ya sea de contactos, imágenes, videos, archivos y/o correo.\nEn todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n",
            "wordingTwo":
                "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de computo o celulares.<br>\n<strong>RECUPERACIÓN DE DATOS.</strong>\nSe asesorará al Titular para darle a conocer si hubo un respaldo previo, ya sea de contactos, imágenes, videos, archivos y/o correo.<br>\n<strong>Exclusiones:</strong></p>\n<ul>\n<li>Para los dispositivos móviles con sistema operativo iO",
            "requiresAgeCompliance": false,
            "benefitImage":
                "benefits_per_supplier/OpsPaqueteEnrique-Z900204000-002/benefitImage.png",
            "pdfWording":
                "benefits_per_supplier/OpsPaqueteEnrique-Z900204000-002/pdfWording.pdf",
            "benefit": {
              "benefitId": "Z900204000-002",
              "name": "CoBeneficio de Recompensas Ops 4.2 Prueba",
              "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
            },
            "benefitType": {"benefitTypeId": "Z", "name": "Recompensas"},
            'coverageOfferType': 'event',
            "hasBenefitForm": false,
            "needsBenefitFormSignature": false,
            "userHasAlreadySignedTheBenefitForm": false
          },
          {
            "cobenefitPerSupplierId": "OpsPaqueteEnrique-Z900204000-001",
            "wordingZero":
                "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido)</p>\n",
            "wordingOne":
                "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de computo o celulares.\nSincronización smartwatch/software. Se brindará asesoría relacionada a la conexión vía bluetooth entre el smartwatch y el smartphone.\nEn todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio</p>\n",
            "wordingTwo":
                "<p>Esta asistencia cubre los <u>servicios de asesoría tecnológica telefónica para el socio y sus protegidos</u> (según el plan elegido) en caso de requerir los siguientes servicios para sus equipos de computo o celulares.<br>\n<strong>SINCRONIZACIÓN SMARTWATCH/SOFTWARE</strong>\nSe brindará asesoría relacionada a la conexión vía bluetooth entre el smartwatch y el smartphone del Titular.<br>\n<strong>Exclusiones:</strong></p>\n<ul>\n<li>Para los dispositivos móviles con sistema operativo iOS, es neces",
            "requiresAgeCompliance": false,
            "benefitImage":
                "benefits_per_supplier/OpsPaqueteEnrique-Z900204000-001/benefitImage.png",
            "pdfWording":
                "benefits_per_supplier/OpsPaqueteEnrique-Z900204000-001/pdfWording.pdf",
            "benefit": {
              "benefitId": "Z900204000-001",
              "name": "CoBeneficio de Recompensas Ops 4.1",
              "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
              "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
            },
            "benefitType": {"benefitTypeId": "Z", "name": "Recompensas"},
            'coverageOfferType': 'event',
            "hasBenefitForm": false,
            "needsBenefitFormSignature": false,
            "userHasAlreadySignedTheBenefitForm": false
          }
        ],
        "hasCobenefits": true,
        'state': BenefitPerSupplierStateDeprecated.retrieved,
      };
    }
    return <String, dynamic>{
      "benefitPerSupplierId": "Preview123-A020520000-000",
      "wordingZero":
          "<p>Esta asistencia cubre los servicios de asesoría jurídica telefónica de un profesional en derecho para el socio y sus protegidos (según el plan elegido), cuando se trate de actos, hechos, servicios o productos que se encuentren comprendidos en normativas aplicables, vigentes en territorio nacional.</p>\n<p>En todos los casos aplican condiciones y exclusiones descritas en la póliza de servicio.</p>\n",
      "requiresAgeCompliance": false,
      "pdfWording":
          "benefits_per_supplier/Preview123-A020520000-000/pdfWording.pdf",
      "benefit": {
        "benefitId": "A020520000-000",
        "name": "Antígeno Prostático",
        "haveGuide": ["Punto 1", "Punto 2", "Punto 3"],
        "askGuide": ["Punto 1", "Punto 2", "Punto 3"],
        "considerGuide": ["Punto 1", "Punto 2", "Punto 3"]
      },
      "benefitType": {"benefitTypeId": "A", "name": "Asistencias"},
      "supplier": {
        "supplierId": "PL-0705",
        "folio": "PL-0705",
        "personTypeId": "C",
        "shortName": "AXA Salud",
        "name": "AXA Salud, S.A. de C.V.",
        "internationalLada": "52",
        "phoneNumber": "1234567890",
        "taxId": "FALTA RFC"
      },
      "hasBenefitForm": false,
      "needsBenefitFormSignature": false,
      "userHasAlreadySignedTheBenefitForm": false,
      "hasCobenefits": false,
      'state': BenefitPerSupplierStateDeprecated.retrieved,
    };
  }
}
