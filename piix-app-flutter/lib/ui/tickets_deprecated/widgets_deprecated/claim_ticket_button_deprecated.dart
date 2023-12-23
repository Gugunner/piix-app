import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/ui/widgets/claim_benefit_dialog.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This button open a ticket and navigate to phone call
class ClaimTicketButtonDeprecated extends StatelessWidget {
  const ClaimTicketButtonDeprecated({
    Key? key,
    required this.isBenefit,
    required this.fromHistory,
    this.isPhoneClaim = true,
  }) : super(key: key);
  final bool isBenefit;
  final bool fromHistory;
  final bool isPhoneClaim;

  String get claimLabel => isPhoneClaim
      ? PiixCopiesDeprecated.callByPhone
      : PiixCopiesDeprecated.messageByWhatsApp;

  IconData get claimIcon =>
      isPhoneClaim ? Icons.phone_android_outlined : PiixIcons.whatsapp;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (dialogContext) => ClaimBenefitDialog(
            isPhoneClaim: isPhoneClaim,
            isBenefit: isBenefit,
            fromHistory: fromHistory,
          ),
        );
      },
      style: Theme.of(context).outlinedButtonTheme.style,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            claimIcon,
            size: 20.w,
            color: PiixColors.darkSkyBlue,
          ),
          SizedBox(width: 8.w),
          Text(
            claimLabel,
            style: context.primaryTextTheme?.titleMedium?.copyWith(
              color: PiixColors.active,
            ),
          ),
        ],
      ),
    );
  }
}
