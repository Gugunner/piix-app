import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:piix_mobile/ui/tickets_deprecated/widgets_deprecated/claim_dialog_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This screen is used to render a re open ticket button,
///and show re open dialog.
//TODO: 'Use instead AuthTextButton or other and pass the logic'
class ReOpenTicketButtonDeprecated extends StatelessWidget {
  const ReOpenTicketButtonDeprecated({super.key, required this.ticket});
  final TicketModel ticket;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleReOpenClaimTicketDialog(context),
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Text(
          PiixCopiesDeprecated.requestAgain,
          style: context.titleMedium?.copyWith(
            color: PiixColors.activeButton,
          ),
        ),
      ),
    );
  }

  void handleReOpenClaimTicketDialog(BuildContext context) => showDialog<void>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.claimBenefitAgain(
              getNameOfTicket(benefitName: ticket.claimName)),
          message: PiixCopiesDeprecated.initNewBenefitMonitoring(
              getNameOfTicket(benefitName: ticket.claimName)),
          cancelText: PiixCopiesDeprecated.exit,
          onConfirm: () async {
            final claimTicketProvider = context.read<ClaimTicketProvider>();
            claimTicketProvider.selectedTicket = ticket;
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) {
                  return ClaimDialogDeprecated(
                    fromHistory: true,
                    isBenefit: true,
                    name: getNameOfTicket(benefitName: ticket.claimName),
                  );
                });
          },
        ),
      );
}
