import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

extension PlanTypeExtend on AlertTypeDeprecated {
  ///Gets an alert color by alert type
  Color get getPlanAlertColor {
    switch (this) {
      case AlertTypeDeprecated.success:
        return PiixColors.successMain;
      case AlertTypeDeprecated.error:
        return PiixColors.errorMain;
      default:
        return Colors.transparent;
    }
  }

  IconData get getPlanAlertIcon {
    switch (this) {
      case AlertTypeDeprecated.success:
        return Icons.check_circle;
      case AlertTypeDeprecated.error:
        return Icons.info;
      default:
        return Icons.help;
    }
  }

  ///Gets a plan alert message by alert type
  String getPlanAlertMessage(String? name) {
    switch (this) {
      case AlertTypeDeprecated.success:
        return PiixCopiesDeprecated.successfulRemovePlan(name!);
      case AlertTypeDeprecated.error:
        return PiixCopiesDeprecated.quotationPlanError;
      default:
        return '';
    }
  }
}

extension PlanIntExtend on num {
  ///Gets protected buy text
  String get getProtectedBuyText {
    if (this == 1) {
      return '${PiixCopiesDeprecated.totalPriceToAdd} tu';
    } else if (this > 1) {
      return '${PiixCopiesDeprecated.totalPriceToAdd} tus';
    } else {
      return '';
    }
  }

  ///Gets protected label
  String get getProtectedLabel {
    if (this == 1) {
      return PiixCopiesDeprecated.protectedLabel.toLowerCase();
    } else if (this > 1) {
      return '$this ${PiixCopiesDeprecated.protectedText.toLowerCase()}';
    } else {
      return '';
    }
  }
}

extension PlanListExtend on List<PlanModel> {
  ///Get number of protected added
  int get getProtectedAddedNumber => map((e) => e.protectedAcquired)
      .reduce((value, element) => value + element);
}
