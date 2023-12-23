import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';

part 'user_quote_model.freezed.dart';

part 'user_quote_model.g.dart';

///This stores all the information of user quotation in purchase invoice
///
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class UserQuoteModel with _$UserQuoteModel {
  const UserQuoteModel._();

  factory UserQuoteModel.purchased({
    @JsonKey(required: true, name: 'userQuotationId')
    required String userQuotePriceId,
    @JsonKey(required: true, fromJson: fromProductStringStatus)
    required ProductTypeDeprecated productType,
    @JsonKey(required: true) required double totalPremium,
    @JsonKey(required: true) required double totalNetPremium,
    @JsonKey(required: true) required double totalRiskPremium,
    @JsonKey(required: true) required double totalOriginalRiskPremium,
    @JsonKey(required: true) required double marketDiscountAmount,
    @JsonKey(required: true) required double volumeDiscountAmount,
    @JsonKey(required: true) required double totalDiscountAmount,
    @JsonKey(required: true) required double marketDiscount,
    @JsonKey(required: true) required double volumeDiscount,
    @JsonKey(required: true) required double finalDiscount,
    @Default(0.0) double comboDiscount,
    @Default(0.0) double comboDiscountAmount,
    List<String>? planIds,
  }) = _UserQuotePurchasedModel;

  factory UserQuoteModel.detail({
    @JsonKey(required: true, name: 'userQuotationId')
    required String userQuotePriceId,
    @JsonKey(required: true, fromJson: fromProductStringStatus)
    required ProductTypeDeprecated productType,
    @JsonKey(required: true) required double totalPremium,
    @JsonKey(required: true) required double totalNetPremium,
    @JsonKey(required: true) required double totalRiskPremium,
    @JsonKey(required: true) required double totalOriginalRiskPremium,
    @JsonKey(required: true) required double marketDiscountAmount,
    @JsonKey(required: true) required double volumeDiscountAmount,
    @JsonKey(required: true) required double totalDiscountAmount,
    @JsonKey(required: true) required double marketDiscount,
    @JsonKey(required: true) required double volumeDiscount,
    @JsonKey(required: true) required double finalDiscount,
    @JsonKey(required: true) required List<dynamic> intermediariesCommissions,
    @JsonKey(required: true, name: 'quotationStatus')
    required String quotePriceStatus,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true) required List<String> membershipPlanIds,
    @JsonKey(required: true) required String membershipLevelId,
    @Default(0.0) double comboDiscount,
    @Default(0.0) double comboDiscountAmount,
    @Default([]) List<String> additionalBenefitsPerSupplierIds,
  }) = _UserQuoteDetailModel;

  factory UserQuoteModel.payment({
    @JsonKey(required: true, name: 'userQuotationId')
    required String userQuotePriceId,
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String packageId,
    @JsonKey(required: true) required String membershipLevelId,
    @JsonKey(required: true) required List<String> membershipPlanIds,
    @JsonKey(required: true, fromJson: fromProductStringStatus)
    required ProductTypeDeprecated productType,
    @JsonKey(required: true) required double totalPremium,
    @JsonKey(required: true) required double totalNetPremium,
    @JsonKey(required: true) required double totalRiskPremium,
    @JsonKey(required: true) required double totalOriginalRiskPremium,
    @JsonKey(required: true) required double marketDiscountAmount,
    @JsonKey(required: true) required double volumeDiscountAmount,
    @JsonKey(required: true) required double totalDiscountAmount,
    @JsonKey(required: true, name: 'quotationStatus')
    required String quotePriceStatus,
    @JsonKey(required: true) required DateTime registerDate,
    @Default(0.0) double comboDiscountAmount,
    DateTime? updateDate,
  }) = _UserQuotePaymentModel;

  factory UserQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$UserQuoteModelFromJson(json);

  @override
  String get userQuotePriceId => map(
        purchased: (value) => value.userQuotePriceId,
        detail: (value) => value.userQuotePriceId,
        payment: (value) => value.userQuotePriceId,
      );

  @override
  ProductTypeDeprecated get productType => map(
        purchased: (value) => value.productType,
        detail: (value) => value.productType,
        payment: (value) => value.productType,
      );

  @override
  double get totalPremium => map(
        purchased: (value) => value.totalPremium,
        detail: (value) => value.totalPremium,
        payment: (value) => value.totalPremium,
      );

  @override
  double get totalNetPremium => map(
        purchased: (value) => value.totalNetPremium,
        detail: (value) => value.totalNetPremium,
        payment: (value) => value.totalNetPremium,
      );

  @override
  double get totalRiskPremium => map(
        purchased: (value) => value.totalRiskPremium,
        detail: (value) => value.totalRiskPremium,
        payment: (value) => value.totalRiskPremium,
      );

  @override
  double get totalOriginalRiskPremium => map(
        purchased: (value) => value.totalOriginalRiskPremium,
        detail: (value) => value.totalOriginalRiskPremium,
        payment: (value) => value.totalOriginalRiskPremium,
      );

  @override
  double get marketDiscountAmount => map(
        purchased: (value) => value.marketDiscountAmount,
        detail: (value) => value.marketDiscountAmount,
        payment: (value) => value.marketDiscountAmount,
      );

  @override
  double get volumeDiscountAmount => map(
        purchased: (value) => value.volumeDiscountAmount,
        detail: (value) => value.volumeDiscountAmount,
        payment: (value) => value.volumeDiscountAmount,
      );

  @override
  double get totalDiscountAmount => map(
        purchased: (value) => value.totalDiscountAmount,
        detail: (value) => value.totalDiscountAmount,
        payment: (value) => value.totalDiscountAmount,
      );

  double get marketDiscount => maybeMap(
        purchased: (value) => value.marketDiscount,
        detail: (value) => value.marketDiscount,
        orElse: () => 0.0,
      );

  double get volumeDiscount => maybeMap(
        purchased: (value) => value.volumeDiscount,
        detail: (value) => value.volumeDiscount,
        orElse: () => 0.0,
      );

  double get finalDiscount => maybeMap(
      purchased: (value) => value.finalDiscount,
      detail: (value) => value.finalDiscount,
      orElse: () => 0.0);

  double get comboDiscount => maybeMap(
        purchased: (value) => value.comboDiscount,
        detail: (value) => value.comboDiscount,
        orElse: () => 0.0,
      );

  @override
  double get comboDiscountAmount => map(
        purchased: (value) => value.comboDiscountAmount,
        detail: (value) => value.comboDiscountAmount,
        payment: (value) => value.comboDiscountAmount,
      );

  List<String>? get planIds => mapOrNull(
        purchased: (value) => value.planIds,
      );

  List<dynamic> get intermediariesCommissions => maybeMap(
        detail: (value) => value.intermediariesCommissions,
        orElse: () => [],
      );

  DateTime? get registerDate => mapOrNull(
        detail: (value) => value.registerDate,
        payment: (value) => value.registerDate,
      );

  List<String> get membershipPlanIds => maybeMap(
        detail: (value) => value.membershipPlanIds,
        orElse: () => [],
      );

  String get membershipLevelId => maybeMap(
        detail: (value) => value.membershipLevelId,
        payment: (value) => value.membershipLevelId,
        orElse: () => '',
      );

  List<String> get additionalBenefitsPerSupplierIds => maybeMap(
        detail: (value) => value.additionalBenefitsPerSupplierIds,
        orElse: () => [],
      );

  DateTime? get updateDate => mapOrNull(
        payment: (value) => value.updateDate,
      );
}
