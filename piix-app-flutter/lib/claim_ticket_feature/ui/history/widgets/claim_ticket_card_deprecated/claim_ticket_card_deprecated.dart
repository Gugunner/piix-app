import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_body_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/claim_ticket_footer_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/claim_ticket_header_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a [Card] widget that shows the details of a ticket.
class ClaimTicketCardDeprecated extends StatelessWidget {
  const ClaimTicketCardDeprecated({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: SizedBox(
          width: context.width,
          child: Column(
            children: [
              ClaimTicketHeaderDeprecated(
                ticket: ticket,
              ),
              SizedBox(
                height: 4.h,
              ),
              ClaimTicketBodyDeprecated(
                ticket: ticket,
              ),
              ClaimTicketFooterDeprecated(
                ticket: ticket,
              )
            ],
          ),
        ),
      ),
    );
  }
}
