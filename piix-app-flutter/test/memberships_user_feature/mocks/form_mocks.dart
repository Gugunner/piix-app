import 'package:piix_mobile/general_app_feature/domain/model/form_item_model.dart';

class FormMocks {
  static List<FormItemModel> mockBasicForm = [
    FormItemModel(
      index: '0',
      fieldName: 'Parentesco',
      response: 'kinship1',
      dataTypeId: 'string',
      id: 'kinshipId',
      required: true,
    ),
    FormItemModel(
      index: '0',
      fieldName: 'Género',
      response: 'gender1',
      dataTypeId: 'string',
      id: 'genderId',
      required: true,
    ),
    FormItemModel(
      index: '0',
      fieldName: 'País',
      response: 'MEX',
      dataTypeId: 'string',
      id: 'countryId',
      required: true,
    ),
    FormItemModel(
      index: '0',
      fieldName: 'Teléfono',
      response: '5555555555',
      dataTypeId: 'phone',
      id: 'phoneNumber',
      required: true,
    ),
    FormItemModel(
      index: '0',
      fieldName: 'Nombres',
      response: 'Michelle Bubbla',
      dataTypeId: 'string',
      id: 'names',
      required: true,
    ),
    FormItemModel(
      index: '0',
      fieldName: 'Apellidos',
      response: 'Bubbla',
      dataTypeId: 'string',
      id: 'lastNames',
      required: true,
    ),
  ];
}
