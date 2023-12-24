import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/add_plan_row.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/add_plan_selector.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/banner_plan_container.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/plan_footer.dart';
import 'package:provider/provider.dart';

///This widget render a plan list with protected acquired and protected to
///acquired
///
class CreatePlanData extends StatelessWidget {
  const CreatePlanData({super.key, required this.planUiState});
  final PlanUiStateDeprecated planUiState;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.watch<PlansBLoCDeprecated>();
    final membership = context.watch<MembershipProviderDeprecated>();
    final maxAgeCompliance =
        membership.selectedMembership?.maxAgeCompliance ?? 0;
    final planList = plansBLoC.plansList;
    final plansWithoutProtectedList = plansBLoC.plansWithoutProtectedList;
    final plansWithProtectedAcquiredList =
        plansBLoC.plansWithProtectedAcquiredList;
    final currentMaxProtectedNumber = (planList?.protectedLimit ?? 0) -
        (planList?.totalProtectedAcquired ?? 0);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BannerPlanContainer(),
                Text(
                  PiixCopiesDeprecated.configureYourProtected,
                  style: context.primaryTextTheme?.titleSmall,
                ).padHorizontal(mediumPadding.w).padBottom(19.h),
                SizedBox(
                  width: context.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${PiixCopiesDeprecated.maxProtectedNumber}: '
                            '$currentMaxProtectedNumber',
                            style:
                                context.primaryTextTheme?.labelLarge?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${plansBLoC.protectedCount}/'
                            '${currentMaxProtectedNumber}',
                            style: context.primaryTextTheme?.titleMedium,
                          )
                        ],
                      ).padBottom(8.h),
                      if (maxAgeCompliance > 0)
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${PiixCopiesDeprecated.maxAge}: $maxAgeCompliance'
                              ' ${PiixCopiesDeprecated.yearLabel}',
                              style: context.textTheme?.bodyMedium?.copyWith(
                                color: PiixColors.primary,
                              ),
                            )),
                      Divider(height: 14.h),
                      ...plansWithProtectedAcquiredList
                          .map((plan) => AddPlanRow(
                                key: Key(plan.planId),
                                plan: plan,
                                planUiState: planUiState,
                                originalProtectedAcquired: planList?.plans
                                        .firstWhere((element) =>
                                            element.planId == plan.planId)
                                        .protectedAcquired ??
                                    0,
                              )),
                      if (plansWithoutProtectedList.isNotEmpty) ...[
                        const AddPlanSelector(),
                        Divider(height: 14.h),
                      ],
                      Text(
                        PiixCopiesDeprecated.extendsToCoverage,
                        style: context.textTheme?.bodyMedium?.copyWith(
                          color: PiixColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ).padBottom(32.h),
                      Text(
                        PiixCopiesDeprecated.rememberRenewCoverage,
                        style: context.primaryTextTheme?.labelMedium,
                        textAlign: TextAlign.center,
                      ).padBottom(20.h)
                    ],
                  ),
                ).padHorizontal(mediumPadding.w),
              ],
            ),
          ),
        ),
        PlanFooter(
          planUiState: planUiState,
        ),
      ],
    );
  }
}
