import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

extension BuyingTipsExtension on StoreModuleDeprecated {
  String firstParagraph({String? productName, String? duplicateIn}) {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.benefitDuplicate(
            productName: productName ?? '', duplicateIn: duplicateIn ?? '');
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.comboDuplicate(
            productName: productName ?? '', duplicateIn: duplicateIn ?? '');
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.planDuplicateOne;
      default:
        return '';
    }
  }

  String get secondParagraph {
    switch (this) {
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.planDuplicateTwo;
      default:
        return '';
    }
  }

  String get firstTipBold {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.buyBothTipOne;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.buyPlanTipOne;
      default:
        return '';
    }
  }

  String get firstTipNormal {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.buyBothTipTwo;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.buyPlanTipTwo;
      default:
        return '';
    }
  }

  String get secondTipBold {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.buySeparateTipOne;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.buyAllCoverageTipOne;
      default:
        return '';
    }
  }

  String get secondTipNormal {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.buySeparateTipTwo;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.buyAllCoverageTipTwo;
      default:
        return '';
    }
  }
}
