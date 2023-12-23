import 'package:flutter/material.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a coverage type text, includes coverage type and
///coverage value
///
class CurrentCoverageDeprecated extends StatelessWidget {
  const CurrentCoverageDeprecated({
    super.key,
    required this.coverageOfferType,
    required this.coverageOfferValue,
    this.textStyle,
    this.removeCurrency = false,
  });
  final String coverageOfferType;
  final double coverageOfferValue;
  final TextStyle? textStyle;
  final bool removeCurrency;

  String get text {
    final coverageDescription =
        BenefitPerSupplierCopiesDeprecated.coverageDescription(
      coverageOfferType,
      coverageOfferValue,
      removeCurrencySymbol: true,
    );
    if (coverageOfferType == ConstantsDeprecated.sumInsured) {
      return '$coverageDescription '
          '${removeCurrency ? '' : '\n${ConstantsDeprecated.mxn}'}';
    }
    return '$coverageDescription${coverageOfferValue.toInt().pluralWithS}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? context.primaryTextTheme?.bodyMedium,
      textAlign: TextAlign.center,
    );
  }
}
