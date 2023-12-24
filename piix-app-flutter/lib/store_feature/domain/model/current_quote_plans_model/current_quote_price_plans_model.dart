import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/store_feature/domain/model/current_quote_plans_model/user_plan_model.dart';
import 'package:piix_mobile/store_feature/domain/model/protected_quantity_model.dart';

part 'current_quote_price_plans_model.freezed.dart';

part 'current_quote_price_plans_model.g.dart';

@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class CurrentQuotePricePlansModel with _$CurrentQuotePricePlansModel {
  const CurrentQuotePricePlansModel._();

  factory CurrentQuotePricePlansModel({
    @JsonKey(required: true) required ProtectedQuantityModel protectedQuantity,
    @JsonKey(required: true, name: 'plansWithUsers')
    required List<UserPlanModel> userPlans,
  }) = _CurrentQuotePlansModel;

  factory CurrentQuotePricePlansModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentQuotePricePlansModelFromJson(json);
}
