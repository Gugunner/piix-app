import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/model/benefit_per_supplier_coverage_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/widgets_deprecated/coverage_offer_description_widget_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a level detail item, includes a name of benefit,
///the coverage of benefit and the wording zero of benefit
///
class LevelDetailItemDeprecated extends StatelessWidget {
  const LevelDetailItemDeprecated({
    super.key,
    required this.benefitPerSupplier,
    required this.index,
    this.benefitsLength = 0,
    this.isNewBenefitPerSupplier = false,
  });
  final BenefitPerSupplierCoverageModel benefitPerSupplier;
  final bool isNewBenefitPerSupplier;
  final int benefitsLength;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ConstantsDeprecated.mediumPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              benefitPerSupplier.benefitName,
              style: context.textTheme?.bodyMedium,
            ),
            SizedBox(
              height: 4.h,
            ),
            CoverageOfferDescriptionWidgetDeprecated(
              coverageOfferType: benefitPerSupplier.coverageOfferType,
              coverageOfferValue: benefitPerSupplier.newCoverageOfferValue,
              hasCobenefits: benefitPerSupplier.hasCobenefits,
              removeEventsSuffix: false,
            ),
            Transform.translate(
              offset: Offset(-8, -4.h),
              child: Html(
                data: '''${benefitPerSupplier.wordingZero}''',
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
                  'li': Style(
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
            if (index != benefitsLength)
              Transform.translate(
                offset: Offset(0, -10.h),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  child: const Divider(
                    thickness: 1,
                    height: 0,
                    color: PiixColors.secondaryLight,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
