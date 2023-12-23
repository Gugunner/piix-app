import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';

/// Interface for Benefit By Id Repository
abstract class BenefitPerSupplierRepositoryInterface {
  /// Get benefit info for package by id
  //TODO: Delete once the new implementation is in app
  Future<BenefitPerSupplierModel> getBenefitInfoInPackageById({
    required String benefitPerSupplierId,
    required String userId,
    required String? levelId,
  });
}
