import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:provider/provider.dart';

///This widget render a plan selector to add plans to quotation
///
class AddPlanSelector extends StatelessWidget {
  const AddPlanSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.watch<PlansBLoCDeprecated>();
    final currentMaxProtectedNumber =
        (plansBLoC.plansList?.protectedLimit ?? 0) -
            (plansBLoC.plansList?.totalProtectedAcquired ?? 0);
    final plansWithoutProtectedList = plansBLoC.plansWithoutProtectedList;
    final generalLimitReached =
        currentMaxProtectedNumber == plansBLoC.protectedCount;
    final planItems = plansWithoutProtectedList
        .map((e) => DropdownMenuItem<String>(
              child: Text(e.name),
              value: e.planId,
              alignment: Alignment.center,
            ))
        .toList();
    return Column(
      children: [
        DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            PiixCopiesDeprecated.addProtected,
            style: context.textTheme?.titleMedium,
          ),
          style: context.textTheme?.titleMedium,
          items: planItems,
          value: null,
          onChanged: generalLimitReached
              ? null
              : (planId) => handleAddProtected(planId!, context),
          underline: const SizedBox(),
        ),
        if (generalLimitReached)
          Text(
            PiixCopiesDeprecated.limitProtectedReached,
            style: context.textTheme?.bodyMedium?.copyWith(
              color: PiixColors.error,
            ),
          ),
      ],
    );
  }

  void handleAddProtected(String planId, BuildContext context) {
    final plansBLoC = context.read<PlansBLoCDeprecated>();
    final index = plansBLoC.plansList!.plans
        .indexWhere((element) => element.planId == planId);
    final currentPlan = plansBLoC.plansList!.plans[index];
    plansBLoC
      ..protectedCount = plansBLoC.protectedCount + 1
      ..removePlanFromSelectPlanList(planId)
      ..addPlanToQuotationList(currentPlan);
  }
}
