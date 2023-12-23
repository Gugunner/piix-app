import 'package:flutter/widgets.dart' show BuildContext;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/map_json_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';
import 'package:piix_mobile/utils/list_utils.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

part 'user_app_model.freezed.dart';
part 'user_app_model.g.dart';

@Deprecated('Will be removed in 4.0')
enum UserMembershipUpdateDeprecated {
  level,
  plan,
  all,
}

enum UserAuthenticationStatus {
  IDLE,
  PENDING,
  IN_REVISION,
  SYSTEM_ERROR,
  APPROVED,
  REJECTED,
}

/// This model is used to store the user info once the user is logged in.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class UserAppModel with _$UserAppModel {
  @JsonSerializable(explicitToJson: true)
  const UserAppModel._();

  factory UserAppModel.detail({
    //Required
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required UserAuthenticationStatus processingStatus,
    @JsonKey(required: true) required bool selfRegistered,
    @JsonKey(required: true) required bool emailVerified,
    @JsonKey(required: true) required bool phoneVerified,
    @JsonKey(required: true) required DateTime registerDate,
    @Default(false) bool userAlreadyHasBasicMainInfoForm,
    String? communityTypeId,
    String? communityName,
    int? userSlotsQuantity,
    DateTime? updateDate,
    String? uniqueId,
    String? authVerificationCode,
    String? customAccessToken,
    //Configurations
    String? userPreferredLanguage,
    //Personal Information
    String? name,
    String? middleName,
    String? firstLastName,
    String? secondLastName,
    String? genderId,
    String? genderName,
    String? prefixName,
    String? prefixId,
    DateTime? birthdate,
    String? governmentNumber,

    ///(Authentication)
    String? internationalPhoneCode,
    String? phoneNumber,
    String? email,
    //Address
    String? addressId,
    String? street,
    String? externalNumber,
    String? interiorNumber,
    String? subThoroughFare,
    String? thoroughFare,
    String? countryId,
    String? countryName,
    String? stateId,
    String? stateName,
    String? city,
    String? zipCode,
    //Identification
    String? planId,
    //Membership
    //TODO: Remove in 4.0
    List<String>? membershipIds,
    //TODO: Remove in 4.0
    @JsonKey(readValue: addDefaultType)
    List<MembershipModelDeprecated>? memberships,
    //Contact Information
    String? contactName,
    String? contactLastName,
    String? contactInternationalPhoneCode,
    String? contactPhoneNumber,
    String? contactKinshipId,
    String? contactKinshipName,
  }) = _UserAppDetailModel;

  factory UserAppModel.fromJson(Map<String, dynamic> json) {
    //If there is no phoneNumber and the user is self registered
    //the app will throw an exception.
    if (json.isNullOrEmpty<String?>(json['phoneNumber']) &&
        (json['selfRegistered'] ?? false)) {
      throw Exception('The user has no phone number but is self registered');
    }
    return _$UserAppModelFromJson(json);
  }

  String get displayName => '${name ?? ''} ${middleName ?? ''} '
          '${firstLastName ?? ''} ${secondLastName ?? ''}'
      .titleCase()
      .trim();
}

extension UserAppModelExtend on UserAppModel {
  @Deprecated('Remove in 4.0')
  void updateMembership(MembershipModelDeprecated membership,
      UserMembershipUpdateDeprecated userMembershipUpdate) {
    if (memberships.isNullOrEmpty) return;
    final index = memberships!
        .indexWhere((m) => m.membershipId == membership.membershipId);
    if (index < 0) return;
    final updatedMembership =
        memberships!.guardElementAt<MembershipModelDeprecated>(index)!.copyWith(
              membershipId: membership.membershipId,
              mainSerialNumber: membership.mainSerialNumber,
              additionalSerialNumber: membership.additionalSerialNumber,
              isActive: membership.isActive,
              status: membership.status,
              package: membership.package,
            );
    switch (userMembershipUpdate) {
      case UserMembershipUpdateDeprecated.level:
        memberships![index] = updatedMembership.copyWith(
          usersMembershipLevel: membership.usersMembershipLevel,
        );
        break;
      case UserMembershipUpdateDeprecated.plan:
        memberships![index] = updatedMembership.copyWith(
          usersMembershipPlans: membership.usersMembershipPlans,
        );
        break;
      default:
        memberships![index] = updatedMembership.copyWith();
    }
  }

