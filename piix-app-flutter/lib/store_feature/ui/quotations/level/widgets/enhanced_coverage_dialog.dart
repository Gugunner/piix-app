import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/current_level_acquired_level_row.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/enhanced_coverage_table_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/meaning_table_color_deprecated.dart';
import 'package:provider/provider.dart';

///This widget is a enhanced coverage dialog, includes a table of comparison of
///benefits in level to acquired vs current level
///
class EnhancedCoverageDialog extends StatelessWidget {
  const EnhancedCoverageDialog({super.key});

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  List<String> get tableHeaders => [
        PiixCopiesDeprecated.benefitAndCobenefits,
        PiixCopiesDeprecated.currentCoverage,
        PiixCopiesDeprecated.levelCoverage,
      ];

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final levelQuotation = levelsBLoC.levelQuotation!;
    final currentQuotationLevel = levelQuotation.level;
    final currentLevel =
        membershipBLoC.selectedMembership?.usersMembershipLevel.name;
    return AlertDialog(
      insetPadding: EdgeInsets.all(8.w),
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child:
                            const Icon(Icons.clear, color: PiixColors.error)))
                .padBottom(mediumPadding.h),
            Text(
              PiixCopiesDeprecated.benefitsWithBetterCoverage,
              textAlign: TextAlign.center,
              style: context.textTheme?.headlineSmall,
            ).center().padBottom(mediumPadding.h),
            Text(
              PiixCopiesDeprecated.instructionEnhancedCoverageDialog,
              style: context.textTheme?.bodyMedium,
              textAlign: TextAlign.justify,
            ).padBottom(mediumPadding.h),
            CurrentLevelAcquiredLevelRow(
              currentQuotationLevel: currentQuotationLevel.name,
              currentLevel: currentLevel ?? '',
            ).padHorizontal(mediumPadding.w).padBottom(17.5.h),
            Text(
              PiixCopiesDeprecated.meaningColors,
              style: context.textTheme?.bodyMedium,
            ).padBottom(6.h),
            const MeaningTableColorDeprecated(
              meaningColor: PiixColors.cloud,
              meaningText: PiixCopiesDeprecated.quotedLevelBenefit,
            ).padBottom(6.h),
            const MeaningTableColorDeprecated(
              borderColor: PiixColors.secondary,
              meaningText: PiixCopiesDeprecated.includedBenefitInMembership,
            ).padBottom(mediumPadding.h),
            EnhancedCoverageTableDeprecated(
              comparisonInformation: levelQuotation.comparisonInformation,
            ).padBottom(12.h),
            Text(
              PiixCopiesDeprecated.quantityInMXN,
              style: context.primaryTextTheme?.labelLarge,
              textAlign: TextAlign.justify,
            ).padHorizontal(2.w),
            SizedBox(height: 16.h)
          ],
        ),
      ),
    );
  }
}
