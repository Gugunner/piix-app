import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/level_detail_item_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/coverage_table_dialog_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class LevelDetailSectionDeprecated extends StatelessWidget {
  const LevelDetailSectionDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;
    if (membership == null) return const SizedBox();
    final membershipLevel = membership.usersMembershipLevel;
    final comparisonInformation = invoice.products.level?.comparisonInformation;
    if (comparisonInformation == null) return const SizedBox();
    final existingBenefits = comparisonInformation.allExistingBenefits;
    final newBenefits = comparisonInformation.newBenefitsWithCoverageModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.newCoverageApplyForAll,
          style: context.textTheme?.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        Card(
          child: Theme(
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
                PiixCopiesDeprecated.breakDownLevel,
                style: context.primaryTextTheme?.titleSmall,
              ),
              childrenPadding: EdgeInsets.zero,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ConstantsDeprecated.mediumPadding,
                  ),
                  child: Text(
                    PiixCopiesDeprecated.improvedLevelBenefitsTicket,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: PiixColors.mainText),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ...existingBenefits.map(
                  (newBenefit) {
                    final index = existingBenefits.indexOf(newBenefit) + 1;
                    return LevelDetailItemDeprecated(
                      benefitPerSupplier: newBenefit,
                      index: index,
                      benefitsLength: existingBenefits.length,
                    );
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                if (newBenefits.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ConstantsDeprecated.mediumPadding,
                    ),
                    child: Text(
                      '${PiixCopiesDeprecated.newBenefits}:',
                      style: context.primaryTextTheme?.titleSmall,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ...newBenefits.map(
                    (newBenefit) {
                      final index = newBenefits.indexOf(newBenefit) + 1;
                      return LevelDetailItemDeprecated(
                        benefitPerSupplier: newBenefit,
                        index: index,
                        benefitsLength: newBenefits.length,
                        isNewBenefitPerSupplier: true,
                      );
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        if (invoice.products.level!.levelId != membershipLevel.levelId)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => handleOpenLevelDialog(context),
              child: Text(
                '${PiixCopiesDeprecated.viewThisLevel}',
                style: context.accentTextTheme?.headlineLarge?.copyWith(
                  color: PiixColors.active,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void handleOpenLevelDialog(BuildContext context) {
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    final invoiceLevel = invoice.products.level;
    if (invoiceLevel?.comparisonInformation == null) return;
    final invoiceLevelName = invoiceLevel!.name;
    final currentLevelName =
        membershipBLoC.selectedMembership?.usersMembershipLevel.name ?? '';
    showDialog<void>(
      context: context,
      barrierColor: PiixColors.mainText.withOpacity(0.62),
      builder: (context) => CoverageTableDialogDeprecated(
        compareBenefitPerSupplierModel: invoiceLevel.comparisonInformation!,
        newLevelName: invoiceLevelName,
        currentLevelName: currentLevelName,
      ),
    );
  }
}
