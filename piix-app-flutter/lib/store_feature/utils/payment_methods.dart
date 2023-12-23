import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/payment_method_model.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/receipt_actions_row_deprecated.dart';

import '../../ui/model/payment_method_ui_model.dart';

//This is a payment modules
final paymentModules = [
  StoreModuleDeprecated.plan,
  StoreModuleDeprecated.combo,
  StoreModuleDeprecated.additionalBenefit,
  StoreModuleDeprecated.level,
];

///From [paymetMethod], a list of payment places is returned
List<PaymentMethodUiModel> getFirstPaymentMethod({
  required PaymentMethodModel method,
}) {
  final id = method.id;
  switch (id) {
    case ConstantsDeprecated.oxxoId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.oxxoLogo)
      ];
    case ConstantsDeprecated.banamexId:
      return [
        PaymentMethodUiModel(
            name: method.name, asset: PiixAssets.citibanamexLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.telecomm, asset: PiixAssets.telecomLogo),
      ];
    case ConstantsDeprecated.santanderId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.santanderLogo)
      ];
    case ConstantsDeprecated.payCashId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.paycashLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.sevenEleven,
            asset: PiixAssets.sevenElevenLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.circleK, asset: PiixAssets.circleKLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.soriana, asset: PiixAssets.sorianaLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.extraSuper, asset: PiixAssets.extraLogo),
      ];
    case ConstantsDeprecated.bancomerId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.bbvaLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.farmaciaDelAhorro,
            asset: PiixAssets.farmaciaDelAhorroLogo),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.casaLey, asset: PiixAssets.leyLogo),
      ];

    default:
      return [];
  }
}

///From [paymetMethod], a list of payment places is returned
List<PaymentMethodUiModel> getPaymentPlacesForReceipt(
    {required PaymentMethodModel method}) {
  final _id = method.id;
  switch (_id) {
    case ConstantsDeprecated.oxxoId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.oxxo_line)
      ];
    case ConstantsDeprecated.banamexId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.citi_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.telecomm,
            asset: PiixAssets.telecom_line),
      ];
    case ConstantsDeprecated.santanderId:
      return [
        PaymentMethodUiModel(
            name: method.name, asset: PiixAssets.santander_line)
      ];
    case ConstantsDeprecated.payCashId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.paycash_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.sevenEleven,
            asset: PiixAssets.seven_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.circleK, asset: PiixAssets.k_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.soriana, asset: PiixAssets.soriana_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.extraSuper,
            asset: PiixAssets.extra_line),
      ];
    case ConstantsDeprecated.bancomerId:
      return [
        PaymentMethodUiModel(name: method.name, asset: PiixAssets.bbva_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.farmaciaDelAhorro,
            asset: PiixAssets.ahorro_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.casaLey, asset: PiixAssets.ley_line),
      ];

    default:
      return [];
  }
}

///From [paymetMethod], a list of payment places is returned
List<PaymentMethodUiModel> getPaymentPlacesForPaymentLine(
    {required String methodId, required String methodName}) {
  switch (methodId) {
    case ConstantsDeprecated.oxxoId:
      return [
        PaymentMethodUiModel(name: methodName, asset: PiixAssets.oxxo_line)
      ];
    case ConstantsDeprecated.banamexId:
      return [
        PaymentMethodUiModel(name: methodName, asset: PiixAssets.citi_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.telecomm,
            asset: PiixAssets.telecom_line),
      ];
    case ConstantsDeprecated.santanderId:
      return [
        PaymentMethodUiModel(name: methodName, asset: PiixAssets.santander_line)
      ];
    case ConstantsDeprecated.payCashId:
      return [
        PaymentMethodUiModel(name: methodName, asset: PiixAssets.paycash_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.sevenEleven,
            asset: PiixAssets.seven_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.circleK, asset: PiixAssets.k_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.soriana, asset: PiixAssets.soriana_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.extraSuper,
            asset: PiixAssets.extra_line),
      ];
    case ConstantsDeprecated.bancomerId:
      return [
        PaymentMethodUiModel(name: methodName, asset: PiixAssets.bbva_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.farmaciaDelAhorro,
            asset: PiixAssets.ahorro_line),
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.casaLey, asset: PiixAssets.ley_line),
      ];

    default:
      return [];
  }
}

