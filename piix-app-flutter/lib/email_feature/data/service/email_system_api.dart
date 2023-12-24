import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/email_feature/domain/model/request_email_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

class EmailSystemApi {
  final appConfig = AppConfig.instance;
  Future<Response> sendEmailApi(RequestEmailModel requestEmail) async {
    try {
      final path =
          'https://${appConfig.backendEndpoint}/users/benefitForms/email/attachment';
      final response =
          await PiixApiDeprecated.post(path: path, data: requestEmail.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
