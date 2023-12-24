import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/claim_ticket_card_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/no_tickets.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/shimmer_claim_ticket_cards_deprecated.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a claim ticket history, in a cards with all info for
///claim ticket.
///
///Receives a [isLoading] flag, This flag is used to display the charging
///skeletons with the shimmer effect, and [List<TicketModel>] tickets.
///
///When the tickets list is empty, this screen shows a no tickets widget.
///
///This screen also shows an alert for when a ticket claim action is performed
/// such as cancellation, closure or problem report.
///
class ClaimTicketHistoryDataDeprecated extends StatelessWidget {
  const ClaimTicketHistoryDataDeprecated({
    super.key,
    required this.tickets,
    required this.retryHistoryClaimTicket,
    this.isLoading = false,
  });

  final bool isLoading;
  final List<TicketModel> tickets;
  final VoidCallback retryHistoryClaimTicket;

  @override
  Widget build(BuildContext context) {
    final claimTicketProvider = context.watch<ClaimTicketProvider>();

    if (claimTicketProvider.claimTicketState ==
            ClaimTicketStateDeprecated.empty &&
        !isLoading) {
      return const NoTickets();
    }

    return Shimmer(
      child: ShimmerLoading(
        isLoading: isLoading,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              SizedBox(
                height: 18.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: ShimmerWrap(
                  child: Text(
                    PiixCopiesDeprecated.requestsHistory,
                    style: context.textTheme?.headlineSmall,
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              if (isLoading)
                //This widget only shows when shimmer state is loading, its a
                //list of cards with shimmer effect
                const ShimmerClaimTicketCardsDeprecated()
              else
                ...tickets.map(
                  (claimTicket) {
                    return ClaimTicketCardDeprecated(
                      ticket: claimTicket,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
