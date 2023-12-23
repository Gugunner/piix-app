import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/kinship_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/kinship_with_membership_model.dart';

part 'protected_slot_model.freezed.dart';
part 'protected_slot_model.g.dart';

///This class contains all properties for a protected slot
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: false,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class ProtectedSlotModel with _$ProtectedSlotModel {
  const ProtectedSlotModel._();
  factory ProtectedSlotModel({
    @JsonKey(required: true) required String planId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String pseudonym,
    @JsonKey(required: true) required String kinshipId,
    @JsonKey(required: true) required KinshipModel kinship,
    @JsonKey(required: true)
    required List<KinshipsWithMembershipModel> kinshipsWithMembership,
    @Default(0) int maxUsersInPlan,
    @Default(0) int usedSlots,
    @Default(0) int availableSlots,
    DateTime? registerDate,
  }) = _ProtectedSlotModel;

  factory ProtectedSlotModel.fromJson(Map<String, dynamic> json) =>
      _$ProtectedSlotModelFromJson(json);
}
