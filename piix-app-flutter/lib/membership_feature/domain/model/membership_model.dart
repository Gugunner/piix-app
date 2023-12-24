import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';

part 'membership_model.freezed.dart';
part 'membership_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class MembershipModel with _$MembershipModel {
  @JsonSerializable(explicitToJson: true)
  const MembershipModel._();
  factory MembershipModel.detailList({
    //Identification
    @JsonKey(required: true) required String membershipId,
    @JsonKey(required: true) required DateTime registerDate,
    //General information
    ///Number of active benefits in the membership
    @JsonKey(required: true) required int benefitsQuantity,

    ///Number of users inside the user group
    @JsonKey(required: true) required int userSlotsQuantity,
    //Membership Status
    ///Cam be either 'Active' or 'INACTIVE'
    @JsonKey(required: true) required Status status,
    @JsonKey(required: true) required bool isMainHolder,
    @JsonKey(required: true) required bool canBuy,
    @JsonKey(required: true) required List<BuyerPermission> buyPermissions,
    //Membership Package
    ///Will be available to a user whose membership
    ///is directly linkedup to a community.
    PackageModel? package,
    LinkupCodeTypeModel? linkupModel,
  }) = _AppMembershipDetailListModel;

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  bool get isLinkedUp => package != null || !isMainHolder;

  bool get isActive => status == Status.ACTIVE;
}

enum BuyerPermission {
  ECOMMERCE_NEW_PURCHASES,
  ECOMMERCE_EXTRA_EVENTS,
  ECOMMERCE_RENEWALS
}

enum Status {
  ACTIVE,
  INACTIVE,
}