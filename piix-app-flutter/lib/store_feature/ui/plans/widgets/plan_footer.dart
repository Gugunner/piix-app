import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/plans_quotation_home_screen_deprecated.dart';
import 'package:provider/provider.dart';

///This widget is a footer for plan module, includes a description text and
///quotation navigation button
///
class PlanFooter extends StatelessWidget {
  const PlanFooter({
    super.key,
    required this.planUiState,
  });
  final PlanUiStateDeprecated planUiState;

  PlanStateDeprecated get getting => PlanStateDeprecated.getting;
  PlanStateDeprecated get idle => PlanStateDeprecated.idle;

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.watch<PlansBLoCDeprecated>();
    final planState = plansBLoC.planState;
    final plansWithProtectedAcquiredList =
        plansBLoC.plansWithProtectedAcquiredList;
    return Container(
      color: PiixColors.skeletonGrey,
      width: context.width,
      child: Column(
        children: [
          Text(
            PiixCopiesDeprecated.startAddingProtectedToQuotation,
            style: context.textTheme?.bodyMedium?.copyWith(
              color: PiixColors.primary,
            ),
          ).padTop(8.h).padBottom(4.h),
          FractionallySizedBox(
            widthFactor: 0.862,
            child: ElevatedButton(
              onPressed: planState == getting || planState == idle
                  ? null
                  : plansWithProtectedAcquiredList.isEmpty
                      ? null
                      : () => handleNavigationToPlanQuotation(context),
              child: Text(
                PiixCopiesDeprecated.quoteLabel.toUpperCase(),
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.space,
                ),
              ),
            ),
          ).padBottom(
            4.h,
          )
        ],
      ),
    );
  }

  //This function sets the ids of the plans that are going to be quoted. And
  //navigates to the quote detail screen
  void handleNavigationToPlanQuotation(BuildContext context) {
    final plansBLoC = context.read<PlansBLoCDeprecated>();
    final plansWithProtectedAcquiredList =
        plansBLoC.plansWithProtectedAcquiredList;
    final planIds = <String>[];
    //Go through the list of plans to quote to obtain their ids
    plansWithProtectedAcquiredList.forEach((element) {
      final _idList =
          List.generate(element.protectedAcquired, (_) => element.planId);
      planIds.addAll(_idList);
    });
    //Set plan ids
    plansBLoC.currentPlanIds = planIds.join(',');
    Navigator.of(context).pushNamed(PlanQuotationHomeScreenDeprecated.routeName,
        arguments: planUiState);
  }
}
