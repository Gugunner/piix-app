import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/coverage_offer_description_widget_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a breakdown of additional benefits per supplier prices
/// in combo
///
class BreakdownBenefitsQuoteExpansionListDeprecated extends StatelessWidget {
  const BreakdownBenefitsQuoteExpansionListDeprecated({
    super.key,
    required this.additionalBenefitsPerSupplier,
  });
  final List<BenefitPerSupplierModel> additionalBenefitsPerSupplier;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
      child: ExpansionTile(
        collapsedBackgroundColor: PiixColors.greyWhite,
        backgroundColor: PiixColors.greyWhite,
        textColor: PiixColors.mainText,
        iconColor: PiixColors.darkSkyBlue,
        collapsedIconColor: PiixColors.darkSkyBlue,
        title: Text(
          PiixCopiesDeprecated.breakdownBenefits,
          style: context.primaryTextTheme?.headlineSmall,
        ),
        childrenPadding: EdgeInsets.all(ConstantsDeprecated.mediumPadding.h),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: additionalBenefitsPerSupplier.map(
          (additionalBenefitPerSupplier) {
            final index = additionalBenefitsPerSupplier
                    .indexOf(additionalBenefitPerSupplier) +
                1;
            return SizedBox(
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    additionalBenefitPerSupplier.benefit.name,
                    style: context.textTheme?.bodyMedium,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CoverageOfferDescriptionWidgetDeprecated(
                    coverageOfferType:
                        additionalBenefitPerSupplier.coverageOfferType,
                    coverageOfferValue:
                        additionalBenefitPerSupplier.coverageOfferValue,
                    hasCobenefits: additionalBenefitPerSupplier.hasCobenefits,
                    textStyle: context.textTheme?.labelMedium,
                    removeEventsSuffix: false,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '${PiixCopiesDeprecated.outComboPrice}: '
                    '${ConstantsDeprecated.moneySymbol}'
                    '${additionalBenefitPerSupplier.productRates?.finalTotalPremium ?? ''}'
                    ' ${ConstantsDeprecated.mxn}',
                    style: context.textTheme?.labelMedium,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '${PiixCopiesDeprecated.supplier}: '
                    '${additionalBenefitPerSupplier.supplier?.name ?? ''}',
                    style: context.textTheme?.labelMedium,
                  ),
                  if (index < additionalBenefitsPerSupplier.length)
                    const Divider(
                      thickness: 1,
                      color: PiixColors.secondaryLight,
                    )
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
