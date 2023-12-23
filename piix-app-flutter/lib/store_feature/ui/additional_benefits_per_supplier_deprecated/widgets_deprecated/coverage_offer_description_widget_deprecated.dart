import 'package:flutter/material.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a coverage type text, includes coverage type and
///coverage value
///
class CoverageOfferDescriptionWidgetDeprecated extends StatelessWidget {
  const CoverageOfferDescriptionWidgetDeprecated({
    super.key,
    required this.coverageOfferType,
    required this.coverageOfferValue,
    this.hasCobenefits = false,
    this.removeEventsSuffix = false,
    this.textStyle,
  });
  final TextStyle? textStyle;
  final String coverageOfferType;
  final double coverageOfferValue;
  final bool hasCobenefits;
  final bool removeEventsSuffix;

  String get text {
    if (hasCobenefits) return PiixCopiesDeprecated.hasCobenefits;
    return BenefitPerSupplierCopiesDeprecated.coverageDescription(
      coverageOfferType,
      coverageOfferValue,
      removeEventsSuffix: removeEventsSuffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? context.textTheme?.labelMedium,
    );
  }
}
