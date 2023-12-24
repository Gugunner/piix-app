import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_plan_model.freezed.dart';

part 'user_plan_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class UserPlanModel with _$UserPlanModel {
  const UserPlanModel._();

  factory UserPlanModel({
    @JsonKey(required: true)
    required String planId,
       @JsonKey(required: true)
    required String folio,
       @JsonKey(required: true)
    required String name,
       @JsonKey(required: true)
    required String pseudonym,
       @JsonKey(required: true)
    required int maxUsersInPlan,
       @JsonKey(required: true)
    required String kinshipId,
       @JsonKey(required: true)
    required DateTime registerDate,
       @JsonKey(required: true)
    required int protectedAcquired,
    @Default('')
    String userId,
  }) = _UserPlanModel;

  factory UserPlanModel.fromJson(Map<String, dynamic> json) =>
      _$UserPlanModelFromJson(json);
}
