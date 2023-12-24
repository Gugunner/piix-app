import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_alert_info_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/managing_deprecated/plan_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/state_switcher_widget_plan_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/plans.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a create quotation plan ui, include a ui switcher state
///The getPlansByMembership feature is executed on this screen
///
class PlanBuilderDeprecated extends StatefulWidget {
  const PlanBuilderDeprecated({
    super.key,
    required this.planUiState,
  });
  final PlanUiStateDeprecated planUiState;

  @override
  State<PlanBuilderDeprecated> createState() => _PlanBuilderDeprecatedState();
}

class _PlanBuilderDeprecatedState extends State<PlanBuilderDeprecated> {
  late Future<void> getPlansFuture;

  late PlansBLoCDeprecated plansBLoC;

  AlertStateDeprecated get show => AlertStateDeprecated.show;
  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  void initState() {
    super.initState();
    getPlansFuture = getPlansByMembership();
  }

  @override
  Widget build(BuildContext context) {
    plansBLoC = context.watch<PlansBLoCDeprecated>();
    final usefullScreenHeight = context.height - kToolbarHeight;
    return FutureBuilder<void>(
      future: getPlansFuture,
      builder: (_, __) {
        final alertType = widget.planUiState.planAlertType;
        return Stack(
          children: [
            SizedBox(
              height: usefullScreenHeight,
              width: context.width,
              child: StateSwitcherWidgetPlanDeprecated(
                planUiState: widget.planUiState,
                retryPlansByMembership: retryPlansByMembership,
              ),
            ),
            if (widget.planUiState.planAlertState == show)
              PiixAlertInfoDeprecated(
                backgroundColor: alertType.getPlanAlertColor,
                icon: alertType.getPlanAlertIcon,
                subtitle:
                    alertType.getPlanAlertMessage(plansBLoC.removedPlanName),
                onClose: () => widget.planUiState.planAlertState =
                    AlertStateDeprecated.hide,
              ),
          ],
        );
      },
    );
  }

  //This future, retrieve a plans to acquire
  Future<void> getPlansByMembership() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final membershipId = context
          .read<MembershipProviderDeprecated>()
          .selectedMembership!
          .membershipId;
      await plansBLoC.getPlansByMembership(
        membershipId: membershipId,
      );
    });
  }

  //This function resets the future of getPlansByMembership, and reruns it
  void retryPlansByMembership() => setState(() {
        getPlansFuture = getPlansByMembership();
      });
}
