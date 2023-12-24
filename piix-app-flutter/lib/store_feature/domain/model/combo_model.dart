import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/intermediary_fee_model.dart';
import 'package:piix_mobile/store_feature/domain/model/current_quote_plans_model/current_quote_price_plans_model.dart';
import 'package:piix_mobile/store_feature/domain/model/pending_purchases_of_combo_model.dart';
import 'package:piix_mobile/store_feature/domain/model/product_rates_model.dart';

part 'combo_model.freezed.dart';

part 'combo_model.g.dart';

///This stores all the information pertaining a specific package combo
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class ComboModel with _$ComboModel {
  const ComboModel._();

  factory ComboModel({
    @JsonKey(required: true) required String packageComboId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @Default(false) bool isPartiallyAcquired,
    @Default(false) bool isAlreadyAcquired,
    @Default(false) bool hasPendingInvoice,
    @Default(false) bool hasBenefitForm,
    @Default(false) bool pendingPurchaseForSameProduct,
    @Default(false) bool active,
    @Default([])
    List<PendingPurchasesOfComboModel> pendingPurchasesOfAdditionalBenefit,
    @JsonKey(readValue: addAdditionalType)
    @Default([])
    List<BenefitPerSupplierModel> additionalBenefitsPerSupplier,
    @Default('') String userQuotationId,
    @JsonKey(name: 'plansForCurrentQuotation')
    CurrentQuotePricePlansModel? currentQuotePricePlansModel,
    @Default('') String description,
    @Default(0.0) double comboDiscount,
    ProductRatesModel? productRates,
    List<IntermediaryFeeModel>? intermediariesFees,
    DateTime? registerDate,
    DateTime? updateDate,
    DateTime? quotationRegisterDate,
  }) = _ComboModel;

  factory ComboModel.purchased({
    @JsonKey(required: true) required String packageComboId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(readValue: addPurchasedType)
    @Default([])
    List<BenefitPerSupplierModel> additionalBenefitsPerSupplier,
  }) = _ComboPurchasedModel;

  factory ComboModel.fromJson(Map<String, dynamic> json) =>
      _$ComboModelFromJson(json);

  @override
  String get packageComboId => map(
        (value) => value.packageComboId,
        purchased: (value) => value.packageComboId,
      );

  @override
  String get folio => map(
        (value) => value.folio,
        purchased: (value) => value.folio,
      );

  @override
  String get name => map(
        (value) => value.name,
        purchased: (value) => value.name,
      );

  bool get isPartiallyAcquired => maybeMap(
        (value) => value.isPartiallyAcquired,
        orElse: () => false,
      );

  bool get isAlreadyAcquired => maybeMap(
        (value) => value.isAlreadyAcquired,
        orElse: () => false,
      );

  bool get hasPendingInvoice => maybeMap(
        (value) => value.hasPendingInvoice,
        orElse: () => false,
      );

  bool get hasBenefitForm => maybeMap(
        (value) => value.hasBenefitForm,
        orElse: () => false,
      );

  bool get pendingPurchaseForSameProduct => maybeMap(
        (value) => value.pendingPurchaseForSameProduct,
        orElse: () => false,
      );

  bool get active => maybeMap(
        (value) => value.active,
        orElse: () => false,
      );

  List<PendingPurchasesOfComboModel> get pendingPurchasesOfAdditionalBenefit =>
      maybeMap(
        (value) => value.pendingPurchasesOfAdditionalBenefit,
        orElse: () => [],
      );

  @override
  List<BenefitPerSupplierModel> get additionalBenefitsPerSupplier => map(
        (value) => value.additionalBenefitsPerSupplier,
        purchased: (value) => value.additionalBenefitsPerSupplier,
      );

  String get userQuotationId => maybeMap(
        (value) => value.userQuotationId,
        orElse: () => '',
      );

  CurrentQuotePricePlansModel? get currentQuotePricePlansModel => mapOrNull(
        (value) => value.currentQuotePricePlansModel,
      );

  String get description => maybeMap(
        (value) => value.description,
        orElse: () => '',
      );

  double get comboDiscount => maybeMap(
        (value) => value.comboDiscount,
        orElse: () => 0.0,
      );

  ProductRatesModel? get productRates => mapOrNull(
        (value) => value.productRates,
      );

  List<IntermediaryFeeModel>? get intermediariesFees => mapOrNull(
        (value) => value.intermediariesFees,
      );

  DateTime? get registerDate => mapOrNull(
        (value) => value.registerDate,
      );

  DateTime? get updateDate => mapOrNull(
        (value) => value.updateDate,
      );

  DateTime? get quotationRegisterDate => mapOrNull(
        (value) => value.quotationRegisterDate,
      );
}
