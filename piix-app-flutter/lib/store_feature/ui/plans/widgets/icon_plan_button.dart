import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:provider/provider.dart';

///This widget is a add or remove button, depends a button type,
///use maxUsersInPlan and protectedAcquired to validate the onTap button
///
class IconPlanButton extends StatelessWidget {
  const IconPlanButton({
    super.key,
    required this.type,
    required this.maxUsersInPlan,
    required this.protectedAcquired,
    required this.onTap,
  });
  final PlanButtonDeprecated type;
  final int maxUsersInPlan;
  final int protectedAcquired;
  final VoidCallback onTap;

  IconData get icon => type == PlanButtonDeprecated.remove
      ? protectedAcquired == 1
          ? Icons.delete
          : Icons.remove
      : Icons.add;
  bool get limitReached =>
      maxUsersInPlan == protectedAcquired && type == PlanButtonDeprecated.add;

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.watch<PlansBLoCDeprecated>();
    final currentMaxProtectedNumber =
        (plansBLoC.plansList?.protectedLimit ?? 0) -
            (plansBLoC.plansList?.totalProtectedAcquired ?? 0);
    final generalLimitReached =
        currentMaxProtectedNumber == plansBLoC.protectedCount &&
            type == PlanButtonDeprecated.add;
    return InkWell(
      onTap: limitReached || generalLimitReached ? null : onTap,
      child: Container(
        height: 25.h,
        width: 25.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: limitReached || generalLimitReached
              ? PiixColors.clicInactive
              : PiixColors.activeButton,
        ),
        child: Icon(
          icon,
          color: PiixColors.white,
        ),
      ),
    );
  }
}