///From [paymetMethod], a list of payment places is returned
List<PaymentMethodUiModel> getPaymentPlacesSecondRow(
    {required PaymentMethodModel method}) {
  final _id = method.id;
  switch (_id) {
    case ConstantsDeprecated.payCashId:
      return [
        const PaymentMethodUiModel(
            name: PiixCopiesDeprecated.calimax, asset: PiixAssets.calimaxLogo),
      ];
    default:
      return [];
  }
}

///Gets a payment places names
///
String getPaymentPlaceNames({required PaymentMethodModel paymentMethod}) {
  final _id = paymentMethod.id;
  switch (_id) {
    case ConstantsDeprecated.oxxoId:
      return paymentMethod.name;
    case ConstantsDeprecated.banamexId:
      return [
        paymentMethod.name,
        PiixCopiesDeprecated.telecomm,
      ].join(', ');
    case ConstantsDeprecated.santanderId:
      return paymentMethod.name;
    case ConstantsDeprecated.payCashId:
      return [
        paymentMethod.name,
        PiixCopiesDeprecated.sevenEleven,
        PiixCopiesDeprecated.circleK,
        PiixCopiesDeprecated.soriana,
        PiixCopiesDeprecated.extraSuper,
      ].join(', ');
    case ConstantsDeprecated.bancomerId:
      return [
        paymentMethod.name,
        PiixCopiesDeprecated.farmaciaDelAhorro,
        PiixCopiesDeprecated.casaLey,
      ].join(', ');
    default:
      return '';
  }
}

extension PaymentsStringExtension on String {
  String get removeLineBreak => replaceAll('\n', '');
  String get typeOfPaymentText {
    switch (this) {
      case ConstantsDeprecated.oxxoId:
      case ConstantsDeprecated.payCashId:
        return PiixCopiesDeprecated.validityOfPaymentLineLabel;
      default:
        return PiixCopiesDeprecated.validityOfReferenceLabel;
    }
  }

  ///Get a step two of instructions dialog in receipt payment
  ///
  String get stepTwoToMakePayment {
    switch (this) {
      case ConstantsDeprecated.oxxoId:
        return PiixCopiesDeprecated.goToAnyOxxo;
      case ConstantsDeprecated.payCashId:
        return PiixCopiesDeprecated.goToConvenienceStores;
      case ConstantsDeprecated.bancomerId:
      case ConstantsDeprecated.banamexId:
        return PiixCopiesDeprecated.goToBanksOrStores;
      case ConstantsDeprecated.santanderId:
        return PiixCopiesDeprecated.goToSantander;
      default:
        return '';
    }
  }

  String get getCatchLineFormat {
    var catchLineFormat = '';
    var remainingLength = length;
    const numberOfDigits = 4;

    for (var i = 0; i < length; i += numberOfDigits) {
      final currentStartIndex = length - remainingLength;
      if (remainingLength % numberOfDigits == 0) {
        catchLineFormat +=
            '${substring(currentStartIndex, i + numberOfDigits)} ';
      } else {
        catchLineFormat += substring(currentStartIndex, length);
      }
      remainingLength -= numberOfDigits;
    }
    return catchLineFormat;
  }
}

extension PaymentsNullableProductTypeExtension on ProductTypeDeprecated {
  ///Get text of payment module
  String get getTextOfPaymentByProductType {
    switch (this) {
      case ProductTypeDeprecated.ADDITIONAL:
        return PiixCopiesDeprecated.benefitLabel;
      case ProductTypeDeprecated.COMBO:
        return PiixCopiesDeprecated.comboLabel;
      case ProductTypeDeprecated.PLAN:
        return PiixCopiesDeprecated.planLabel;
      case ProductTypeDeprecated.LEVEL:
        return PiixCopiesDeprecated.levelLabel;
      default:
        return '';
    }
  }
}

