import 'package:flutter/material.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/blank_slates_deprecated/blank_slate_store_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/create_plan_data.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/plan_skeleton.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///Depending on the state it can
///render the skeleton loader, the data screen, or the error messages or empty
///as well as a button to retry loading the data
///
class StateSwitcherWidgetPlanDeprecated extends StatelessWidget {
  const StateSwitcherWidgetPlanDeprecated({
    super.key,
    required this.planUiState,
    required this.retryPlansByMembership,
  });
  final PlanUiStateDeprecated planUiState;
  final void Function()? retryPlansByMembership;

  static const getting = PlanStateDeprecated.getting;
  static const idle = PlanStateDeprecated.idle;
  static const accomplished = PlanStateDeprecated.accomplished;
  static const empty = PlanStateDeprecated.empty;
  static const unexpectedError = PlanStateDeprecated.unexpectedError;
  static const error = PlanStateDeprecated.error;

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.watch<PlansBLoCDeprecated>();
    final notAddPlans = plansBLoC.plansList?.protectedLimit ==
        plansBLoC.plansList?.totalProtectedAcquired;
    final planState = plansBLoC.planState;
    switch (planState) {
      case getting:
      case idle:
        return const PlanSkeleton();
      case accomplished:
        if (notAddPlans) {
          return PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.limitProtectedReached,
            buttonLabel: PiixCopiesDeprecated.backText.toUpperCase(),
            onTap: () {
              NavigatorKeyState().getNavigator()?.pop();
            },
          );
        }
        return CreatePlanData(planUiState: planUiState);
      case empty:
      case PlanStateDeprecated.notFound:
        return const BlankSlateStoreDeprecated(
          label: PiixCopiesDeprecated.plans,
        );
      case unexpectedError:
      case error:
      case PlanStateDeprecated.conflict:
        return PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
            onTap: retryPlansByMembership);
      default:
        return const SizedBox();
    }
  }
}
