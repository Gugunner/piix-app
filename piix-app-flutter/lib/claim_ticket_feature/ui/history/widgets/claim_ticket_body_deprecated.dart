import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/expandable_panel.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';

@Deprecated('Will be removed in 4.0')

/// Creates the body of the [TicketCard] widget that shows the details
/// of the ticket.
class ClaimTicketBodyDeprecated extends StatelessWidget {
  const ClaimTicketBodyDeprecated({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textTheme?.bodyMedium;
    return ExpandablePanel(
        horizontalPadding: 0,
        verticalPadding: 0,
        hasRowIcon: true,
        buttonExpandsWithPanel: false,
        backgroundColor: PiixColors.white,
        panelHeader: SizedBox(
          height: 12.h,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${PiixCopiesDeprecated.requestNumber}:\n',
                  style: labelStyle,
                ),
                TextSpan(text: '${ticket.ticketId}\n'),
              ],
            ),
            style: labelStyle,
            maxLines: null,
          ),
        ),
        panelBody: SizedBox(
          width: context.width,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${PiixCopiesDeprecated.requestDate}:\n',
                  style: labelStyle,
                ),
                TextSpan(text: '${ticket.registerDate.dateFormat}\n'),
                if (ticket.updateDate != null) ...[
                  TextSpan(
                    text: '${PiixCopiesDeprecated.updateDate}:\n',
                    style: labelStyle,
                  ),
                  TextSpan(text: '${ticket.updateDate?.dateFormat}\n'),
                ],
                if (ticket.closedDate != null) ...[
                  TextSpan(
                    text: '${PiixCopiesDeprecated.finishDate}:\n',
                    style: labelStyle,
                  ),
                  TextSpan(text: '${ticket.closedDate?.dateFormat}\n')
                ],
                if (ticket.cancelDate != null) ...[
                  TextSpan(
                    text: '${PiixCopiesDeprecated.cancelDate}:\n',
                    style: labelStyle,
                  ),
                  TextSpan(text: '${ticket.cancelDate?.dateFormat}\n'),
                ],
                if (ticket.supplierName.isNotEmpty) ...[
                  TextSpan(
                    text: '${PiixCopiesDeprecated.supplier}:\n',
                    style: labelStyle,
                  ),
                  TextSpan(text: '${ticket.supplierName}\n'),
                ],
              ],
            ),
            style: labelStyle,
          ),
        ));
  }
}
