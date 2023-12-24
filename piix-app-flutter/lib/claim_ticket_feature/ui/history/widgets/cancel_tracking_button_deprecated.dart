import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/history/widgets/cancel_claim_ticket_screen.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_fullscreen_dialog_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use')

///This screen is used to render a cancel tracking ticket button,
class CancelTrackingButtonDeprecated extends StatelessWidget {
  const CancelTrackingButtonDeprecated({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.83,
      height: 40.h,
      child: TextButton(
        onPressed: () => handleNavigateToCancelTicketScreen(context),
        child: Text(
          PiixCopiesDeprecated.cancelRequest,
          textAlign: TextAlign.center,
          style: context.titleMedium?.copyWith(
            color: PiixColors.activeButton,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void handleNavigateToCancelTicketScreen(BuildContext context) {
    final claimTicketProvider = context.read<ClaimTicketProvider>();
    Navigator.of(context).pop();
    claimTicketProvider.selectedTicket = ticket;
    Navigator.push(
      context,
      PiixFullScreenDialogDeprecated(
        child: const CancelClaimTicketScreen(
          fromHistory: true,
        ),
      ),
    );
  }
}
