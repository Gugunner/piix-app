import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
class BreakdownTicketBenefitsExpansionListDeprecated extends StatelessWidget {
  const BreakdownTicketBenefitsExpansionListDeprecated({
    super.key,
    required this.additionalBenefits,
  });
  final List<BenefitPerSupplierModel> additionalBenefits;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
      child: ExpansionTile(
        collapsedBackgroundColor: PiixColors.greyWhite,
        backgroundColor: PiixColors.greyWhite,
        textColor: PiixColors.infoDefault,
        iconColor: PiixColors.darkSkyBlue,
        collapsedIconColor: PiixColors.darkSkyBlue,
        title: Text(
          PiixCopiesDeprecated.breakdownBenefits,
          style: context.primaryTextTheme?.titleSmall,
        ),
        childrenPadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: additionalBenefits.map(
          (additionalBenefitPerSupplier) {
            final index =
                additionalBenefits.indexOf(additionalBenefitPerSupplier) + 1;
            return Container(
              padding: EdgeInsets.only(top: 8.h),
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ConstantsDeprecated.mediumPadding.w,
                    ),
                    child: Text(
                      additionalBenefitPerSupplier.benefit.name,
                      style: context.textTheme?.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ConstantsDeprecated.mediumPadding.w,
                    ),
                    child: CoverageOfferDescriptionWidgetDeprecated(
                      coverageOfferType:
                          additionalBenefitPerSupplier.coverageOfferType,
                      coverageOfferValue:
                          additionalBenefitPerSupplier.coverageOfferValue,
                      hasCobenefits: additionalBenefitPerSupplier.hasCobenefits,
                      removeEventsSuffix: false,
                      textStyle: context.textTheme?.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                    ),
                    child: Html(
                      data: additionalBenefitPerSupplier.wordingZero,
                      style: {
                        'p': Style(
                          color: PiixColors.infoDefault,
                          fontFamily: 'Raleway',
                          fontSize: FontSize(
                            10.sp,
                          ),
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.justify,
                          lineHeight: LineHeight.em(1),
                        ),
                      },
                    ),
                  ),
                  if (index < additionalBenefits.length)
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
