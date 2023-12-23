import 'package:piix_mobile/auth_user_form_feature_deprecated/data/repository/auth_user_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

extension AuthUserFormRepositoryTest on AuthUserFormRepository {
  Future<dynamic> getPersonalInformationFormRequestedTest(
      AuthUserFormModel formModel) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => fakePersonalInformationForm(),
    );
  }

  Future<AuthUserFormState> sendPersonalInformationFormRequestedTest(
      BasicFormAnswerModel answerModel) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthUserFormState.sent,
    );
  }

  Map<String, dynamic> fakePersonalInformationForm() => {
        'mainUserInfoFormId': 'basicInsuredForm',
        'name': 'Formulario de informacion personal',
        'registerDate': '2022-12-05T16:26:41.000Z',
        'formFields': [
          {
            'formFieldId': 'name',
            'name': 'Primer Nombre',
            'required': true,
            'dataTypeId': 'string',
            'isEditable': true,
          },
          {
            'formFieldId': 'middleName',
            'name': 'Segundo Nombre',
            'required': false,
            'dataTypeId': 'string',
            'isEditable': true,
          },
          {
            'formFieldId': 'firstLastName',
            'name': 'Primer Apellido',
            'required': true,
            'dataTypeId': 'string',
            'isEditable': true,
          },
          {
            'formFieldId': 'secondLastName',
            'name': 'Segundo Apellido',
            'required': false,
            'dataTypeId': 'string',
            'isEditable': true,
          },
          {
            'formFieldId': 'phoneNumber',
            'name': 'Teléfono',
            'required': true,
            'dataTypeId': 'phone',
            'editable': true,
            'minLength': 10,
            'helperText': 'Este teléfono puedes usarlo como '
                'otro metodo de acceso a la aplicación'
          },
          {
            'formFieldId': 'email',
            'name': 'Correo electrónico',
            'required': true,
            'dataTypeId': 'string',
            'isEditable': true,
            'helperText': 'Este correo puedes usarlo como '
                'otro metodo de acceso a la aplicación',
          },
          {
            'formFieldId': 'birthdate',
            'name': 'Fecha de nacimiento',
            'required': true,
            'dataTypeId': 'date',
            'isEditable': true,
          },
          {
            'formFieldId': 'genderId',
            'name': 'Género',
            'isArray': true,
            'isMultiple': false,
            'required': true,
            'dataTypeId': 'string',
            'minLength': 1,
            'maxLength': 100,
            'returnId': true,
            'values': [
              {
                'genderId': 'gender1',
                'folio': 'H',
                'name': 'Hombre',
              },
              {
                'genderId': 'gender2',
                'folio': 'M',
                'name': 'Mujer',
              },
              {
                'genderId': 'gender3',
                'folio': 'O',
                'name': 'Otro',
              },
            ]
          },
          {
            'formFieldId': 'countryId',
            'name': 'País',
            'required': true,
            'dataTypeId': 'string',
            'isArray': true,
            'isMultiple': false,
            'includesOtherOption': false,
            'minLength': 1,
            'maxLength': 20,
            'isEditable': false,
            'returnId': true,
            'defaultValue': 'México',
            'values': [
              {
                'countryId': 'MEX',
                'folio': 'MX',
                'name': 'México',
              },
              {
                'countryId': 'COL',
                'folio': 'CO',
                'name': 'Colombia',
              },
              {
                'countryId': 'USA',
                'folio': 'US',
                'name': 'Estados Unidos',
              },
            ]
          },
          {
            'formFieldId': 'stateId',
            'name': 'Estado',
            'required': true,
            'dataTypeId': 'string',
            'isArray': true,
            'isMultiple': false,
            'includesOtherOption': false,
            'minLength': 1,
            'maxLength': 20,
            'allRepetitionsAreRequired': false,
            'returnId': true,
            'values': [
              {
                'stateId': 'MEXCDMX',
                'folio': 'MEXCDMX',
                'name': 'Ciudad de México',
              },
              {
                'stateId': 'MEXCHI',
                'folio': 'MEXCHI',
                'name': 'Chihuahua',
              },
              {
                'stateId': 'MEXAGS',
                'folio': 'MEXAGS',
                'name': 'Aguas Calientes',
              },
            ],
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Código Postal',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'WHOLE',
            'min': 1,
            'max': 99999
          },
          {
            'formFieldId': 'planId',
            'name': 'Plan',
            'required': true,
            'dataTypeId': 'string',
            'minLength': 1,
            'maxLength': 100,
            'isEditable': true,
            'values': [
              {
                'valueId': 'e9dfd96fd383215ba2da696ff9dc9c10e011a5673af85bd39d',
                'folio': 'plan-1',
                'name': 'Individual',
                'registerDate': '2022-07-14T15:38:18.000Z'
              },
              {
                'valueId': 'cdf8ef67d17c0b0c07f5eda9ff32acdaedadc73ccc77fec8eb',
                'folio': 'PLN001',
                'name': 'TITULAR de 0 a 17 ANOS',
                'registerDate': '2023-01-03T15:29:40.000Z'
              },
              {
                'valueId': '193961dd198c192802fff752e3258c620841e2aa855c680dd0',
                'folio': 'PLN002',
                'name': 'TITULAR de 18 a 24 ANOS',
                'registerDate': '2023-01-03T15:30:00.000Z'
              },
              {
                'valueId': '85d7cda18a85c11c410776cc78758c7ce55714d7ec3efb5a62',
                'folio': 'PLN003',
                'name': 'TITULAR de 25 a 30 ANOS',
                'registerDate': '2023-01-03T15:30:14.000Z'
              },
              {
                'valueId': 'f5d13717cb6d79f056494f2b6c93afcc638942b83fee0a549f',
                'folio': 'PLN004',
                'name': 'TITULAR de 31 a 40 ANOS',
                'registerDate': '2023-01-03T15:30:33.000Z'
              },
              {
                'valueId': 'cc8cb4faa79e56711a6102af16bdd3b76f38dbcbeef6eb3a00',
                'folio': 'PLN005',
                'name': 'TITULAR de 41 a 50 ANOS',
                'registerDate': '2023-01-03T15:30:48.000Z'
              },
              {
                'valueId': '33afad8cbe553bd17cd6b19737eaf7f7e10708513f97960f9d',
                'folio': 'PLN006',
                'name': 'TITULAR de 51 a 60 ANOS',
                'registerDate': '2023-01-03T15:31:04.000Z'
              }
            ],
            'isArray': true,
            'isMultiple': false,
            'returnId': true
          }
        ],
        'state': AuthUserFormState.retrieved,
      };

  Future<dynamic> getDocumentationFormRequestedTest(
      AuthUserFormModel formModel) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => fakeDocumentationForm(),
    );
  }

  Future<AuthUserFormState> sendDocumentationFormRequestedTest(
      BasicFormAnswerModel answerModel) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthUserFormState.sent,
    );
  }

  Map<String, dynamic> fakeDocumentationForm() => {
        'mainUserInfoFormId': 'userDocumentationForm',
        'name': 'Formulario de documentación',
        'registerDate': '2022-12-12T16:26:41.000Z',
        'formFields': [
          {
            'formFieldId': 'communityTypeId',
            'name': 'Tipo de Comunidad',
            'isArray': true,
            'isMultiple': false,
            'required': true,
            'dataTypeId': 'string',
            'minLength': 1,
            'maxLength': 100,
            'returnId': true,
            'values': [
              {
                'valueId': 'localGovernment',
                'folio': 'L',
                'name': 'Ayuntamiento',
              },
              {
                'valueId': 'enterprise',
                'folio': 'E',
                'name': 'Corporativo',
              },
              {
                'valueId': 'association',
                'folio': 'A',
                'name': 'Asociación',
              },
              {
                'valueId': 'congregation',
                'folio': 'C',
                'name': 'Congregación',
              },
              {
                'valueId': 'union',
                'folio': 'U',
                'name': 'Sindicato',
              },
            ],
          },
          {
            'formFieldId': 'documentation',
            'name': 'Fotografias de la documentación',
            'required': true,
            'document': '',
            'dataTypeId': 'camera_documents_picture',
            'minPhotos': 1,
            'maxPhotos': 5,
          },
          {
            'formFieldId': 'packageId',
            'name': 'Nombre de la Comunidad',
            'isArray': true,
            'isMultiple': false,
            'required': true,
            'dataTypeId': 'string',
            'minLength': 1,
            'maxLength': 100,
            'returnId': true,
            'relatedFormFieldId': 'communityTypeId',
            'values': [
              {
                'valueId': 'PACKAGE1',
                'folio': 'PACKAGE1',
                'typeId': 'localGovernment',
                'name': 'Municipio de Valladolid',
              },
              {
                'valueId': 'PACKAGE2',
                'folio': 'PACKAGE2',
                'typeId': 'association',
                'name': 'Federacion de Transportistas',
              },
              {
                'valueId': 'PACKAGE3',
                'folio': 'PACKAGE3',
                'typeId': 'enterprise',
                'name': 'Boutique Plaza SA de CV',
              },
              {
                'valueId': 'PACKAGE4',
                'folio': 'PACKAGE4',
                'typeId': 'congregation',
                'name': 'Congregación de pastores por México',
              },
              {
                'valueId': 'PACKAGE5',
                'folio': 'PACKAGE5',
                'typeId': 'union',
                'name': 'Trabajadores de la educación',
              },
            ],
          },
          {
            'formFieldId': 'uniqueId',
            'name': 'Numero de identificación',
            'required': true,
            'dataTypeId': 'string',
            'isEditable': true,
          },
        ],
        'state': AuthUserFormState.retrieved,
      };

  Future<AuthUserFormState> sendProtectedRegisterFormRequestedTest(
      BasicFormAnswerModel answerModel) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthUserFormState.sent,
    );
  }

  Future<AuthUserFormState> startMembershipVerificationRequestedTes() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => AuthUserFormState.sent,
    );
  }
}