  String _displayMaxNames(String names, int max) {
    final namesList = names.split(' ');
    if (namesList.isEmpty) return '';
    if (max > namesList.length)
      return namesList.sublist(0, namesList.length).join(' ').trim();
    return namesList.sublist(0, max).join(' ').trim();
  }

  String displayNames({int max = 3}) {
    final names = '${name ?? ''} ${middleName ?? ''}';
    return _displayMaxNames(names, max);
  }

  String displayLastNames({int max = 3}) {
    final lastNames = '${firstLastName ?? ''} ${secondLastName ?? ''}';
    return _displayMaxNames(lastNames, max);
  }

  String get displayShortFullName =>
      '${displayNames(max: 1)} ${displayLastNames(max: 1)}';

  String get stringAddress => [stateName, zipCode, countryName]
      .map(
        (e) => e ?? '',
      )
      .join(', ');

  bool get isOnRevision => [
        UserAuthenticationStatus.IN_REVISION,
        UserAuthenticationStatus.PENDING,
        UserAuthenticationStatus.SYSTEM_ERROR,
      ].contains(processingStatus);
}

extension UserAppModelCalulatedFlags on UserAppModel {
  bool get completePersonalInformation =>
      name.isNotNullEmpty &&
      firstLastName.isNotNullEmpty &&
      email.isNotNullEmpty &&
      phoneNumber.isNotNullEmpty;

  bool get completeDocumentation => uniqueId.isNotNullEmpty;

  bool get approved => processingStatus == UserAuthenticationStatus.APPROVED;

  bool get rejected => processingStatus == UserAuthenticationStatus.REJECTED;

  bool get idle => processingStatus == UserAuthenticationStatus.IDLE;

  bool get pending => processingStatus == UserAuthenticationStatus.PENDING;
}

extension LocalizedUserAppInformation on UserAppModel {
  bool checkUserPropertyExists(String property) {
    final jsonUser = toJson();
    return jsonUser.containsKey(property);
  }

  ///Checks the value of [property] and if it matches a specific [case]
  ///inside the [switch] it returns a localized value of the property.
  String getPersonalInformationLocalizedPropertyName(String property,
      {required BuildContext context}) {
    if (checkUserPropertyExists(property)) {
      switch (property) {
        case 'name':
          return context.localeMessage.name;
        case 'middleName':
          return context.localeMessage.middleName;
        case 'firstLastName':
          return context.localeMessage.firstLastName;
        case 'secondLastName':
          return context.localeMessage.secondLastName;
        case 'email':
          return context.localeMessage.email;
        case 'internationalPhoneCode':
          return context.localeMessage.countryCode;
        case 'phoneNumber':
          return context.localeMessage.phoneNumber;
        case 'birthdate':
          return context.localeMessage.dateOfBirth;
        case 'genderName':
          return context.localeMessage.gender;
      }
    }
    return 'N/A';
  }
}

@Deprecated('Will be removed in 4.0')
extension MutableUserAppModel on UserAppModel {
  @Deprecated('Will be removed in 4.0')

  ///Creates two jsons one for the [newUser] and another
  ///for [this] and merges them keeping all the values
  ///of [this].
  UserAppModel copyWithUsingJson(UserAppModel? newUser) {
    if (newUser == null) return this;
    final thisJson = toJson();
    final newUserJson = newUser.toJson();
    //Merging this with newUser makes sure customAccessToken
    //is not overwritten
    newUserJson.addAll(thisJson);
    //Since the app currently allows changing the phoneNumber and email
    //these values are always the newUser values
    return UserAppModel.fromJson(newUserJson)
      ..setPhoneNumber(newUser.phoneNumber)
      ..setEmail(newUser.email);
  }

  @Deprecated('Will be removed in 4.0')

  ///Creates a copy of [this] with the new [phoneNumber]
  UserAppModel setPhoneNumber(String? phoneNumber) =>
      copyWith(phoneNumber: phoneNumber);

  @Deprecated('Will be removed in 4.0')

  ///Creates a copy of this with the new [email]
  UserAppModel setEmail(String? email) => copyWith(email: email);
}
