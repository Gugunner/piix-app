import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

///Handles all fake request implementations json responses for the basic form repository
extension BasicFormRepositoryUseCaseTest on BasicFormRepository {
  Future<dynamic> getBasicFormRequestedTest(
      RequestBasicFormModel requestModel) async {
    //TODO: Add more use case tests for other BasicFormState values
    return Future.delayed(const Duration(seconds: 2), () {
      if (requestModel.userId.compareTo('cbb3c0b45ccf0871d8bf101c') == 0) {
        return fakeNewBasicFormJson();
      }
      return fakeUpdatedBasicFormJson();
    });
  }

  Future<BasicFormState> sendBasicFormRequestedTest(
      BasicFormProtectedAnswerModel answerModel) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return BasicFormState.sent;
    });
  }

  Map<String, dynamic> fakeNewBasicFormJson() => ({
        'mainUserInfoFormId': 'basicInsuredForm',
        'name': 'Formulario Básico para los Asegurados',
        'registerDate': '2022-02-24T16:26:41.000Z',
        'formFields': [
          {
            'formFieldId': 'birthdate',
            'name': 'Fecha de nacimiento',
            'required': true,
            'dataTypeId': 'date',
            'helperText': 'Debes tener 18 años como mayoria de edad.',
            'defaultValue': '1989-10-27T00:00:00.000Z'
          },
          {
            'formFieldId': 'kinshipId',
            'name': 'Parentesco',
            'isArray': true,
            'isMultiple': false,
            'required': true,
            'dataTypeId': 'string',
            'minLength': 1,
            'maxLength': 100,
            'returnId': true,
            'isEditable': false,
            'defaultValue': 'Individual',
            'values': [
              {
                'valueId': 'kinship1',
                'folio': 'I',
                'name': 'Individual',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'kinship2',
                'folio': 'C',
                'name': 'Conyuge',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'kinship3',
                'folio': 'H',
                'name': 'Hijo/Hija',
                'registerDate': '2022-02-21T19:17:42.000Z'
              },
            ]
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
                'valueId': 'gender1',
                'folio': 'H',
                'name': 'Hombre',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'gender2',
                'folio': 'M',
                'name': 'Mujer',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'gender3',
                'folio': 'O',
                'name': 'Otro',
                'registerDate': '2022-02-21T19:17:42.000Z'
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
            'allRepetitionsAreRequired': false,
            'isEditable': false,
            'returnId': true,
            'defaultValue': 'México',
            'values': [
              {
                'valueId': 'MEX',
                'folio': 'MX',
                'name': 'México',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'AUS',
                'folio': 'AU',
                'name': 'Australia',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'COL',
                'folio': 'CO',
                'name': 'Colombia',
                'registerDate': '2022-02-21T19:17:42.000Z'
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
                'valueId': 'MEXAGS',
                'folio': 'MEXAGS',
                'name': 'Aguascalientes',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'MEXCDMX',
                'folio': 'MEXCDMX',
                'name': 'Ciudad de México',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'MEXMEX',
                'folio': 'MEXMEX',
                'name': 'Mexico',
                'registerDate': '2022-02-21T19:17:42.000Z'
              },
            ],
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Enteros',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'WHOLE',
            'min': 1,
            'max': 9999999
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Decimales',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'DECIMAL',
            'min': 1,
            'max': 9999999
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Porcentajes con enteros',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'WHOLE_PERCENTAGE',
            'min': 1,
            'max': 9999999
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Porcentaje con decimales',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'DECIMAL_PERCENTAGE',
            'min': 1,
            'max': 9999999
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Moneda con enteros',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'WHOLE_CURRENCY',
            'min': 1,
            'max': 9999999
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Moneda con decimales',
            'required': false,
            'dataTypeId': 'number',
            'numberType': 'DECIMAL_CURRENCY',
            'min': 1,
            'max': 9999999
          },
          {
            'formFieldId': 'phoneNumber',
            'name': 'Teléfono',
            'required': true,
            'dataTypeId': 'phone',
            'isEditable': true,
            'defaultValue': '+525566778899'
          },
          {
            'formFieldId': 'email',
            'name': 'Correo electrónico',
            'required': true,
            'dataTypeId': 'string',
            'isEditable': true,
            'defaultValue': 'mich.bubbla@yopmail.com',
          },
        ],
        'state': BasicFormState.retrieved
      });

  Map<String, dynamic> fakeUpdatedBasicFormJson() => ({
        'mainUserInfoFormId': 'basicInsuredForm',
        'name': 'Formulario Básico para los Asegurados',
        'registerDate': '2022-02-24T16:26:41.000Z',
        'formFields': [
          {
            'formFieldId': 'birthdate',
            'name': 'Fecha de nacimiento',
            'required': true,
            'dataTypeId': 'date',
            'helperText': 'Debes tener 18 años como mayoria de edad.',
            'isEditable': false,
            'defaultValue': '1989-10-27T00:00:00.000Z'
          },
          {
            'formFieldId': 'kinshipId',
            'name': 'Parentesco',
            'isArray': true,
            'isMultiple': false,
            'required': true,
            'dataTypeId': 'string',
            'minLength': 1,
            'maxLength': 100,
            'returnId': true,
            'isEditable': false,
            'defaultValue': 'Individual',
            'values': [
              {
                'valueId': 'kinship1',
                'folio': 'I',
                'name': 'Individual',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'kinship2',
                'folio': 'C',
                'name': 'Conyuge',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'kinship3',
                'folio': 'H',
                'name': 'Hijo/Hija',
                'registerDate': '2022-02-21T19:17:42.000Z'
              },
            ]
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
            'defaultValue': 'gender1',
            'values': [
              {
                'valueId': 'gender1',
                'folio': 'H',
                'name': 'Hombre',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'gender2',
                'folio': 'M',
                'name': 'Mujer',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'gender3',
                'folio': 'O',
                'name': 'Otro',
                'registerDate': '2022-02-21T19:17:42.000Z'
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
            'allRepetitionsAreRequired': false,
            'isEditable': false,
            'returnId': true,
            'defaultValue': 'México',
            'values': [
              {
                'valueId': 'MEX',
                'folio': 'MX',
                'name': 'México',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'AUS',
                'folio': 'AU',
                'name': 'Australia',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'COL',
                'folio': 'CO',
                'name': 'Colombia',
                'registerDate': '2022-02-21T19:17:42.000Z'
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
            'defaultValue': 'Aguascalientes',
            'values': [
              {
                'valueId': 'MEXAGS',
                'folio': 'MEXAGS',
                'name': 'Aguascalientes',
                'registerDate': '2022-02-21T19:17:40.000Z'
              },
              {
                'valueId': 'MEXCDMX',
                'folio': 'MEXCDMX',
                'name': 'Ciudad de México',
                'registerDate': '2022-02-21T19:17:41.000Z'
              },
              {
                'valueId': 'MEXMEX',
                'folio': 'MEXMEX',
                'name': 'Mexico',
                'registerDate': '2022-02-21T19:17:42.000Z'
              },
            ],
          },
          {
            'formFieldId': 'zipCode',
            'name': 'Código Postal',
            'required': false,
            'dataTypeId': 'number',
            'min': 1,
            'max': 9999999,
            'defaultValue': '01011'
          },
          {
            'formFieldId': 'phoneNumber',
            'name': 'Teléfono',
            'required': true,
            'dataTypeId': 'phone',
            'isEditable': true,
            'defaultValue': '5566778899'
          },
          {
            'formFieldId': 'email',
            'name': 'Correo electrónico',
            'required': true,
            'dataTypeId': 'string',
            'isEditable': true,
            'defaultValue': 'mich.bubbla@yopmail.com',
          },
        ],
        'state': BasicFormState.retrieved
      });
}
