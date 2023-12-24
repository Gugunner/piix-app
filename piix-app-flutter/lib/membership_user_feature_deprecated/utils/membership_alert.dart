import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

extension MembershipAlertExtend on MembershipAlert {
  String get getTitleTopAlert {
    switch (this) {
      //TODO:THIS CODE IS DEPRECATED IN NEW RELEASE SHOULD REMOVED
      /* 
         case MembershipAlert.basicInformation:
        return PiixCopies.basicInfoNotFull;
        case MembershipAlert.emptyBasicForm:
        return PiixCopies.appFailure;
         */
      case MembershipAlert.basicMembership:
        return PiixCopiesDeprecated.notLoadedMembership;
      case MembershipAlert.additionalForms:
        return PiixCopiesDeprecated.youHaveAdditionalForms;
      case MembershipAlert.ticketsFound:
        return PiixCopiesDeprecated.yourRequestsContinuesMonitored;
      default:
        return '';
    }
  }

  String get getSubTitleTopAlert {
    switch (this) {
      //TODO:THIS CODE IS DEPRECATED IN NEW RELEASE SHOULD REMOVED
      /*  case MembershipAlert.basicInformation:
        return PiixCopies.fullTheBasicInfo;
      case MembershipAlert.emptyBasicForm:
        return PiixCopies.formInfoNotFound; */
      case MembershipAlert.basicMembership:
        return PiixCopiesDeprecated.couldRetry;
      case MembershipAlert.additionalForms:
        return PiixCopiesDeprecated.fillAdditionalForms;
      case MembershipAlert.ticketsFound:
        return PiixCopiesDeprecated.rememberYourRequest;
      default:
        return '';
    }
  }

  IconData get getIconTopAlert {
    if (this == MembershipAlert.ticketsFound) {
      return Icons.warning;
    }
    return Icons.error_outline;
  }

  Color get getColorTopAlert {
    if (this == MembershipAlert.ticketsFound) {
      return PiixColors.infoLight;
    }
    return PiixColors.errorMain;
  }

  String? get getActionText {
    if (this == MembershipAlert.basicMembership) {
      return PiixCopiesDeprecated.retry;
    }
    return PiixCopiesDeprecated.viewText;
  }
}
