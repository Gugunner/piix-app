import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_level_model.freezed.dart';
part 'membership_level_model.g.dart';

/// Membership level of a user.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class MembershipLevelModel with _$MembershipLevelModel {
    @JsonSerializable(explicitToJson: true)
  const MembershipLevelModel._();
  factory  MembershipLevelModel({
    @JsonKey(required: true)
    required String levelId,
    @JsonKey(required: true)
    required String folio,
    @JsonKey(required: true)
    required String name,
    @JsonKey(required: true)
    required String pseudonym,
     @JsonKey(name: 'membershipLevelImage',)
    String? cardImage,
    String? cardImageMemory,
    @JsonKey(includeFromJson: false)
    Uint8List? cardImageCache,
  }) = _MembershipLevelModel;


  factory MembershipLevelModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipLevelModelFromJson(json);

}
