import 'package:freezed_annotation/freezed_annotation.dart';

part 'kinship_with_membership_model.freezed.dart';
part 'kinship_with_membership_model.g.dart';

///This class contains all properties for a kinship with membership model
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class KinshipsWithMembershipModel with _$KinshipsWithMembershipModel {
  const KinshipsWithMembershipModel._();
  factory KinshipsWithMembershipModel({
      @JsonKey(required: true)
    required String membershipId,
      @JsonKey(required: true)
    required String kinshipId,
  }) = _KinshipsWithMembershipModel;

  factory KinshipsWithMembershipModel.fromJson(Map<String, dynamic> json) =>
      _$KinshipsWithMembershipModelFromJson(json);
}
