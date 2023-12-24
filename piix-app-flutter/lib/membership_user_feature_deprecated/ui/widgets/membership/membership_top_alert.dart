import 'package:flutter/material.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/membership_info_repository_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/basic_form_bloc.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_alert_ui_provider.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_alert_info_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/membership_alert.dart';
import 'package:piix_mobile/ui/notifications/notification_screen_deprecated.dart';
import 'package:provider/provider.dart';

///This widget render a membership top alert, depends of alert type is a color,
///text, and functions
///
class MembershipTopAlert extends StatefulWidget {
  const MembershipTopAlert({
    super.key,
    required this.type,
    this.retryInitScreen = null,
    this.toBasicMainForm = null,
  });
  final MembershipAlert type;
  final VoidCallback? retryInitScreen;
  final VoidCallback? toBasicMainForm;

  @override
  State<MembershipTopAlert> createState() => _MembershipTopAlertState();
}

class _MembershipTopAlertState extends State<MembershipTopAlert> {
  late ClaimTicketProvider claimTicketProvider;
  late MembershipProviderDeprecated membershipInfoBLoC;
  late BasicFormBLoC basicFormBLoC;
  late MembershipAlertUiProvider membershipAlertProvider;

  @override
  Widget build(BuildContext context) {
    claimTicketProvider = context.watch<ClaimTicketProvider>();
    membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    basicFormBLoC = context.watch<BasicFormBLoC>();
    membershipAlertProvider = context.watch<MembershipAlertUiProvider>();

    return PiixAlertInfoDeprecated(
      title: widget.type.getTitleTopAlert,
      subtitle: widget.type.getSubTitleTopAlert,
      icon: widget.type.getIconTopAlert,
      backgroundColor: widget.type.getColorTopAlert,
      actionText: widget.type.getActionText,
      onAction: handleOnAction,
      onClose: handleOnClose,
    );
  }

  void handleOnClose() {
    if (widget.type == MembershipAlert.basicMembership) {
      membershipInfoBLoC.membershipInfoState =
          MembershipInfoStateDeprecated.idle;
    }
    if (widget.type == MembershipAlert.emptyBasicForm) {
      basicFormBLoC.basicFormState = BasicFormState.idle;
    }
    if (widget.type == MembershipAlert.ticketsFound) {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    }
    return membershipAlertProvider.closeMembershipAlertByType(widget.type);
  }

  void handleOnAction() {
    if (widget.type != MembershipAlert.basicMembership) {
      NavigatorKeyState()
          .getNavigator(context)
          ?.pushNamed(NotificationsScreenDeprecated.routeName);
      return;
    }
    widget.retryInitScreen!();
  }
}
