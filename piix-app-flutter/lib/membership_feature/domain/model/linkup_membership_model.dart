import 'package:freezed_annotation/freezed_annotation.dart';

part 'linkup_membership_model.freezed.dart';

part 'linkup_membership_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class LinkupMembershipModel with _$LinkupMembershipModel {
  @JsonSerializable(explicitToJson: true)
  const LinkupMembershipModel._();

  factory LinkupMembershipModel.community({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String linkupCode,
  }) = _LinkupCommunityMembershipModel;

  factory LinkupMembershipModel.group({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String invitationCode,
  }) = _LinkupFamilyGroupMembershipModel;
}
