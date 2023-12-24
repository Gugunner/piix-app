import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

///Acts as a middleware to control path endpoints to call real api services for basic form logic
@Deprecated('Use PersonalInformationFormApi')
class BasicFormApi {
  final appConfig = AppConfig.instance;
  Future<Response> getUserBasicFormApi(
      RequestBasicFormModel requestModel) async {
    try {
      final path =
          '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=basicProtectedForm'
          '&userId=${requestModel.userId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> sendBasicFormApi(
      BasicFormProtectedAnswerModel answerModel) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
      final response =
          await PiixApiDeprecated.put(path: path, data: answerModel.toJson());
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