extension PaymentsExtension on StoreModuleDeprecated {
  ///Get total buy text of payment
  String get getTotalBuyTextExtension {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.priceToBuyBenefit;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.priceToBuyCombo;
      case StoreModuleDeprecated.plan:
        return '${PiixCopiesDeprecated.totalPriceToAdd} tu(s)';
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.priceToBuyLevel;
      default:
        return '';
    }
  }

  ///Get text of payment module
  String get getTextOfPayment {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.benefitLabel;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.comboLabel;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.planLabel;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.levelLabel;
      default:
        return '';
    }
  }

  ///Get text of home payment
  String get storeModuleTitle {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.benefits;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.addToProtecteds;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.upgradeMembershipLabel;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.exploreOurComboOffers;
      default:
        return '';
    }
  }

  ///Get text of button payment
  String get getTextOfButtonPayments {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.exploreBenefits;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.addProtectedButton;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.knowLevels;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.seeCombos;
      default:
        return '';
    }
  }

  ///Get the first word of instruction in home payment screen
  String get getFirstInstructionWord {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.firstWordBenefits;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.firstWordPlans;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.firstWordLevels;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.firstWordCombo;
      default:
        return '';
    }
  }

  ///Get the second phrase of instruction in home payment screen
  String get getSecondInstructionPhrase {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.typeOfBenefitLabel;
      default:
        return '';
    }
  }

  ///Get the complement text of instruction in home payment screen
  String get getComplementInstructionPhrase {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.benefitsResume;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.plansResume;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.levelsResume;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.comboResume;
      default:
        return '';
    }
  }

  ///Get the complement text of instruction in home payment screen
  String get getSlogan {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.benefitSlogan;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.discoverSpecialOffers;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.discoverSpecialOffers;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.comboSlogan;
      default:
        return '';
    }
  }

  ///Get the image for home payment screen
  String get getImageOfModulePayment {
    switch (this) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixAssets.homeBenefitImage;
      case StoreModuleDeprecated.plan:
        return PiixAssets.homePlanImage;
      case StoreModuleDeprecated.level:
        return PiixAssets.homeLevelImage;
      case StoreModuleDeprecated.combo:
        return PiixAssets.homeCombosImage;
      default:
        return '';
    }
  }
}

extension PaymentsTypeExtend on AlertTypeDeprecated {
  ///Gets an alert color by alert type
  Color get getPaymentsAlertColor {
    switch (this) {
      case AlertTypeDeprecated.success:
        return PiixColors.successMain;
      case AlertTypeDeprecated.error:
        return PiixColors.errorMain;
      default:
        return Colors.transparent;
    }
  }

  ///Gets a plan alert message by alert type
  String get getPaymentTitleAlertMessage {
    switch (this) {
      case AlertTypeDeprecated.success:
        return PiixCopiesDeprecated.generatedPurchaseTicket;
      case AlertTypeDeprecated.error:
      default:
        return '';
    }
  }

  ///Gets a plan alert message by alert type
  IconData get getPaymentTitleAlertIcon {
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
  String get getPaymentSubTitleAlertMessage {
    switch (this) {
      case AlertTypeDeprecated.success:
        return PiixCopiesDeprecated.detailsInRecord;
      case AlertTypeDeprecated.error:
        return PiixCopiesDeprecated.paymentLineError;
      case AlertTypeDeprecated.badRequest:
        return PiixCopiesDeprecated.badRequestAlert;
      default:
        return '';
    }
  }
}

extension PaymentModelExtend on PaymentMethodModel {}

extension ReceiptActionsExtend on ReceiptActionsDeprecated {
  ///This method gets an icon from receipt action
  ///
  IconData get getIcon {
    switch (this) {
      case ReceiptActionsDeprecated.download:
        return Icons.file_download_outlined;
      case ReceiptActionsDeprecated.instructions:
        return Icons.help_outline;
    }
  }

  ///This method gets an label from receipt action
  ///
  String get getLabel {
    switch (this) {
      case ReceiptActionsDeprecated.download:
        return PiixCopiesDeprecated.download;
      case ReceiptActionsDeprecated.instructions:
        return PiixCopiesDeprecated.instructionLabel;
    }
  }
}

String availablePaymentPlaces({required String id, required String name}) {
  switch (id) {
    case ConstantsDeprecated.oxxoId:
      return PiixCopiesDeprecated.anyOxxoStore(name.capitalize());
    case ConstantsDeprecated.banamexId:
      return '$name, y ${PiixCopiesDeprecated.telecomm}';
    case ConstantsDeprecated.santanderId:
      return '${PiixCopiesDeprecated.banks} ${name.capitalize()}';
    case ConstantsDeprecated.payCashId:
      return '${PiixCopiesDeprecated.sevenEleven}, ${PiixCopiesDeprecated.circleK}, '
          '${PiixCopiesDeprecated.soriana}, ${PiixCopiesDeprecated.extraSuper} y '
          '${PiixCopiesDeprecated.calimax}';
    case ConstantsDeprecated.bancomerId:
      return '$name, ${PiixCopiesDeprecated.farmaciaDelAhorro} y ${PiixCopiesDeprecated.casaLey}';
    default:
      return '';
  }
}
