import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/kinship_model.dart';

part 'membership_plan_model.freezed.dart';
part 'membership_plan_model.g.dart';

/// Membership plan of a user.
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class MembershipPlanModel with _$MembershipPlanModel {
  @JsonSerializable(explicitToJson: true)
  const MembershipPlanModel._();
  factory MembershipPlanModel({
    @JsonKey(required: true)
        required String planId,
    @JsonKey(required: true)
        required String folio,
    @JsonKey(required: true)
        required String name,
    @JsonKey(required: true)
        required KinshipModel kinship,
    @JsonKey(
      required: true,
      name: 'registerDate',
      fromJson: toDateTime,
    )
        required DateTime registerDate,
    @JsonKey(required: true)
        required String pseudonym,
    @Default(1)
        int maxUsersInPlan,
    @Default(0)
        int protectedAcquired,
  }) = _MembershipPlanModel;

  factory MembershipPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipPlanModelFromJson(json);
}
