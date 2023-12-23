import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/membership_benefits_feature/utils/membership_benefits_model_barrel_file.dart';

part 'parent_benefit_per_supplier_model.freezed.dart';
part 'parent_benefit_per_supplier_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class ParentBenefitPerSupplierModel with _$ParentBenefitPerSupplierModel {
  @JsonSerializable(explicitToJson: true)
  const ParentBenefitPerSupplierModel._();
  factory ParentBenefitPerSupplierModel.benefit({
    @JsonKey(required: true) required String benefitPerSupplierId,
    @JsonKey(required: true) required List<String> cobenefitsPerSupplierIds,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required String pdfWording,
    @JsonKey(required: true) required String benefitImage,
    @JsonKey(required: true) required String certificate,
    @JsonKey(required: true) required String coverageOfferType,
    @JsonKey(required: true) required DateTime effectiveFromDate,
    @JsonKey(required: true) required DateTime effectiveToDate,
    @JsonKey(required: true) required int claimedTimes,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @Default(true) bool hasCobenefits,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required SupplierModel supplier,
    TicketModel? ticket,
    String? wordingOne,
    String? wordingTwo,
    String? benefitFormId,
  }) = _ParentBenefitPerSupplierModel;

  factory ParentBenefitPerSupplierModel.combo({
    @JsonKey(required: true) required String packageComboId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String description,
    @JsonKey(required: true) required double comboDiscount,
    @JsonKey(required: true)
        required List<String> additionalBenefitsPerSupplierIds,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required String pdfWording,
    @JsonKey(required: true, name: 'comboImage') required String benefitImage,
    @JsonKey(required: true) required String certificate,
    @JsonKey(required: true) required DateTime effectiveFromDate,
    @JsonKey(required: true) required DateTime effectiveToDate,
    @Default(false) bool active,
    @Default(false) bool requiresAgeCompliance,
    String? wordingOne,
    String? wordingTwo,
    String? benefitFormId,
  }) = _ParentComboBenefitPerSupplierModel;

  factory ParentBenefitPerSupplierModel.fromJson(Map<String, dynamic> json) =>
      _$ParentBenefitPerSupplierModelFromJson(json);
}
