import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/invoice_product_dialog_deprecated/invoice_product_dialog_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/enhanced_coverage_table_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/meaning_table_color_deprecated.dart';
import 'package:provider/provider.dart';

class LevelSectionDialog extends StatelessWidget {
  const LevelSectionDialog({Key? key}) : super(key: key);
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final currentInvoiceTicket = purchaseInvoiceBLoC.invoice;
    final invoiceLevel = currentInvoiceTicket?.products.level;
    final currentLevel =
        membershipBLoC.selectedMembership?.usersMembershipLevel.name;
    return InvoiceProductDialogDeprecated(
      child: SizedBox(
        width: context.width,
        child: Column(
          children: [
            Text(
              PiixCopiesDeprecated.benefitsWithBetterCoverage,
              textAlign: TextAlign.center,
              style: context.textTheme?.headlineSmall,
            ),
            SizedBox(
              height: mediumPadding.h,
            ),
            Text(
              PiixCopiesDeprecated.instructionEnhancedCoverageDialog,
              style: context.textTheme?.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: mediumPadding.h,
            ),
            SizedBox(
              width: context.width,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: '${PiixCopiesDeprecated.levelLabel}: ',
                    ),
                    TextSpan(
                      text: currentLevel,
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                  ],
                  style: context.textTheme?.bodyMedium,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 12.h,
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
              height: 6.h,
            ),
            const MeaningTableColorDeprecated(
              meaningColor: PiixColors.blueTable,
              meaningText: PiixCopiesDeprecated.quotedLevelBenefit,
            ),
            SizedBox(
              height: 6.h,
            ),
            const MeaningTableColorDeprecated(
              borderColor: PiixColors.tertiaryText,
              meaningText: PiixCopiesDeprecated.includedBenefitInMembership,
            ),
            SizedBox(
              height: mediumPadding.h,
            ),
            if (invoiceLevel?.comparisonInformation != null)
              EnhancedCoverageTableDeprecated(
                comparisonInformation: invoiceLevel!.comparisonInformation!,
              ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              child: Text(
                PiixCopiesDeprecated.quantityInMXN,
                style: context.accentTextTheme?.bodySmall?.copyWith(
                  color: PiixColors.infoDefault,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
