import 'package:freezed_annotation/freezed_annotation.dart';

part 'additional_benefit_per_supplier_quote_price_request_model_deprecated.freezed.dart';

part 'additional_benefit_per_supplier_quote_price_request_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class AdditionalBenefitPerSupplierQuotePriceRequestModel
    with _$AdditionalBenefitPerSupplierQuotePriceRequestModel {
  @JsonSerializable(explicitToJson: true)
  const AdditionalBenefitPerSupplierQuotePriceRequestModel._();

  factory AdditionalBenefitPerSupplierQuotePriceRequestModel({
    @JsonKey(required: true) required String membershipId,
    @JsonKey(required: true) required String additionalBenefitPerSupplierId,
    @Default(false) bool isPartialPurchase,
  }) = _AdditionalBenefitPerSupplierQuotePriceRequestModel;
}
