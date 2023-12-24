import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:provider/provider.dart';

///This widget is the content of membership coverage tooltip
///
class MembershipCoverageContent extends StatelessWidget {
  const MembershipCoverageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;
    final _statusMembershipTooltipText = membership?.isActive ?? false
        ? PiixCopiesDeprecated.activeMembership
        : PiixCopiesDeprecated.inactiveMembership;
    final tooltipMessage = (membership?.isActive ?? false)
        ? PiixCopiesDeprecated.tooltipActiveMembership
        : PiixCopiesDeprecated.tooltipInActiveMembership;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${PiixCopiesDeprecated.membershipWord} '
          '$_statusMembershipTooltipText',
          style: context.labelLarge?.copyWith(
            color: PiixColors.white,
          ),
        ),
        SizedBox(
          height: context.height * 0.023,
        ),
        Text(
          tooltipMessage,
          style: context.bodySmall?.copyWith(
            color: PiixColors.white,
          ),
        )
      ],
    );
  }
}
