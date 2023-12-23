// ignore_for_file: prefer_single_quotes

import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_form_model.dart';

///Handles all fake request implementations json responses
///for the benefit form repository
extension BenefitFormRepositoryUseCaseTest on BenefitFormRepositoryDeprecated {
  Future<dynamic> getBenefitFormRequestedTest(
      RequestBenefitFormModel requestModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return fakeBenefitFormJson();
    });
  }

  Map<String, dynamic> fakeBenefitFormJson() => {
        "benefitFormId": "benefitForm_CNC2021-S010101000-000_CNC2021",
        "benefitPerSupplierId": "CNC2021-S010101000-000",
        "name": "Formulario para Accidentes Personales",
        "requiresSignature": true,
        "formFields": [
          {
            "formFieldId": "caption_personal_accidents",
            "dataTypeId": "display",
            "name": "Presentación",
            "defaultValue": "Estimado miembro Piix, es importante llenar "
                "los siguientes campos para poder activar tu"
                "beneficio",
          },
          {
            "formFieldId": "Names",
            "name": "Nombres del asegurado",
            "required": true,
            "dataTypeId": "string",
            "isEditable": true,
            "minLength": 4,
            "maxLength": 80
          },
          {
            "formFieldId": "firstLastName",
            "name": "Primer Apellido del asegurado",
            "required": true,
            "dataTypeId": "string",
            "isEditable": true,
            "minLength": 5,
            "maxLength": 80
          },
          {
            "formFieldId": "secondLastName",
            "name": "Segundo Apellido del asegurado",
            "required": false,
            "dataTypeId": "string",
            "isEditable": false,
            "defaultValue": "Dejar el campo sin llenar",
          },
          {
            "formFieldId": "profession",
            "name": "Ocupación",
            "required": false,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": false,
            "includesOtherOption": true,
            "isEditable": true,
            "values": [
              "Ingeniero",
              "Diseñador",
              "Contador",
              "Abogado",
              "Comercial",
              "Administrador",
              "Otro",
            ]
          },
          {
            "formFieldId": "reason_of_benefit",
            "name": "Razón del beneficio",
            "required": true,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": false,
            "editable": false,
            "defaultValue": "Personal",
            "values": [
              "Personal",
              "Familiar",
              "Pareja",
              "Otro",
            ]
          },
          {
            "formFieldId": "other_insurances",
            "name": "Otros seguros",
            "required": true,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": true,
            "editable": true,
            "maxOptions": 3,
            "values": [
              "Médico",
              "Accidentes",
              "Automotriz",
              "Propiedad",
              "Electrónicos",
              "Mascotas",
              "Otro",
            ]
          },
          {
            "formFieldId": "other_assitanctes",
            "name": "Otras asistencias",
            "required": false,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": true,
            "values": [
              "Médico",
              "Accidentes",
              "Automotriz",
              "Propiedad",
              "Electrónicos",
              "Mascotas",
              "Otro",
            ]
          },
          {
            "formFieldId": "countryId",
            "name": "País",
            "required": true,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": true,
            "includesOtherOption": false,
            "minLength": 1,
            "maxLength": 20,
            'isEditable': true,
            'returnId': true,
            "values": [
              {
                "valueId": "MEX",
                "folio": "MX",
                "name": "México",
                "registerDate": "2022-02-21T19:17:40.000Z"
              },
              {
                "valueId": "AUS",
                "folio": "AU",
                "name": "Australia",
                "registerDate": "2022-02-21T19:17:41.000Z"
              },
              {
                "valueId": "COL",
                "folio": "CO",
                "name": "Colombia",
                "registerDate": "2022-02-21T19:17:42.000Z"
              },
            ],
          },
          {
            "formFieldId": "coverageId",
            "name": "Coberturas",
            "required": false,
            "dataTypeId": "string",
            "isArray": true,
            "isMultiple": true,
            "includesOtherOption": false,
            'isEditable': true,
            'returnId': true,
            "maxOptions": 4,
            "values": [
              {
                "valueId": "001",
                "folio": "001",
                "name": "Colisiones",
                "registerDate": "2022-02-21T19:17:40.000Z"
              },
              {
                "valueId": "002",
                "folio": "002",
                "name": "Muerte accidental",
                "registerDate": "2022-02-21T19:17:41.000Z"
              },
              {
                "valueId": "003",
                "folio": "003",
                "name": "Terceros",
                "registerDate": "2022-02-21T19:17:42.000Z"
              },
              {
                "valueId": "004",
                "folio": "004",
                "name": "Renta de vehiculo",
                "registerDate": "2022-02-21T19:17:42.000Z"
              },
              {
                "valueId": "005",
                "folio": "005",
                "name": "Arrastre",
                "registerDate": "2022-02-21T19:17:42.000Z"
              },
              {
                "valueId": "006",
                "folio": "006",
                "name": "Volcaduras",
                "registerDate": "2022-02-21T19:17:42.000Z"
              },
              {
                "valueId": "007",
                "folio": "008",
                "name": "Vandalismo",
                "registerDate": "2022-02-21T19:17:42.000Z"
              },
            ],
          },
          {
            "formFieldId": "test_single_selection_obj",
            "name": "Selecciona un plan",
            "required": true,
            "dataTypeId": "object",
            "isArray": true,
            "isMultiple": false,
            "includesOtherOption": false,
            'defaultValue': 'Plan básico',
            "values": [
              {
                "characteristics": [
                  'texto largo que explica lo que significa la '
                          'opción A, sus características.' *
                      5,
                ],
                "name": "Plan básico"
              },
              {
                "characteristics": [
                  "Monto ${'\$25,000.00 Monto' * 6} "
                      "Cobertura media",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Monto ${'\$25,000.00 Monto' * 6} ",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas"
                ],
                "name": "Plan intermedio"
              },
              {
                "characteristics": [
                  "Monto \$50,000.00",
                  "Cobertura total",
                  "Incluye llamadas",
                  "Incluye una beneficio extra",
                ],
                "name": "Plan premium"
              },
              {
                "characteristics": [
                  "Monto \$35,000.00",
                  "Cobertura alta",
                  "Incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "No incluye llamadas No incluye llamadas" * 6,
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica",
                  "No incluye llamadas",
                  "Monto \$19,000.00",
                  "Cobertura básica No incluye llamadas No incluye llamadas " *
                      12
                ],
                "name": "Plan avanzado"
              },
            ],
          },
          {
            "formFieldId": "desiredPremium",
            "name": "Prima que desea pagar",
            "required": false,
            "dataTypeId": "number",
            "numberType": "DECIMAL",
            "min": 1,
            "max": 9999999
          },
          {
            "formFieldId": "identification",
            "name": "Identificación oficial",
            "required": true,
            "dataTypeId": "section",
            "childFormFields": [
              {
                "formFieldId": "document",
                "name": "Nombre del documento",
                "required": true,
                "dataTypeId": "string",
                "editable": true,
                "minLength": 1,
                "maxLength": 80
              },
              {
                "formFieldId": "birthdate",
                "name": "Fecha de emision",
                "required": true,
                "dataTypeId": "date",
                "minDate": "1972-10-27T00:00:00.000Z",
                "defaultValue": "1989-10-27T00:00:00.000Z",
                "maxDate": "2022-10-20T00:00:00.000Z"
              },
              {
                "formFieldId": "birthdate",
                "name": "Fecha de expiracion",
                "required": true,
                "dataTypeId": "date",
                "helperText":
                    "Si tu identificación no expira, elije la fecha máxima.",
                "minDate": "1970-10-27T00:00:00.000Z",
                "maxDate": "2099-12-31T00:00:00.000Z"
              },
              {
                "formFieldId": "document",
                "name": "Numero de indentificación",
                "required": true,
                "dataTypeId": "string",
                "helperText":
                    "Ingresa el numero asignado en tu identificación oficial.",
                "editable": true,
                "minLength": 1,
                "maxLength": 80
              },
              {
                "formFieldId": "camara_documents",
                "name": "Fotografia de la identificación oficial",
                "required": true,
                "document": "INE, pasaporte o licencia para conducir vigente",
                "dataTypeId": "camera_documents_picture",
                "minPhotos": 2,
                "maxPhotos": 2,
              },
              {
                "formFieldId": "camara_selfie",
                "name": "Fotografia del Titular",
                "required": true,
                "dataTypeId": "camera_selfie_picture",
                "document": "Por favor tómate una foto con la cámara frontal",
              },
              {
                "formFieldId": "completeName",
                "name": "Firma de conformidad y veracidad de los datos",
                "required": true,
                "dataTypeId": "signedName",
                "signatureType": "SIGNING"
              },
            ]
          },
          {
            "formFieldId": "claim",
            "name": "Siniestro",
            "required": true,
            "dataTypeId": "section",
            "childFormFields": [
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
                'editable': true,
                'returnId': true,
                'defaultValue': 'México',
                "values": [
                  {
                    "valueId": "MEX",
                    "folio": "MX",
                    "name": "México",
                    "registerDate": "2022-02-21T19:17:40.000Z"
                  },
                  {
                    "valueId": "AUS",
                    "folio": "AU",
                    "name": "Australia",
                    "registerDate": "2022-02-21T19:17:41.000Z"
                  },
                  {
                    "valueId": "COL",
                    "folio": "CO",
                    "name": "Colombia",
                    "registerDate": "2022-02-21T19:17:42.000Z"
                  },
                ]
              },
              {
                "formFieldId": "claim_time",
                "name": "Hora del siniestro",
                "required": false,
                "dataTypeId": "time",
                "helperText": "Selecciona la hora y minuto.",
                "minTime": "00:00",
                "maxTime": "23:59"
              },
              {
                "formFieldId": "test_multiple_selections",
                "name": "Tipo de siniestro",
                "required": false,
                "dataTypeId": "string",
                "isArray": true,
                "isMultiple": true,
                "includesOtherOption": true,
                "returnId": false,
                "editable": true,
                "values": [
                  "Colision",
                  "Terremoto",
                  "Inundacion",
                  "Robo",
                  "Accidente",
                  "Homicidio",
                  "Suicidio",
                  "Otro",
                ]
              },
              {
                "formFieldId": "communityNumberPersonsRelated",
                "name": "Número de personas afectadas",
                "required": false,
                "dataTypeId": "number",
                "isDouble": false,
                "isPercentage": false,
                "min": 1,
                "max": 10
              },
              {
                "formFieldId": "completeName",
                "name": "Firma de conformidad y veracidad de los datos",
                "required": true,
                "dataTypeId": "signedName",
                "signatureType": "NAME_AND_PLACE"
              },
            ],
          },
          //
          // {
          //   "formFieldId": "countryId",
          //   "name": "País",
          //   "required": true,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": false,
          //   "minLength": 1,
          //   "maxLength": 20,
          //   'editable': true,
          //   'returnId': true,
          //   "values": [
          //     {
          //       "valueId": "MEX",
          //       "folio": "MX",
          //       "name": "México",
          //       "registerDate": "2022-02-21T19:17:40.000Z"
          //     },
          //     {
          //       "valueId": "AUS",
          //       "folio": "AU",
          //       "name": "Australia",
          //       "registerDate": "2022-02-21T19:17:41.000Z"
          //     },
          //     {
          //       "valueId": "COL",
          //       "folio": "CO",
          //       "name": "Colombia",
          //       "registerDate": "2022-02-21T19:17:42.000Z"
          //     },
          //   ]
          // },
          // {
          //   "formFieldId": "test_multiple_selections",
          //   "name": "Recurrencia de actividad",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": false,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Anual",
          //     "Semestral",
          //     "Trimestral",
          //     "Bimestral",
          //     "Mensual",
          //     "Quincenal",
          //     "Semanal",
          //     "Otro",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Una opcion",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Dos opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Tres opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Cuatro opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Cinco opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Seis opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Siete opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Ocho opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //     "Turística",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Nueve opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //     "Turística",
          //     "Artesanias",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Once opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //     "Turística",
          //     "Artesanias",
          //     "Transporte",
          //     "Infraestructura",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Trece opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //     "Turística",
          //     "Artesanias",
          //     "Transporte",
          //     "Infraestructura",
          //     "Farmacobiólogos",
          //     "Prestación de servicios",
          //   ]
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Veintiseis opciones",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": true,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //     "Turística",
          //     "Artesanias",
          //     "Transporte",
          //     "Infraestructura",
          //     "Farmacobiólogos",
          //     "Prestación de servicios",
          //     "Agroindustria",
          //     "Comercio",
          //     "Servicios Financieros",
          //     "Cultura",
          //     "Aserraderos",
          //     "Servicios de Conservación",
          //     "Materiales para construcción",
          //     "Electromecánica",
          //     "Energía",
          //     "Insumos",
          //     "Maquinaria y equipo",
          //     "Otro",
          //   ]
          // },
          //
          // {
          //   "formFieldId": "users_phone",
          //   "name": "Teléfono",
          //   "required": true,
          //   "dataTypeId": "phone",
          //   "editable": true,
          // },
          // {
          //   "formFieldId": "communityNumberPersonsRelated",
          //   "name": "Número de personas afines a Colectividad",
          //   "required": false,
          //   "dataTypeId": "number",
          //   "isDouble": false,
          //   "isPercentage": false,
          //   "min": 1,
          //   "max": 10
          // },
          // {
          //   "formFieldId": "cnc_economic_activity",
          //   "name": "Tipo de actividad económica a la que se dedica",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": false,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Agrícola",
          //     "Ganadera",
          //     "Acuícola",
          //     "Pesquera",
          //     "Forestal",
          //     "Agroquímicos",
          //     "Minera",
          //     "Turística",
          //     "Artesanias",
          //     "Transporte",
          //     "Infraestructura",
          //     "Farmacobiólogos",
          //     "Prestación de servicios",
          //     "Agroindustria",
          //     "Comercio",
          //     "Servicios Financieros",
          //     "Cultura",
          //     "Aserraderos",
          //     "Servicios de Conservación",
          //     "Materiales para construcción",
          //     "Electromecánica",
          //     "Energía",
          //     "Insumos",
          //     "Maquinaria y equipo",
          //     "Otro",
          //   ]
          // },
          // {
          //   "formFieldId": "camara_selfie",
          //   "name": "Fotografia del Titular",
          //   "required": true,
          //   "dataTypeId": "camera_selfie_picture",
          // },
          // {
          //   "formFieldId": "camara_documents",
          //   "name": "Fotografia del Titular",
          //   "required": true,
          //   "documentName": "pasaporte o INE",
          //   "dataTypeId": "camera_documents_picture",
          //   "minPhotos": 3,
          //   "maxPhotos": 5,
          // },
          //
          //
          // {
          //   "formFieldId": "beneficiary",
          //   "name": "Beneficiario",
          //   "required": true,
          //   "dataTypeId": "section",
          //   "childFormFields": [
          //     {
          //       "formFieldId": "birthdate",
          //       "name": "Fecha de nacimiento",
          //       "required": true,
          //       "dataTypeId": "date",
          //       "helperText": "Debes tener 18 años como mayoria de edad.",
          //       "defaultValue": "1989-10-27T00:00:00.000Z"
          //     },
          //     {
          //       "formFieldId": "zipCode",
          //       "name": "Porcentajes con enteros",
          //       "required": false,
          //       "dataTypeId": "number",
          //       "numberType": "WHOLE_PERCENTAGE",
          //       "min": 1,
          //       "max": 9999999
          //     },
          //     {
          //       "formFieldId": "stateId",
          //       "name": "Tipo de servicio",
          //       "required": false,
          //       "dataTypeId": "string",
          //       "isArray": true,
          //       "isMultiple": false,
          //       "includesOtherOption": false,
          //       "minLength": 1,
          //       "maxLength": 20,
          //       "allRepetitionsAreRequired": false,
          //       'returnId': true,
          //       "values": [
          //         {
          //           "valueId": "ambulance",
          //           "folio": "ambulance",
          //           "name": "Ambulancia",
          //           "registerDate": "2022-02-21T19:17:40.000Z"
          //         },
          //         {
          //           "valueId": "move",
          //           "folio": "move",
          //           "name": "Traslado",
          //           "registerDate": "2022-02-21T19:17:41.000Z"
          //         },
          //         {
          //           "valueId": "assistance",
          //           "folio": "assistance",
          //           "name": "Asistencia telefonica",
          //           "registerDate": "2022-02-21T19:17:42.000Z"
          //         },
          //         {
          //           "valueId": "medical",
          //           "folio": "medical",
          //           "name": "Consulta media a domicilio",
          //           "registerDate": "2022-02-21T19:17:42.000Z"
          //         },
          //       ],
          //     },
          //   ],
          // },
          // {
          //   "formFieldId": "insured_info_main_array",
          //   "name": "Beneficiario",
          //   "defaultValue": "Porcentaje es la parte que le corresponde de ",
          //   "required": true,
          //   "dataTypeId": "main_fields_array",
          //   "allRepetitionsAreRequired": true,
          //   "arrayRepetition": 6,
          //   "secondaryFieldsArray": {
          //     "formFieldId": "insured_info",
          //     "name": "Datos del beneficiario",
          //     "required": false,
          //     "dataTypeId": "secondary_fields_array",
          //     "childFormFields": [
          //       {
          //         "formFieldId": "secondLastName",
          //         "name": "Apellido Materno",
          //         "required": true,
          //         "dataTypeId": "string",
          //         "minLength": 1,
          //         "maxLength": 50
          //       },
          //       {
          //         "formFieldId": "name",
          //         "name": "Nombre",
          //         "required": true,
          //         "dataTypeId": "string",
          //         "minLength": 1,
          //         "maxLength": 100
          //       },
          //       {
          //         "formFieldId": "kinship",
          //         "name": "Parentesco",
          //         "required": true,
          //         "dataTypeId": "string",
          //         "minLength": 1,
          //         "maxLength": 50
          //       },
          //       {
          //         "formFieldId": "firstLastName",
          //         "name": "Apellido Paterno",
          //         "required": true,
          //         "dataTypeId": "string",
          //         "minLength": 1,
          //         "maxLength": 50
          //       },
          //       {
          //         "formFieldId": "cover_percentage",
          //         "name": "Porcentaje a cubrir",
          //         "required": true,
          //         "dataTypeId": "number",
          //         "max": 1
          //       },
          //       {
          //         "formFieldId": "birthdate",
          //         "name": "Fecha de nacimiento",
          //         "required": false,
          //         "dataTypeId": "date"
          //       }
          //     ]
          //   }
          // },
          // {
          //   "formFieldId": "signedDate",
          //   "name": "Fecha en la que se firmó",
          //   "required": false,
          //   "dataTypeId": "date"
          // },
          // {
          //   "formFieldId": "signedHour",
          //   "name": "Hora en la que se firmó",
          //   "required": false,
          //   "dataTypeId": "time"
          // },
          // {
          //   "formFieldId": "signedIP",
          //   "name": "IP desde la que se firmó",
          //   "required": false,
          //   "dataTypeId": "string"
          // },
          // {
          //   "formFieldId": "geolocalization",
          //   "name": "Geolocalización en la que se firmó",
          //   "required": false,
          //   "dataTypeId": "location"
          // },
          // {
          //   "formFieldId": "todays_date",
          //   "name": "Fecha de Hoy",
          //   "required": true,
          //   "dataTypeId": "date"
          // },
          // {
          //   "formFieldId": "zipCode",
          //   "name": "Enteros",
          //   "required": false,
          //   "dataTypeId": "number",
          //   "numberType": "WHOLE",
          //   "min": 1,
          //   "max": 9999999
          // },

          // {
          //   "formFieldId": "coverageInsuredSum",
          //   "name": "Suma Asegurada por Cobertura",
          //   "required": false,
          //   "dataTypeId": "number",
          //   "numberType": "DECIMAL_CURRENCY",
          //   "isEditable": true,
          //   "min": 1,
          //   "max": 9999999
          // },
          // {
          //   "formFieldId": "birthdate",
          //   "name": "Fecha de nacimiento",
          //   "required": true,
          //   "dataTypeId": "date",
          //   "helperText": "Debes tener 18 años como mayoria de edad.",
          //   "defaultValue": "1989-10-27T00:00:00.000Z"
          // },
          // {
          //   "formFieldId": "test_multiple_selections",
          //   "name": "Recurrencia de actividad",
          //   "required": false,
          //   "dataTypeId": "string",
          //   "isArray": true,
          //   "isMultiple": false,
          //   "includesOtherOption": true,
          //   "returnId": false,
          //   "editable": true,
          //   "values": [
          //     "Anual",
          //     "Semestral",
          //     "Trimestral",
          //     "Bimestral",
          //     "Mensual",
          //     "Quincenal",
          //     "Semanal",
          //     "Otro",
          //   ]
          // },
          // {
          //   "formFieldId": "test_single_selection_obj",
          //   "name": "Selección un plan",
          //   "required": false,
          //   "dataTypeId": "object",
          //   "isArray": true,
          //   "isMultiple": false,
          //   "includesOtherOption": false,
          //   'defaultValue': 'Plan básico',
          //   "values": [
          //     {
          //       "characteristics": [
          //         'texto largo que explica lo que significa la '
          //'opción A, sus características. '
          //             'texto largo que explica lo que significa '
          //'la opción A, sus características. '
          //             'texto largo que explica lo que significa '
          //'la opción A, sus características. '
          //             'texto largo que explica lo que significa '
          //'la opción A, sus características. '
          //             'texto largo que explica lo que significa '
          //'la opción A, sus características. '
          //             'texto largo que explica lo que significa '
          //'la opción A, sus características. '
          //             'texto largo que explica lo que significa '
          //'la opción A, sus características. ',
          //       ],
          //       "name": "Plan básico"
          //     },
          //     {
          //       "characteristics": [
          //         "Monto \$25,000.00 Monto \$25,000.00 Monto \$25,000.00 Monto \$25,000.00 Monto \$25,000.00"
          //             "Monto \$25,000.00",
          //         "Cobertura media",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica Monto \$25,000.00 Monto \$25,000.00 Monto \$25,000.00 Monto \$25,000.00 Monto \$25,000.00"
          //             "Monto \$25,000.00",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas"
          //       ],
          //       "name": "Plan intermedio"
          //     },
          //     {
          //       "characteristics": [
          //         "Monto \$50,000.00",
          //         "Cobertura total",
          //         "Incluye llamadas",
          //         "Incluye una beneficio extra",
          //       ],
          //       "name": "Plan premium"
          //     },
          //     {
          //       "characteristics": [
          //         "Monto \$35,000.00",
          //         "Cobertura alta",
          //         "Incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "No incluye llamadas No incluye llamadas  '
          //'No incluye llamadas No incluye llamadas"
          //             "No incluye llamadas"
          //             "No incluye llamadas No incluye llamadas '
          //'No incluye llamadas"
          //             "No incluye llamadas No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica",
          //         "No incluye llamadas",
          //         "Monto \$19,000.00",
          //         "Cobertura básica No incluye llamadas No incluye llamadas '
          //'No incluye llamadas No incluye llamadas No incluye llamadas"
          //             "No incluye llamadas No incluye llamadas No incluye '
          //'llamadas No incluye llamadas No incluye llamadas '
          //'No incluye llamadas"
          //             "No incluye llamadas No incluye llamadas No incluye '
          //'llamadas No incluye llamadas No incluye llamadas '
          //'No incluye llamadas",
          //         "No incluye llamadas"
          //       ],
          //       "name": "Plan avanzado"
          //     },
          //   ],
          // },
          // {
          //   "formFieldId": "completeName",
          //   "name": "Nombre Completo",
          //   "required": true,
          //   "dataTypeId": "signedName",
          //   "signatureType": "SIGNING"
          // },
          // {
          //   "formFieldId": "completeName",
          //   "name": "Lugar y Fecha",
          //   "required": true,
          //   "dataTypeId": "signedName",
          //   "signatureType": "NAME_AND_PLACE",
          // },
        ],
        "state": BenefitFormStateDeprecated.retrieved,
      };

  Future<dynamic> sendBenefitFormRequestedTest() async {
    return BenefitFormStateDeprecated.sent;
  }

  Map<String, dynamic> fakeSendBenefitFormResponse() => {
        "packageId": "CNOC-2022-01",
        "benefitFormId": "benefitForm_CNC2021-S010101000-000_CNC2021",
        "benefitPerSupplierId": "CNC2021-S010101000-000",
        "userId": "180f430b70b2c4ad85f058a6",
        "answers": [
          {
            "formFieldId": "secondLastName",
            "dataTypeId": "string",
            "name": "Segundo Apellido del asegurado",
            "isOtherOption": false,
            "answer": "Dejar el campo sin llenar"
          },
          {
            "formFieldId": "signedIP",
            "dataTypeId": "string",
            "name": "IP",
            "isOtherOption": false,
            "answer": "lingus009@gmail.com"
          },
          {
            "formFieldId": "signedScreenshot",
            "dataTypeId": "string",
            "name": "Screenshot",
            "isOtherOption": false,
            "answer":
                "packages/CNOC-2022-01/userBenefitForms/benefitForm_CNC2021-S010101000-000_CNC2021/180f430b70b2c4ad85f058a6/2022-12-13/legally-screen-shot/.png"
          },
          {
            "formFieldId": "signedGeolocalization",
            "dataTypeId": "location",
            "name": "Ubicación",
            "isOtherOption": false,
            "answer": "19.3215204, -99.078228"
          },
          {
            "formFieldId": "signedHour",
            "dataTypeId": "time",
            "name": "Hora",
            "isOtherOption": false,
            "answer": "14:08:54"
          },
          {
            "formFieldId": "signedDate",
            "dataTypeId": "date",
            "name": "Fecha",
            "isOtherOption": false,
            "answer": "2022-12-13T14:08:54.290624"
          }
        ]
      };
}
