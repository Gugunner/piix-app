import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/benefit_per_supplier_coverage_model_deprecated.dart';

part 'compare_benefits_per_supplier_model.freezed.dart';

part 'compare_benefits_per_supplier_model.g.dart';

///This stores all properties pertaining a specific comparison level
///information
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class CompareBenefitsPerSupplierModel with _$CompareBenefitsPerSupplierModel {
  const CompareBenefitsPerSupplierModel._();

  factory CompareBenefitsPerSupplierModel({
    @JsonKey(required: true, readValue: addLevelType)
    required List<BenefitPerSupplierModel> newBenefits,
    @JsonKey(required: true, readValue: addDefaultType)
    required List<BenefitPerSupplierCoverageModel>
        existingAdditionalBenefitsWithCoverageOfferValues,
    @JsonKey(required: true, readValue: addDefaultType)
    required List<BenefitPerSupplierCoverageModel>
        existingBenefitsAndCobenefitsWithCoverageOfferValues,
  }) = _CompareBenefitsPerSupplierModel;

  factory CompareBenefitsPerSupplierModel.fromJson(Map<String, dynamic> json) =>
      _$CompareBenefitsPerSupplierModelFromJson(json);

  int get existingBenefitsLength =>
      existingBenefitsAndCobenefitsWithCoverageOfferValues.length;

  int get existingAdditionalBenefitsLength =>
      existingAdditionalBenefitsWithCoverageOfferValues.length;

  int get newBenefitsLength => newBenefits.length;

  List<BenefitPerSupplierCoverageModel> get allExistingBenefits {
    var existingBenefits = <BenefitPerSupplierCoverageModel>[];
    if (existingAdditionalBenefitsWithCoverageOfferValues.isNotEmpty)
      existingBenefits = [
        ...existingBenefits,
        ...existingAdditionalBenefitsWithCoverageOfferValues
      ];
    if (existingBenefitsAndCobenefitsWithCoverageOfferValues.isNotEmpty)
      existingBenefits = [
        ...existingBenefits,
        ...existingBenefitsAndCobenefitsWithCoverageOfferValues
      ];
    return existingBenefits;
  }

  BenefitPerSupplierCoverageModel _toCoverageModel(
          BenefitPerSupplierModel benefitPerSupplier) =>
      BenefitPerSupplierCoverageModel(
        benefitName: benefitPerSupplier.benefitName,
        benefitId: benefitPerSupplier.benefitPerSupplierId,
        supplierName: benefitPerSupplier.supplierName,
        supplierId: benefitPerSupplier.supplierId,
        wordingZero: benefitPerSupplier.wordingZero,
        coverageOfferType: benefitPerSupplier.coverageOfferType,
        newCoverageOfferValue: benefitPerSupplier.newCoverageOfferValue,
        oldCoverageOfferValue: benefitPerSupplier.oldCoverageOfferValue,
      );

  List<BenefitPerSupplierCoverageModel> _flatNewBenefitsToCoverageModel(
      List<BenefitPerSupplierModel> benefitsPerSupplier) {
    return benefitsPerSupplier.expand((benefitPerSupplier) {
      if (benefitPerSupplier.hasCobenefits) {
        return _flatNewBenefitsToCoverageModel(
            benefitPerSupplier.cobenefitsPerSupplier);
      }
      return [_toCoverageModel(benefitPerSupplier)];
    }).toList();
  }

  List<BenefitPerSupplierCoverageModel> get newBenefitsWithCoverageModel =>
      _flatNewBenefitsToCoverageModel(newBenefits);
}
