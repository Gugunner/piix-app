import 'package:dio/dio.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/request_benefit_per_supplier_model.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

///Acts as a middleware to control path endpoints to call real
///api services for benefit per supplier logic
class BenefitPerSupplierApi {
  final appConfig = AppConfig.instance;
  Future<Response> getBenefitPerSupplierApi(
      RequestBenefitPerSupplierModel requestModel) async {
    try {
      final path = '${appConfig.backendEndpoint}/package/supplier/benefit?'
          'benefitPerSupplierId=${requestModel.benefitPerSupplierId}'
          '&userId=${requestModel.userId}'
          '&membershipId=${requestModel.membershipId}';
      final response = await PiixApiDeprecated.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
