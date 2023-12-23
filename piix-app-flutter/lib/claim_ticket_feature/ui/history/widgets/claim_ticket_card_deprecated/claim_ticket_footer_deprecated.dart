import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/cancel_ticket_button_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/claim_ticket_card_deprecated/close_ticket_button_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/report_problem_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_fullscreen_dialog_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// Creates the footer of the [TicketCard] widget that shows the actions that
/// can be performed on the ticket.
class ClaimTicketFooterDeprecated extends StatelessWidget {
  const ClaimTicketFooterDeprecated({Key? key, required this.ticket})
      : super(key: key);

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final status = ticket.status;
    final userSupport = status == TicketStatus.user_support;
    final hasProperStatus = status == TicketStatus.user_generated ||
        status == TicketStatus.system_alert_one ||
        userSupport;
    return Column(
      children: [
        if (hasProperStatus) ...[
          GestureDetector(
            onTap: userSupport
                ? null
                : () => Navigator.push(
                      context,
                      PiixFullScreenDialogDeprecated(
                        child: ReportProblemScreenDeprecated(
                          ticket: ticket,
                        ),
                      ),
                    ),
            child: Text(
              userSupport
                  ? PiixCopiesDeprecated.haveProblem
                  : PiixCopiesDeprecated.reportProblem,
              style: context.accentTextTheme?.headlineLarge?.copyWith(
                color: userSupport ? PiixColors.primary : PiixColors.active,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          )
        ],
        const Divider(height: 0),
        if (hasProperStatus)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CancelTicketButtonDeprecated(
                  ticket: ticket,
                ),
              ),
              SizedBox(
                height: 32.h,
                child: const VerticalDivider(),
              ),
              Expanded(
                child: CloseTicketButtonDeprecated(
                  ticket: ticket,
                ),
              ),
            ],
          )
        //TODO: Add a logic that works with requesting again the ticke
        // else
        //   ReOpenTicketButton(
        //     ticket: ticket,
        //   ),
      ],
    );
  }
}
