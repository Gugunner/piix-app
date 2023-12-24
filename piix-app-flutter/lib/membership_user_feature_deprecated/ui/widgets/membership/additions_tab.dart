import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/my_combos_list.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/my_individuals_list.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/my_level_list.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/my_plans_list.dart';

/// Creates a tab with the additions about the membership.
class AdditionsTab extends StatelessWidget {
  const AdditionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PiixCopiesDeprecated.yourAdditions,
          style: context.textTheme?.titleMedium,
        ).padVertical(8.h).padLeft(8.w),
        const Card(
          margin: EdgeInsets.zero,
          elevation: 3,
          child: Column(
            children: [
              MyCombosList(),
              Divider(height: 0),
              MyIndividualsList(),
            ],
          ),
        ).padBottom(12.h),
        const MyPlanList().padHorizontal(6.w),
        Divider(height: 24.h).padHorizontal(6.w),
        const MyLevelList().padHorizontal(6.w),
      ],
    );
  }
}
