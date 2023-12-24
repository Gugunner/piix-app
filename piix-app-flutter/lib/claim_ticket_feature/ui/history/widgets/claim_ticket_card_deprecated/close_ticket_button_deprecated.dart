import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/tracking_and_rating_deprecated/ratings_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This screen is used to render a close ticket button,
///and navigate to Rating Screen.
class CloseTicketButtonDeprecated extends StatelessWidget {
  const CloseTicketButtonDeprecated({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<void>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.youWantToFinishAClaim,
          message: PiixCopiesDeprecated.finishProblemMessage,
          cancelText: PiixCopiesDeprecated.exit,
          onConfirm: () => handleRatingScreenNavigation(context),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Text(
          PiixCopiesDeprecated.finishRequest,
          textAlign: TextAlign.center,
          style: context.accentTextTheme?.headlineLarge?.copyWith(
            color: PiixColors.active,
          ),
        ),
      ),
    );
  }

  void handleRatingScreenNavigation(BuildContext context) {
    final claimTicketProvider = context.read<ClaimTicketProvider>();
    claimTicketProvider.selectedTicket = ticket;
    Navigator.popAndPushNamed(context, RatingsScreenDeprecated.routeName);
  }
}
