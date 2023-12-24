import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/product_rates_model.dart';

part 'plan_quote_price_model.freezed.dart';

part 'plan_quote_price_model.g.dart';

///This stores all the information pertaining a specific plan quotation model
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class PlanQuotePriceModel with _$PlanQuotePriceModel {
  const PlanQuotePriceModel._();

  factory PlanQuotePriceModel({
    @JsonKey(required: true, readValue: addDefaultType)
    required List<PlanModel> plans,
    @JsonKey(required: true) required ProductRatesModel productRates,
    @JsonKey(required: true, name: 'userQuotationId')
    required String userQuotePriceId,
    @JsonKey(required: true) required DateTime quotationRegisterDate,
    @Default(false) bool existsSimultaneousPurchases,
  }) = _PlanQuotePriceModel;

  factory PlanQuotePriceModel.fromJson(Map<String, dynamic> json) =>
      _$PlanQuotePriceModelFromJson(json);
}
