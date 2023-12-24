import 'package:freezed_annotation/freezed_annotation.dart';

part 'benefit_per_supplier_coverage_model_deprecated.freezed.dart';

part 'benefit_per_supplier_coverage_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///This stores all properties pertaining a specific benefit and cobenefit
/// with offer value
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class BenefitPerSupplierCoverageModel with _$BenefitPerSupplierCoverageModel {
  const BenefitPerSupplierCoverageModel._();

  factory BenefitPerSupplierCoverageModel({
    @JsonKey(required: true) required String benefitName,
    @JsonKey(required: true) required String benefitId,
    @JsonKey(required: true) required String supplierName,
    @JsonKey(required: true) required String supplierId,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required String coverageOfferType,
    @JsonKey(required: true) required double newCoverageOfferValue,
    @JsonKey(required: true) required double oldCoverageOfferValue,
    @Default(false) bool hasCobenefits,
    @Default('') String benefitPerSupplierId,
    @Default('') String cobenefitPerSupplierId,
  }) = _BenefitPerSupplierCoverageModel;

  factory BenefitPerSupplierCoverageModel.level({
    @JsonKey(required: true) required String benefitName,
    @JsonKey(required: true) required String benefitId,
    @JsonKey(required: true) required String supplierName,
    @JsonKey(required: true) required String supplierId,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required double coverageOfferValue,
    @JsonKey(required: true) required String coverageOfferType,
    @Default(false) bool hasCobenefits,
    @Default('') String benefitPerSupplierId,
    @Default('') String cobenefitPerSupplierId,
  }) = _BenefitPerSupplierCoverageLevelModel;

  factory BenefitPerSupplierCoverageModel.fromJson(Map<String, dynamic> json) =>
      _$BenefitPerSupplierCoverageModelFromJson(json);

  @override
  String get benefitName => map(
        (value) => value.benefitName,
        level: (value) => value.benefitName,
      );

  @override
  String get benefitId => map(
        (value) => value.benefitId,
        level: (value) => value.benefitId,
      );

  @override
  String get supplierName => map(
        (value) => value.benefitId,
        level: (value) => value.supplierName,
      );

  @override
  String get supplierId => map(
        (value) => value.supplierId,
        level: (value) => value.supplierId,
      );

  @override
  String get wordingZero => map(
        (value) => value.wordingZero,
        level: (value) => value.wordingZero,
      );

  @override
  String get coverageOfferType => map(
        (value) => value.coverageOfferType,
        level: (value) => value.coverageOfferType,
      );

  double get newCoverageOfferValue => maybeMap(
        (value) => value.newCoverageOfferValue,
        orElse: () => 0.0,
      );

  double get oldCoverageOfferValue => maybeMap(
        (value) => value.oldCoverageOfferValue,
        orElse: () => 0.0,
      );

  double get coverageOfferValue => maybeMap(
        (value) => 0.0,
        level: (value) => value.coverageOfferValue,
        orElse: () => 0.0,
      );
}
