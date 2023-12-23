import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

class PackageApi {
  final appConfig = AppConfig.instance;
  Future<Response> getAllPackagesApi() async {
    try {
      final path = 'https://${appConfig.backendEndpoint}/package/getAllActive';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
