import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

class ProtectedFormApi {
  final appConfig = AppConfig.instance;

  Future<Response> getProtectedRegisterFormApi({
    required String membershipId,
  }) async {
    try {
      final path =
          '${appConfig.catalogEndpoint}/mainUserForms?mainUserInfoFormId=basicProtectedForm&membershipId=$membershipId';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
