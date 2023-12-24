import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/membership_benefits_feature/utils/membership_benefits_model_barrel_file.dart';

part 'last_grade_benefit_per_supplier_model.freezed.dart';
part 'last_grade_benefit_per_supplier_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class LastGradeBenefitPerSupplierModel with _$LastGradeBenefitPerSupplierModel {
  @JsonSerializable(explicitToJson: true)
  const LastGradeBenefitPerSupplierModel._();
  @Implements<BaseBenefitPerSupplierModel>()
  factory LastGradeBenefitPerSupplierModel.benefit({
    @JsonKey(required: true) required String benefitPerSupplierId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required String pdfWording,
    @JsonKey(required: true) required String benefitImage,
    @JsonKey(required: true) required String certificate,
    @JsonKey(required: true) required String coverageOfferType,
    @JsonKey(required: true) required double coverageOfferValue,
    @JsonKey(required: true) required DateTime effectiveFromDate,
    @JsonKey(required: true) required DateTime effectiveToDate,
    @JsonKey(required: true) required int claimedTimes,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required SupplierModel supplier,
    TicketModel? ticket,
    String? wordingOne,
    String? wordingTwo,
    String? benefitFormId,
  }) = _BenefitPerSupplierModel;

  @Implements<BaseBenefitPerSupplierModel>()
  factory LastGradeBenefitPerSupplierModel.cobenefit({
    @JsonKey(required: true) required String cobenefitPerSupplierId,
    @JsonKey(required: true) required String relatedBenefitPerSupplierId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required String pdfWording,
    @JsonKey(required: true) required String benefitImage,
    @JsonKey(required: true) required String certificate,
    @JsonKey(required: true) required String coverageOfferType,
    @JsonKey(required: true) required double coverageOfferValue,
    @JsonKey(required: true) required DateTime effectiveFromDate,
    @JsonKey(required: true) required DateTime effectiveToDate,
    @JsonKey(required: true) required int claimedTimes,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required SupplierModel supplier,
    TicketModel? ticket,
    String? wordingOne,
    String? wordingTwo,
    String? benefitFormId,
  }) = _CobenefitPerSupplierModel;

  factory LastGradeBenefitPerSupplierModel.additional({
    required String additionalBenefitPerSupplierId,
    @Default(false) bool active,
    String? relatedPackageComboId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String wordingZero,
    @JsonKey(required: true) required String pdfWording,
    @JsonKey(required: true) required String benefitImage,
    @JsonKey(required: true) required String certificate,
    @JsonKey(required: true) required String coverageOfferType,
    @JsonKey(required: true) required double coverageOfferValue,
   @JsonKey(required: true) required DateTime effectiveFromDate,
    @JsonKey(required: true) required DateTime effectiveToDate,
    @JsonKey(required: true) required int claimedTimes,
    @Default(false) bool requiresAgeCompliance,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool needsBenefitFormSignature,
    @Default(false) bool userHasAlreadySignedTheBenefitForm,
    @JsonKey(required: true) required BenefitModel benefit,
    @JsonKey(required: true) required BenefitTypeModel benefitType,
    @JsonKey(required: true) required SupplierModel supplier,
    TicketModel? ticket,
    String? wordingOne,
    String? wordingTwo,
    String? benefitFormId,
  }) = _AdditionalBenefitPerSupplierModel;

  factory LastGradeBenefitPerSupplierModel.fromJson(
          Map<String, dynamic> json) =>
      _$LastGradeBenefitPerSupplierModelFromJson(json);
      
}
