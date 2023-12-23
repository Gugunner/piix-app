import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_rates_model.freezed.dart';

part 'product_rates_model.g.dart';

///This stores all the product rates pertaining a specific additional benefit,
/// combo, level or plan
///
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class ProductRatesModel with _$ProductRatesModel{
  @JsonSerializable(explicitToJson: true)
  const ProductRatesModel._();
  factory  ProductRatesModel({
    @JsonKey(required: true)
    required double summedOriginalRiskPremium,
    @JsonKey(required: true)
    required double summedRiskPremium,
    @JsonKey(required: true)
    required double summedNetPremium,
    @JsonKey(required: true)
    required double summedTotalPremium,
    @JsonKey(required: true)
    required double marketDiscount,
    @JsonKey(required: true)
    required double volumeDiscount,
    @JsonKey(required: true)
    required double finalDiscount,
    @JsonKey(required: true)
    required double finalTotalPremium,
    @JsonKey(required: true)
    required double finalNetPremium,
    @JsonKey(required: true)
    required double finalRiskPremium,
    @JsonKey(required: true)
    required double finalOriginalRiskPremium,
    @JsonKey(required: true)
    required double finalTotalDiscountAmount,
    @JsonKey(required: true)
    required double finalMarketDiscountAmount,
    @JsonKey(required: true)
    required double finalVolumeDiscountAmount,
    @Default(0.0)
    double comboDiscount,
    @Default(0.0)
    double finalComboDiscountAmount,
  }) = _ProductRatesModel;


  factory ProductRatesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRatesModelFromJson(json);
}
