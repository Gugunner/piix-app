import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/request_available_protected_model.dart';

class ProtectedApi {
  final appConfig = AppConfig.instance;

  Future<Response> getAvailableProtectedApi({
    required RequestAvailableProtectedModel requestModel,
  }) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/protected/slots/byMembership?membershipId=${requestModel.membershipId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
