import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/icon_plan_button.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

///This widget render a remove and add button to protected in plan
///
class AddPlanRow extends StatefulWidget {
  const AddPlanRow({
    super.key,
    required this.plan,
    required this.planUiState,
    required this.originalProtectedAcquired,
  });
  final PlanModel plan;
  final PlanUiStateDeprecated planUiState;
  final int originalProtectedAcquired;

  @override
  State<AddPlanRow> createState() => _AddPlanRowState();
}

class _AddPlanRowState extends State<AddPlanRow> {
  late PlansBLoCDeprecated plansBLoC;
  int protectedCount = 0;

  @override
  void initState() {
    protectedCount = widget.plan.protectedAcquired;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    plansBLoC = context.watch<PlansBLoCDeprecated>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SizedBox(
              width: context.width * 0.5,
              child: Text(
                widget.plan.name,
                style: context.textTheme?.titleMedium,
                softWrap: true,
              ),
            ),
            const Spacer(),
            IconPlanButton(
              type: PlanButtonDeprecated.remove,
              maxUsersInPlan:
                  widget.plan.maxUsersInPlan - widget.originalProtectedAcquired,
              protectedAcquired: protectedCount,
              onTap: () => handleRemoveProtected(widget.planUiState),
            ),
            Container(
              height: 25.h,
              width: 56.w,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(color: PiixColors.activeButton),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                  child: Text(
                '$protectedCount',
                style: context.textTheme?.bodyMedium,
              )),
            ),
            IconPlanButton(
              type: PlanButtonDeprecated.add,
              maxUsersInPlan:
                  widget.plan.maxUsersInPlan - widget.originalProtectedAcquired,
              protectedAcquired: protectedCount,
              onTap: handleAddProtected,
            ),
          ],
        ).padBottom(4.h),
        Text(
          '${PiixCopiesDeprecated.limitLabel}: '
          '${widget.plan.maxUsersInPlan - widget.originalProtectedAcquired}',
          style: context.primaryTextTheme?.labelMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ).padBottom(3.h),
        Divider(height: 16.h),
      ],
    );
  }

  void handleAddProtected() {
    final index = plansBLoC.plansWithProtectedAcquiredList
        .indexWhere((element) => element.planId == widget.plan.planId);
    setState(() {
      protectedCount++;
      plansBLoC.protectedCount++;
    });
    final selectedPlan = plansBLoC.plansWithProtectedAcquiredList[index];
    selectedPlan.maybeMap((value) {
      plansBLoC.plansWithProtectedAcquiredList[index] =
          value.copyWith(protectedAcquired: protectedCount);
    }, orElse: () {});
  }

  //Shows a confirm remove protected dialog
  void handleRemoveProtected(PlanUiStateDeprecated planUiState) {
    final index = plansBLoC.plansWithProtectedAcquiredList
        .indexWhere((element) => element.planId == widget.plan.planId);
    if (protectedCount == 1) {
      showDialog<void>(
          context: context,
          builder: (_) => PiixConfirmAlertDialogDeprecated(
                title: PiixCopiesDeprecated.removePlan(widget.plan.name),
                message:
                    PiixCopiesDeprecated.acceptRemovePlan(widget.plan.name),
                child: Text(
                  PiixCopiesDeprecated.alwaysCanAdd,
                  style: context.textTheme?.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                onCancel: () => Navigator.pop(context),
                onConfirm: () => onConfirmDialog(planUiState),
              ));
    } else {
      setState(() {
        protectedCount--;
        plansBLoC.protectedCount--;
      });
      final selectedPlan = plansBLoC.plansWithProtectedAcquiredList[index];
      selectedPlan.maybeMap((value) {
        plansBLoC.plansWithProtectedAcquiredList[index] =
            value.copyWith(protectedAcquired: protectedCount);
      }, orElse: () {});
    }
  }

  //This function handle confirm button when the user removed a plan
  //shows a banner, set a alert type, removePlanFromQuotationList, and
  //addPlanToSelectPlanList
  void onConfirmDialog(PlanUiStateDeprecated planUiState) {
    plansBLoC
      ..removedPlanName = widget.plan.name
      ..removePlanFromQuotationList(widget.plan.planId)
      ..addPlanToSelectPlanList(widget.plan)
      ..protectedCount = plansBLoC.protectedCount - 1;
    planUiState
      ..planAlertState = AlertStateDeprecated.show
      ..planAlertType = AlertTypeDeprecated.success
      ..hidePlanAlert();

    Navigator.pop(context);
  }
}
