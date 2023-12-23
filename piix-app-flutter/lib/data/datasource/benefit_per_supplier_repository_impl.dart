import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/domain/repository/benefit_per_supplier_repository_interface.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

/// Implementation of [BenefitPerSupplierRepositoryInterface]
class BenefitPerSupplierRepositoryImpl
    implements BenefitPerSupplierRepositoryInterface {
  final appConfig = AppConfig.instance;

  /// Get benefit info for package by id
  //TODO: Delete once the new implementation is in app
  @override
  Future<BenefitPerSupplierModel> getBenefitInfoInPackageById({
    required String benefitPerSupplierId,
    required String userId,
    required String? levelId,
  }) async {
    final url = '${appConfig.backendEndpoint}/package/supplier/benefit?'
        'benefitPerSupplierId=$benefitPerSupplierId&userId=$userId'
        '&levelId=$levelId';
    try {
      final res = await PiixApiDeprecated.get(url);
      if (PiixApiDeprecated.checkStatusCode(statusCode: res.statusCode!)) {
        final benefit = BenefitPerSupplierModel.fromJson(res.data);
        return benefit;
      }
      throw Exception(res.data);
    } catch (err) {
      rethrow;
    }
  }
}
