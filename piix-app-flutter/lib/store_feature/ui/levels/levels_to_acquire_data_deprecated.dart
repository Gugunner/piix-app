import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/expandable_panel.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/benefits_level_table_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/header_membership_level_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/level_tab_column_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/levels/widgets/level_tooltip_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a card that contains the main details of the membership.
class LevelsToAcquireDataDeprecated extends StatelessWidget {
  const LevelsToAcquireDataDeprecated({super.key});

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: mediumPadding.w, vertical: 22.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  PiixCopiesDeprecated.levels,
                  style: context.primaryTextTheme?.displayMedium,
                ),
                const LevelTooltipDeprecated().padLeft(8.w)
              ],
            ).padBottom(14.5.h),
            Text(
              PiixCopiesDeprecated.improveCurrentBenefits,
              style: context.textTheme?.bodyMedium,
            ).padBottom(24.h),
            ExpandablePanel(
              elevation: 6,
              panelHeader: const HeaderMembershipLevelDeprecated(),
              panelBody: Card(
                margin: EdgeInsets.zero,
                elevation: 5,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.h),
                    child: const BenefitsLevelTableDeprecated()),
              ),
              buttonStyle: context.textTheme?.labelLarge?.copyWith(
                color: PiixColors.active,
              ),
              backgroundColor: PiixColors.space,
            ),
            SizedBox(height: 16.h),
            const LevelTabColumnDeprecated(),
          ],
        ),
      ),
    );
  }
}
