import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_form_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

///Acts as a middleware to control path endpoints to call
///real api services for benefit form logic
class BenefitFormApi {
  final appConfig = AppConfig.instance;
  Future<Response> getBenefitFormApi(
      RequestBenefitFormModel requestModel) async {
    try {
      final path =
          'https://${appConfig.backendEndpoint}/benefitForms?benefitFormId=${requestModel.benefitFormId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> sendBenefitFormApi(
      BenefitFormAnswerModel answerModel) async {
    try {
      final path = 'https://${appConfig.backendEndpoint}/user/benefitForms';
      final response =
          await PiixApiDeprecated.post(path: path, data: answerModel.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
