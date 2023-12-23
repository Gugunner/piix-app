import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/coverage_table_dialog_deprecated.dart';
import 'package:provider/provider.dart';

///This button is a enhaced coverage button, open a enhaced coverage dialog
///
class EnhancedCoverageButton extends StatelessWidget {
  const EnhancedCoverageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 36.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: PiixColors.process,
        ),
        onPressed: () => handleEnhancedCoverageDialog(context),
        child: Text(
          PiixCopiesDeprecated.viewEnhancedCoverage.toUpperCase(),
          style: context.primaryTextTheme?.titleMedium?.copyWith(
            color: PiixColors.space,
          ),
        ),
      ),
    );
  }

  void handleEnhancedCoverageDialog(BuildContext context) {
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    final membershipBLoC = context.read<MembershipProviderDeprecated>();
    final levelQuotation = levelsBLoC.levelQuotation;
    if (levelQuotation == null) return;
    final quotedLevelName = levelQuotation.level.name;
    final currentLevelName =
        membershipBLoC.selectedMembership?.usersMembershipLevel.name ?? '';
    showDialog<void>(
      context: context,
      builder: (_) => CoverageTableDialogDeprecated(
        compareBenefitPerSupplierModel: levelQuotation.comparisonInformation,
        newLevelName: quotedLevelName,
        currentLevelName: currentLevelName,
      ),
    );
  }
}
