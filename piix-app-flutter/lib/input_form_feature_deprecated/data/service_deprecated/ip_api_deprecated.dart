import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

@Deprecated('Use instead IpRepository')
class IpApiDeprecated {
  @Deprecated('Will be removed in 4.0')
  Future<Response> getIpAddressApi() async {
    try {
      const path = 'https://api.ipify.org';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
