import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';

abstract interface class IFormRepository {
  ///Returns the [RequestFormModel] of the personal
  ///information form.
  Future<RequestFormModel> getPersonalInformationForm(FormType formType);

  ///Returns the [RequestFormModel] of the personal
  ///documentation form.
  Future<RequestFormModel> getDocumentationForm(FormType formType);

  ///Send a [ResponseFormModel] to create or update
  ///a basic information form.
  Future<void> sendBasicForm(ResponseFormModel responseForm);

}
