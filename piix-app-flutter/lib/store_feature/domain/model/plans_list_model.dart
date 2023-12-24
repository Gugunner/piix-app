import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';

part 'plans_list_model.freezed.dart';

part 'plans_list_model.g.dart';

///This stores all the information pertaining a specific plan list model
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class PlansListModel with _$PlansListModel {
  const PlansListModel._();

  factory PlansListModel({
    @JsonKey(required: true) required int protectedLimit,
    @JsonKey(required: true) required int totalProtectedAcquired,
    @JsonKey(required: true, readValue: addDefaultType)
    required List<PlanModel> plans,
  }) = _PlansListModel;

  factory PlansListModel.fromJson(Map<String, dynamic> json) =>
      _$PlansListModelFromJson(json);
}
