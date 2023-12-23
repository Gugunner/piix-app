import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a list of cobenefits.
///
class LevelCobenefitsListDeprecated extends StatelessWidget {
  const LevelCobenefitsListDeprecated({
    super.key,
    required this.cobenefitsPerSupplier,
    this.listStyle,
    this.titleStyle,
    this.isQuotation = false,
  });

  final List<BenefitPerSupplierModel> cobenefitsPerSupplier;
  final TextStyle? titleStyle;
  final TextStyle? listStyle;
  final bool isQuotation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.coBenefits,
          style: titleStyle ??
              context.primaryTextTheme?.titleSmall?.copyWith(
                color: PiixColors.secondary,
              ),
        ),
        ...cobenefitsPerSupplier.map(
          (cobenefit) {
            final coverageText = calculateCoverageText(cobenefit);
            final coverage = isQuotation ? coverageText : '';

            final index = cobenefitsPerSupplier.indexOf(cobenefit) + 1;
            final padBottom = index == cobenefitsPerSupplier.length ? 16 : 0;
            return Padding(
              padding: EdgeInsets.only(
                left: 12,
                bottom: padBottom.h,
              ),
              child: Text(
                '•  ${cobenefit.benefit.name}: $coverage',
                style: listStyle ??
                    context.textTheme?.bodyMedium?.copyWith(
                      color: PiixColors.secondary,
                    ),
              ),
            );
          },
        ),
      ],
    );
  }

  String calculateCoverageText(BenefitPerSupplierModel cobenefitPerSupplier) {
    final coverageOfferType = cobenefitPerSupplier.coverageOfferType;
    final coverageOfferValue = cobenefitPerSupplier.coverageOfferValue;
    return BenefitPerSupplierCopiesDeprecated.coverageDescription(
        coverageOfferType, coverageOfferValue);
  }
}
