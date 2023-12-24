import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_info_model.dart';

class MembershipInfoApi {
  final appConfig = AppConfig.instance;
  Future<Response> getMembershipInfoApi(
      RequestMembershipInfoModel requestModel) async {
    try {
      final path =
          '${appConfig.backendEndpoint}/membership/main-info?membershipId=${requestModel.membershipId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
