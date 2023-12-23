import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/model/benefit_per_supplier_coverage_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/compare_benefits_per_supplier_model.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/current_coverage_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a enhanced coverage table, contains comparison of level
///benefits.
///
class EnhancedCoverageTableDeprecated extends StatelessWidget {
  const EnhancedCoverageTableDeprecated({
    super.key,
    required this.comparisonInformation,
  });
  final CompareBenefitsPerSupplierModel comparisonInformation;

  List<String> get tableHeaders => [
        PiixCopiesDeprecated.benefitAndCobenefits,
        PiixCopiesDeprecated.currentCoverage,
        PiixCopiesDeprecated.levelCoverage,
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            spreadRadius: 4,
            blurRadius: 8,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Table(
        columnWidths: {
          0: const FlexColumnWidth(1.5),
          1: const FlexColumnWidth(1),
          2: const FlexColumnWidth(1),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(color: PiixColors.primary),
            children: tableHeaders
                .map(
                  (header) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
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
          ...comparisonInformation
              .existingAdditionalBenefitsWithCoverageOfferValues
              .map(
            (benefit) => buildCoverageComparisonTableRow(
              context,
              benefit: benefit,
            ),
          ),
          ...comparisonInformation
              .existingBenefitsAndCobenefitsWithCoverageOfferValues
              .map(
            (benefit) => buildCoverageComparisonTableRow(
              context,
              benefit: benefit,
              color: PiixColors.space,
            ),
          ),
        ],
      ),
    );
  }

  TableRow buildCoverageComparisonTableRow(
    BuildContext context, {
    required BenefitPerSupplierCoverageModel benefit,
    Color color = PiixColors.cloud,
  }) =>
      TableRow(
        decoration: BoxDecoration(color: color),
        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 4.w,
              ),
              child: Text(
                benefit.benefitName,
                style: context.textTheme?.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: CurrentCoverageDeprecated(
              coverageOfferValue: benefit.oldCoverageOfferValue,
              coverageOfferType: benefit.coverageOfferType,
              textStyle: context.textTheme?.bodyMedium,
              removeCurrency: true,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: CurrentCoverageDeprecated(
              coverageOfferValue: benefit.newCoverageOfferValue,
              coverageOfferType: benefit.coverageOfferType,
              textStyle: context.textTheme?.bodyMedium,
              removeCurrency: true,
            ),
          ),
        ],
      );
}
