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

@Deprecated('Will be removed in 4.0')

///This screen is used to render a cancel ticket button,
///and navigate to Cancel Problem Screen.
class CancelTicketButtonDeprecated extends StatelessWidget {
  const CancelTicketButtonDeprecated({
    Key? key,
    required this.ticket,
  }) : super(key: key);
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleNavigateToCancelTicketScreen(context),
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
        ),
        child: Text(
          PiixCopiesDeprecated.cancelRequest,
          textAlign: TextAlign.center,
          style: context.accentTextTheme?.headlineLarge?.copyWith(
            color: PiixColors.active,
          ),
        ),
      ),
    );
  }

  void handleNavigateToCancelTicketScreen(BuildContext context) {
    final claimTicketProvider = context.read<ClaimTicketProvider>();
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
