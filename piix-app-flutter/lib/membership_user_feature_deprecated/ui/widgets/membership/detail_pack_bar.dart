import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:provider/provider.dart';

/// Shows the main details of the actual membership.
class DetailPackBar extends StatelessWidget {
  const DetailPackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final membership = membershipBLoC.selectedMembership;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w).copyWith(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '${PiixCopiesDeprecated.membershipWord} ${membership?.package.name ?? ''}',
              style: context.textTheme?.headlineLarge?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${PiixCopiesDeprecated.membershipWord}: '
            '${membership?.membershipId ?? ''} ',
            style: context.accentTextTheme?.titleMedium?.copyWith(
              color: PiixColors.inactive,
            ),
          ),
        ],
      ),
    );
  }
}
