import 'package:flutter/material.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/claim_ticket_history_data_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_tickets_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///In this screen execute a getHistoryClaimTicket service in a future builder.
///When the service retrieve an error this screen shows a piix error screen,
///Otherwise it will show the history data widget.
///
class ClaimTicketHistoryScreenBuilderDeprecated extends StatefulWidget {
  const ClaimTicketHistoryScreenBuilderDeprecated({Key? key}) : super(key: key);
  static const routeName = '/claim_ticket_history';

  @override
  State<ClaimTicketHistoryScreenBuilderDeprecated> createState() =>
      _ClaimTicketHistoryScreenBuilderDeprecatedState();
}

class _ClaimTicketHistoryScreenBuilderDeprecatedState
    extends State<ClaimTicketHistoryScreenBuilderDeprecated> {
  late Future<void> getClaimTicketHistoryFuture;
  late ClaimTicketProvider claimTicketProvider;

  @override
  void initState() {
    getClaimTicketHistoryFuture = getHistoryClaimTicket();
    super.initState();
  }

  @override
  void dispose() {
    if (PiixBannerDeprecated.instance.entry != null) {
      PiixBannerDeprecated.instance.removeEntry();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final claimTicketProvider = context.watch<ClaimTicketProvider>();
    final claimTicketState = claimTicketProvider.claimTicketState;
    return ClampingScaleDeprecated(
      child: Scaffold(
          appBar:
              const PiixAppBarDeprecated(title: PiixCopiesDeprecated.requests),
          body: Builder(
            builder: (_) {
              final isLoading =
                  claimTicketState == ClaimTicketStateDeprecated.idle ||
                      claimTicketState == ClaimTicketStateDeprecated.retrieving;

              if (claimTicketState.hasErrorState) {
                return PiixErrorScreenDeprecated(
                  errorMessage: PiixCopiesDeprecated.unexpectedError,
                  onTap: retryHistoryClaimTicket,
                );
              }

              return ClaimTicketHistoryDataDeprecated(
                isLoading: isLoading,
                tickets: claimTicketProvider.tickets,
                retryHistoryClaimTicket: retryHistoryClaimTicket,
              );
            },
          )),
    );
  }

  Future<void> getHistoryClaimTicket() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final claimTicketProvider = context.read<ClaimTicketProvider>();
      final uiBLoC = context.read<UiBLoC>();
      final membershipId = context
          .read<MembershipProviderDeprecated>()
          .selectedMembership
          ?.membershipId;
      if (membershipId == null) {
        return;
      }
      uiBLoC.loadText = PiixCopiesDeprecated.gettingTicketHistory;
      await claimTicketProvider.getTicketHistoryByMembership(
        membershipId: membershipId,
      );
    });
  }

  void retryHistoryClaimTicket() => setState(() {
        getClaimTicketHistoryFuture = getHistoryClaimTicket();
      });
}
