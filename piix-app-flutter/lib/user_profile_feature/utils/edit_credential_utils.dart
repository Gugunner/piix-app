import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/user_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';

///Manages the different copies and colors the banner can have based
///on the [UserActionStateDeprecated] value.
///
extension UpdateEditCredentialCopies on EditCredentialType {
  String? get credentialTitle {
    final userBLoC = getIt<UserBLoCDeprecated>();
    switch (userBLoC.userActionState) {
      case UserActionStateDeprecated.updated:
        if (this == EditCredentialType.email) {
          return PiixCopiesDeprecated.successEditEmail;
        }
        return PiixCopiesDeprecated.successEditPhone;
      case UserActionStateDeprecated.notFound:
        return PiixCopiesDeprecated.userNotFound;
      case UserActionStateDeprecated.alreadyExists:
      case UserActionStateDeprecated.errorUpdating:
      case UserActionStateDeprecated.error:
        if (this == EditCredentialType.email) {
          return PiixCopiesDeprecated.errorEditEmail;
        }
        return PiixCopiesDeprecated.errorEditPhone;
      default:
        return null;
    }
  }

  String? get credentialSubtitle {
    final userBLoC = getIt<UserBLoCDeprecated>();
    switch (userBLoC.userActionState) {
      case UserActionStateDeprecated.updated:
        if (this == EditCredentialType.email) {
          return PiixCopiesDeprecated.successEditEmailContent;
        }
        return PiixCopiesDeprecated.successEditPhoneContent;
      case UserActionStateDeprecated.notFound:
        return PiixCopiesDeprecated.signInAgain;
      case UserActionStateDeprecated.alreadyExists:
      case UserActionStateDeprecated.errorUpdating:
      case UserActionStateDeprecated.error:
        if (this == EditCredentialType.email) {
          return PiixCopiesDeprecated.errorEditEmailContent;
        }
        return PiixCopiesDeprecated.errorEditPhoneContent;
      default:
        return null;
    }
  }

  String get dialogTitle {
    final user = getIt<UserBLoCDeprecated>().user;
    if (this == EditCredentialType.email) {
      if (user?.email != null) {
        return PiixCopiesDeprecated.editEmail;
      }
      return PiixCopiesDeprecated.addEmail;
    }
    if (user?.phoneNumber != null) {
      return PiixCopiesDeprecated.editPhone;
    }
    return PiixCopiesDeprecated.addPhone;
  }

  String get dialogMessage {
    final user = getIt<UserBLoCDeprecated>().user;
    if (this == EditCredentialType.email) {
      if (user?.email != null) {
        return PiixCopiesDeprecated.editEmailInstruction;
      }
      return PiixCopiesDeprecated.addEmailInstruction;
    }
    if (user?.phoneNumber != null) {
      return PiixCopiesDeprecated.editPhoneInstruction;
    }
    return PiixCopiesDeprecated.addPhoneInstruction;
  }

  String get credentialLabel {
    final user = getIt<UserBLoCDeprecated>().user;
    if (this == EditCredentialType.email) {
      if (user?.email != null) {
        return user!.email!;
      }
      return PiixCopiesDeprecated.noEmail;
    }
    if (user?.phoneNumber != null) {
      return '${user?.internationalPhoneCode ?? ConstantsDeprecated.mexicanLada}${user?.phoneNumber}';
    }
    return PiixCopiesDeprecated.noPhone;
  }
}

Color? get credentialColor {
  final userBLoC = getIt<UserBLoCDeprecated>();
  if (userBLoC.userActionState == UserActionStateDeprecated.updated) {
    return PiixColors.successMain;
  } else if (userBLoC.userActionState ==
          UserActionStateDeprecated.alreadyExists ||
      userBLoC.userActionState == UserActionStateDeprecated.errorUpdating ||
      userBLoC.userActionState == UserActionStateDeprecated.notFound ||
      userBLoC.userActionState == UserActionStateDeprecated.error) {
    return PiixColors.errorMain;
  }
  return null;
}

IconData? get credentialIcon {
  final userBLoC = getIt<UserBLoCDeprecated>();
  if (userBLoC.userActionState == UserActionStateDeprecated.updated) {
    return Icons.check_circle;
  } else if (userBLoC.userActionState ==
          UserActionStateDeprecated.alreadyExists ||
      userBLoC.userActionState == UserActionStateDeprecated.errorUpdating ||
      userBLoC.userActionState == UserActionStateDeprecated.notFound ||
      userBLoC.userActionState == UserActionStateDeprecated.error) {
    return Icons.error_outline;
  }
  return null;
}
