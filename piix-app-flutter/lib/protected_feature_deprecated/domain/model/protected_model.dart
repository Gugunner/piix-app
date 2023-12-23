import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';

part 'protected_model.freezed.dart';
part 'protected_model.g.dart';

///This class contains all arguments of protected info.
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: false,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class ProtectedModel with _$ProtectedModel {
  const ProtectedModel._();

  factory ProtectedModel({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String uniqueId,
    String? email,
    String? internationalPhoneCode,
    String? phoneNumber,
    String? name,
    String? firstLastName,
    String? genderId,
    String? governmentNumber,
    String? street,
    String? countryId,
    String? stateId,
    String? zipCode,
    DateTime? birthdate,
    String? contactName,
    String? contactLastName,
    bool? needsToRefreshPage,
    String? genderName,
    String? countryName,
    String? stateName,
    String? city,
    String? externalNumber,
    @JsonKey(readValue: addDefaultType) MembershipModelDeprecated? membership,
    bool? userAlreadyHasBasicMainInfoForm,
    String? planId,
    String? planName,
  }) = _ProtectedModel;

  String? get fullName => '$name $firstLastName';

  factory ProtectedModel.fromJson(Map<String, dynamic> json) =>
      _$ProtectedModelFromJson(json);
}
