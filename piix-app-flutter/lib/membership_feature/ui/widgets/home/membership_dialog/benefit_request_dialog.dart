import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/ui/copies/membership_copies.dart';
import 'package:piix_mobile/widgets/dialog/app_tooltip_dialog.dart';
import 'package:piix_mobile/widgets/dialog/dialog_step_description.dart';


///An informative dialog explaining how to request a benefit
///from the app.
class BenefitRequestDialog extends AppTooltipDialog {
  BenefitRequestDialog({
    super.key,
  }) : super(
          title: MembershipCopies.howToRequestBenefit,
          description: const _BenefitRequestDialogDescription(),
        );
}

///A set of step instructions and disclaimer to request a benefit
class _BenefitRequestDialogDescription extends StatelessWidget {
  const _BenefitRequestDialogDescription();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DialogStepDescription(
          header: MembershipCopies.insideTheBenefit,
          description: MembershipCopies.fromAnyBenefit,
          step: 1,
        ),
        SizedBox(height: 16.h),
        const DialogStepDescription(
          header: MembershipCopies.sosButton,
          description: MembershipCopies.fromSosButton,
          step: 2,
        ),
        SizedBox(height: 32.h),
        Text(
          MembershipCopies.important,
          style: context.primaryTextTheme?.titleSmall?.copyWith(
            color: PiixColors.infoDefault,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          MembershipCopies.toRequestABenefit,
          style: context.bodyMedium?.copyWith(
            color: PiixColors.infoDefault,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
