import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';

@Deprecated('Will be removed in 4.0')
class AuthServiceApiDeprecated {
  final appConfig = AppConfig.instance;
  @Deprecated('Will be removed in 4.0')
  Future<Response> sendCredentialApi(AuthUserModel authModel) async {
    try {
      final path = '${appConfig.backendEndpoint}/users/checkCredentials';
      final response = await PiixApiDeprecated.post(
          path: path, data: authModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
  @Deprecated('Will be removed in 4.0')
  Future<Response> sendVerificationCodeApi(AuthUserModel authModel) async {
    try {
      final path = '${appConfig.backendEndpoint}/users/checkVerificationCode';
      final response = await PiixApiDeprecated.post(
          path: path, data: authModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
  @Deprecated('Will be removed in 4.0')
  Future<Response> sendHashableAuthValuesApi(AuthUserModel authModel) async {
    try {
      final path = '${appConfig.backendEndpoint}/users/customToken';
      final response = await PiixApiDeprecated.post(
          path: path, data: authModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
