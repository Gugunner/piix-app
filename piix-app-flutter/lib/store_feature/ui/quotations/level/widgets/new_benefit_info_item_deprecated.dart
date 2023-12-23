import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/level_cobenefits_list_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a new benefit info detail, includes wording zero,
///supplier, and cobenefits list
///
class NewBenefitInfoItemDeprecated extends StatelessWidget {
  const NewBenefitInfoItemDeprecated({
    super.key,
    required this.benefitPerSupplier,
    required this.showDetailBenefit,
    required this.handleShowDetail,
  });
  final BenefitPerSupplierModel benefitPerSupplier;
  final bool showDetailBenefit;
  final VoidCallback handleShowDetail;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: PiixColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            data: '''${benefitPerSupplier.wordingZero}''',
            style: {
              'p': Style(
                color: PiixColors.secondary,
                fontFamily: 'Raleway',
                fontSize: FontSize(
                  12.sp,
                ),
                letterSpacing: 0.1,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
                lineHeight: LineHeight.em(1),
              )
            },
          ).padBottom(4.h).padHorizontal(10.w),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${PiixCopiesDeprecated.supplier}: ',
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.secondary,
                ),
              ),
              TextSpan(text: '${benefitPerSupplier.supplier?.name ?? ''}'),
            ]),
            style: context.textTheme?.bodyMedium?.copyWith(
              color: PiixColors.secondary,
            ),
          ).padHorizontal(mediumPadding.w).padBottom(16.h),
          if (benefitPerSupplier.hasCobenefits)
            LevelCobenefitsListDeprecated(
              cobenefitsPerSupplier: benefitPerSupplier.cobenefitsPerSupplier,
              titleStyle: context.primaryTextTheme?.titleSmall?.copyWith(
                color: PiixColors.secondary,
              ),
              listStyle: context.textTheme?.bodyMedium?.copyWith(
                color: PiixColors.secondary,
              ),
              isQuotation: true,
            ).padHorizontal(mediumPadding.w),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                handleShowDetail();
              },
              child: Text(
                showDetailBenefit
                    ? PiixCopiesDeprecated.viewLessText
                    : PiixCopiesDeprecated.viewMoreText,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.active,
                ),
              ),
            ),
          ).padHorizontal(mediumPadding.w).padBottom(8.h)
        ],
      ),
    );
  }
}
