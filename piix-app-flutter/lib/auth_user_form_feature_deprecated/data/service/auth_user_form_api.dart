import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/auth_user_form_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/domain/model/basic_form_model.dart';

class AuthUserFormApi {
  final appConfig = AppConfig.instance;

  Future<Response> _getAuthUserFormApi(AuthUserFormModel formModel) async {
    try {
      final path =
          '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=${formModel.mainUserInfoFormId}'
          '&userId=${formModel.userId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _sendAuthUserFormApi(
      BasicFormAnswerModel answerModel) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/user/mainForms/basicInformation';
      final response = await PiixApiDeprecated.put(
        path: path,
        data: answerModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getPersonalInformationFormApi(
          AuthUserFormModel formModel) async =>
      _getAuthUserFormApi(formModel);

  Future<Response> getDocumentationFormApi(AuthUserFormModel formModel) async =>
      _getAuthUserFormApi(formModel);

  Future<Response> sendPersonalInformationFormApi(
          BasicFormAnswerModel answerModel) async =>
      _sendAuthUserFormApi(answerModel);

  Future<Response> sendDocumentationFormApi(
    BasicFormAnswerModel answerModel,
  ) async =>
      _sendAuthUserFormApi(answerModel);

  Future<Response> sendProtectedRegisterFormApi(
          BasicFormAnswerModel answerModel) async =>
      _sendAuthUserFormApi(answerModel);

  Future<Response> startMembershipVerificationApi() async {
    try {
      final path = '${appConfig.backendEndpoint}/user/mainForms/confirm';
      final response = await PiixApiDeprecated.post(
        path: path,
        data: {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
