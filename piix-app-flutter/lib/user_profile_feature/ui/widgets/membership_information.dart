import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';
import 'package:piix_mobile/ui/common/copy_snackbar.dart';
import 'package:piix_mobile/user_profile_feature/ui/widgets/row_profile_label.dart';
import 'package:provider/provider.dart';

/// Displays the general information of the user's membership.
class MembershipInformation extends StatelessWidget {
  const MembershipInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;
    final user = userBLoC.user;
    final plan = (membership?.usersMembershipPlans.length ?? 0) > 1
        ? PiixCopiesDeprecated.plans
        : PiixCopiesDeprecated.planLabel;

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowProfileLabel(
                label: '${PiixCopiesDeprecated.membershipWord}:'
                    ' ${membership?.membershipId ?? ''}'),
            RowProfileLabel(
                label: '${PiixCopiesDeprecated.client}:'
                    ' ${membership?.clientName ?? '-'}'),
            RowProfileLabel(
                label: '${PiixCopiesDeprecated.package}:'
                    ' ${membership?.package.name ?? ''}'),
            RowProfileLabel(
              label: '${PiixCopiesDeprecated.fromValidity}\n'
                  '${membership?.fromDate.dateFormat ?? '-'}',
              trailingLabel: '${PiixCopiesDeprecated.validityTo}\n'
                  '${membership?.toDate.dateFormat ?? '-'}',
            ),
            RowProfileLabel(
                label: '${PiixCopiesDeprecated.levelText}:'
                    ' ${membership?.usersMembershipLevel.name ?? '-'}'),
            RowProfileLabel(
                label: '$plan:\n'
                    '*${membership?.usersMembershipPlans.map((e) => e.name).join('\n*')}'),
            RowProfileLabel(
              label: '${PiixCopiesDeprecated.status}:'
                  ' ${membership?.isActive ?? false ? PiixCopiesDeprecated.activeProduct : PiixCopiesDeprecated.inactiveProduct}',
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    copyMembershipData(
                      uniqueId: user?.uniqueId,
                      membership: membership,
                    );
                    ScaffoldMessenger.of(NavigatorKeyState()
                                .currentNavigatorKey
                                .currentContext ??
                            context)
                        .showSnackBar(
                      copySnackBar(
                        snackText: PiixCopiesDeprecated.membershipInfoCopied,
                        context: context,
                      ),
                    );
                  },
                  icon: Icon(Icons.content_copy, size: 15.h),
                  label: Text(
                    PiixCopiesDeprecated.copyInfo,
                    style: context.accentTextTheme?.headlineLarge?.copyWith(
                      color: PiixColors.active,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
