import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/invoice_product_dialog_deprecated/invoice_product_dialog_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/compare_benefits_per_supplier_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/compared_level_titles_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/enhanced_coverage_table_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/meaning_table_color_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a enhanced coverage dialog, includes a table of comparison of
///benefits in level to acquired vs current level
///
class CoverageTableDialogDeprecated extends StatelessWidget {
  const CoverageTableDialogDeprecated({
    super.key,
    required this.compareBenefitPerSupplierModel,
    required this.newLevelName,
    required this.currentLevelName,
  });

  final CompareBenefitsPerSupplierModel compareBenefitPerSupplierModel;
  final String newLevelName;
  final String currentLevelName;

  @override
  Widget build(BuildContext context) {
    return InvoiceProductDialogDeprecated(
      child: SizedBox(
        width: context.width,
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Text(
              PiixCopiesDeprecated.benefitsWithBetterCoverage,
              textAlign: TextAlign.center,
              style: context.textTheme?.headlineSmall,
            ),
            SizedBox(
              height: ConstantsDeprecated.mediumPadding.h,
            ),
            Text(
              PiixCopiesDeprecated.instructionEnhancedCoverageDialog,
              style: context.textTheme?.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: ConstantsDeprecated.mediumPadding.h,
            ),
            ComparedLevelTitlesDeprecated(
              newLevelName: newLevelName,
              currentLevelName: currentLevelName,
            ),
            SizedBox(
              height: ConstantsDeprecated.mediumPadding.h,
            ),
            SizedBox(
              width: context.width,
              child: Text(
                PiixCopiesDeprecated.meaningColors,
                style: context.textTheme?.bodyMedium,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            const MeaningTableColorDeprecated(
              meaningColor: PiixColors.cloud,
              meaningText: PiixCopiesDeprecated.quotedLevelBenefit,
            ),
            SizedBox(
              height: 4.h,
            ),
            const MeaningTableColorDeprecated(
              borderColor: PiixColors.secondary,
              meaningText: PiixCopiesDeprecated.includedBenefitInMembership,
            ),
            SizedBox(
              height: ConstantsDeprecated.mediumPadding.h,
            ),
            EnhancedCoverageTableDeprecated(
              comparisonInformation: compareBenefitPerSupplierModel,
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.h,
              ),
              child: Text(
                PiixCopiesDeprecated.quantityInMXN,
                style: context.accentTextTheme?.bodySmall?.copyWith(
                  color: PiixColors.infoDefault,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
