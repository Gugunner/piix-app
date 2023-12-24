import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/compare_benefits_per_supplier_model.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';
import 'package:piix_mobile/store_feature/domain/model/current_quote_plans_model/current_quote_price_plans_model.dart';

part 'level_quote_price_model.freezed.dart';

part 'level_quote_price_model.g.dart';

///This stores all properties pertaining a specific Level quotation model
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class LevelQuotePriceModel with _$LevelQuotePriceModel {
  const LevelQuotePriceModel._();
  factory LevelQuotePriceModel({
    @JsonKey(required: true, readValue: addRatesType) required LevelModel level,
    @JsonKey(required: true)
    required CompareBenefitsPerSupplierModel comparisonInformation,
    @JsonKey(required: true, name: 'userQuotationId')
    required String userQuotePriceId,
    @JsonKey(required: true) required DateTime quotationRegisterDate,
    @Default(false) bool pendingPurchaseForSameProduct,
    @JsonKey(name: 'plansForCurrentQuotation')
    CurrentQuotePricePlansModel? currentQuotePricePlans,
  }) = _LevelQuotePriceModel;

  factory LevelQuotePriceModel.fromJson(Map<String, dynamic> json) =>
      _$LevelQuotePriceModelFromJson(json);
}
