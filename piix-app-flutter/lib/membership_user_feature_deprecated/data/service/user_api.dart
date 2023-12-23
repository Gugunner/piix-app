import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/user_credential_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/endpoints.dart';
import 'package:piix_mobile/user_profile_feature/domain/model/update_credential_model.dart';

//TODO: Add documentation
class UserApi {
  final appConfig = AppConfig.instance;
  Future<Response> getUserByEmailApi(
      UserCredentialModel credentialModel) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/users/email?email=${Uri.encodeComponent(credentialModel.usernameCredential)}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserByPhoneApi(
      UserCredentialModel credentialModel) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/users/phone?phone=${credentialModel.usernameCredential}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserLevelAndPlansApi() async {
    try {
      final path =
          '${appConfig.backendEndpoint}/users/getPlanAndLevelForMemberships';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserEmailApi(
      UpdateEmailRequestModel requestModel) async {
    try {
      final path = PiixAppEndpoints.updateUserEmailEndpoint;
      final response =
          await PiixApiDeprecated.put(path: path, data: requestModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserPhoneNumberApi(
    UpdatePhoneNumberRequestModel requestModel,
  ) async {
    try {
      final path = PiixAppEndpoints.updateUserPhoneNumberEndpoint;
      final response =
          await PiixApiDeprecated.put(path: path, data: requestModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
