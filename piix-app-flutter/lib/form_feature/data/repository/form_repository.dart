import 'package:dio/dio.dart';
import 'package:piix_mobile/form_feature/data/repository/iform_repository.dart';
import 'package:piix_mobile/form_feature/domain/model/request_form_model.dart';
import 'package:piix_mobile/form_feature/domain/model/response_form_model.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final class FormRepository
    with RepositoryAuxiliaries
    implements IFormRepository {
  @override
  Future<RequestFormModel> getDocumentationForm(FormType formType) async {
    final path = '${EndPoints.getDocumentationFormEndpoint}'
        '&formType=${formType.name}';
    final response = await dio.get(path);
    if (response.data == null) {
      throw Exception('There is no data in the response');
    }
    return RequestFormModel.fromJson(response.data);
  }

  @override
  Future<RequestFormModel> getPersonalInformationForm(FormType formType) async {
    final path = '${EndPoints.getPersonalInformationFormEndpoint}'
        '&formType=${formType.name}';
    final response = await dio.get(path);
    if (response.data == null) {
      throw Exception('There is no data in the response');
    }
    return RequestFormModel.fromJson(response.data);
  }

  @override
  Future<dynamic> sendBasicForm(
    ResponseFormModel formModel,
  ) async {
    final path = EndPoints.sendBasicInformationFormEndpoint;
    final jsonFormModel = formModel.toCustomJson();
    return dio.put(path, data: jsonFormModel);
  }

  ///Sends a confirmation request to lock user
  ///personal information and documentation form.
  Future<Response> confirmUserMainForms() async {
    final path = EndPoints.confirmUserMainForms;
    return dio.post(path);
  }
}

//Declare a simple Riverpod Provider that can modify the repository
final formRepositoryPod = Provider<IFormRepository>((ref) => FormRepository());
