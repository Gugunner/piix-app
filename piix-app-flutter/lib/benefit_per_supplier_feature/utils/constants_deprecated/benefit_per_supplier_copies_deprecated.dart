import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';

@Deprecated('Will be removed in 4.0')
class BenefitPerSupplierCopiesDeprecated {
  static String coverageTextType(String coverageOfferType) {
    if (coverageOfferType == ConstantsDeprecated.sumInsured)
      return PiixCopiesDeprecated.summedTotalPremium;
    if (coverageOfferType == ConstantsDeprecated.events)
      return PiixCopiesDeprecated.events;
    return '';
  }

  static String coverageDescription(
    String coverageOfferType,
    double coverageOfferValue, {
    bool removeCurrencySymbol = false,
    bool removeEventsSuffix = false,
  }) {
    if (coverageOfferType == ConstantsDeprecated.sumInsured) {
      return '${ConstantsDeprecated.moneySymbol}'
          '${coverageOfferValue.currencyFormat} '
          '${removeCurrencySymbol ? '' : ConstantsDeprecated.mxn}';
    }
    final coverageText = '${coverageOfferValue.toStringAsFixed(0)}';
    if (removeEventsSuffix) {
      return coverageText;
    }
    return '$coverageText ${BenefitPerSupplierCopiesDeprecated.coverageTextType(
      coverageOfferType,
    )}${coverageOfferValue.toInt().pluralWithS}'
        .toLowerCase();
  }

  static const assistance = 'Asistencia';
  static const insurance = 'Seguro';
  static const service = 'Servicio';
  static const reward = 'Recompensa';
  static const store = 'Tienda';
}
