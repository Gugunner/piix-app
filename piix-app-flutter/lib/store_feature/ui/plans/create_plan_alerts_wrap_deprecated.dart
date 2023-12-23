import 'package:flutter/material.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/plan_builder_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This is the ui screen wrapper for Plans module, contains the plan ui state
///
class CreatePlanAlertsWrapDeprecated extends StatefulWidget {
  const CreatePlanAlertsWrapDeprecated({
    super.key,
  });

  @override
  State<CreatePlanAlertsWrapDeprecated> createState() =>
      _CreatePlanAlertsWrapDeprecatedState();
}

class _CreatePlanAlertsWrapDeprecatedState
    extends State<CreatePlanAlertsWrapDeprecated> {
  late PlanUiStateDeprecated planUiState;

  @override
  void initState() {
    super.initState();
    planUiState = PlanUiStateDeprecated(setState: setState);
  }

  @override
  void dispose() {
    super.dispose();
    planUiState.cleanState();
  }

  @override
  Widget build(BuildContext context) {
    return PlanBuilderDeprecated(planUiState: planUiState);
  }
}
