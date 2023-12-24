import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/constants_deprecated/benefit_per_supplier_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/current_coverage_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This table render a current benefits for current level
///
class BenefitsLevelTableDeprecated extends StatelessWidget {
  const BenefitsLevelTableDeprecated({super.key});

  List<String> get tableHeaders => [
        PiixCopiesDeprecated.benefitAndCobenefits,
        PiixCopiesDeprecated.currentCoverage,
        PiixCopiesDeprecated.coverageType
      ];

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final membershipBenefit =
        levelsBLoC.userEcommerceLevels?.membershipBenefits ?? [];

    return SizedBox(
      child: Column(
        children: [
          Container(
            width: context.width,
            color: PiixColors.primary,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: Text(
                PiixCopiesDeprecated.benefitsOfMembership,
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.space,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: PiixColors.primary,
                ),
                children: tableHeaders
                    .map(
                      (header) => Padding(
                        padding: EdgeInsets.only(
                          bottom: 4.h,
                        ),
                        child: Text(
                          header,
                          textAlign: TextAlign.center,
                          style: context.textTheme?.bodyMedium?.copyWith(
                            color: PiixColors.space,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...membershipBenefit.map(
                (benefit) => TableRow(
                  decoration: BoxDecoration(
                      color: PiixColors.space,
                      border: Border.all(color: PiixColors.space)),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        benefit.benefitName,
                        style: context.textTheme?.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CurrentCoverageDeprecated(
                      coverageOfferValue: benefit.coverageOfferValue,
                      coverageOfferType: benefit.coverageOfferType,
                    ),
                    Text(
                      BenefitPerSupplierCopiesDeprecated.coverageTextType(
                        benefit.coverageOfferType,
                      ),
                      style: context.textTheme?.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
