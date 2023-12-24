import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:provider/provider.dart';

///This card shows a membership info for a ticket guide.
class MembershipInfo extends StatelessWidget {
  const MembershipInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final user = userBLoC.user;
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Card(
          elevation: 3,
          child: ExpansionTile(
            backgroundColor: PiixColors.greyCard,
            collapsedBackgroundColor: PiixColors.greyCard,
            title: Text.rich(
              TextSpan(
                text: '${PiixCopiesDeprecated.membershipDataLabel}\n',
                style: context.primaryTextTheme?.titleMedium,
                children: [
                  TextSpan(
                    text: user?.displayName ?? '',
                    style: context.textTheme?.bodyMedium,
                  ),
                ],
              ),
            ),
            iconColor: PiixColors.gunMetal,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.uniqueId}: ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: '${user?.uniqueId ?? ''}',
                      style: context.textTheme?.bodyMedium,
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.membershipId} ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: '${membership?.membershipId ?? ''}',
                      style: context.textTheme?.bodyMedium,
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.packageText}: ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: '${membership?.package.name ?? ''} ',
                      style: context.textTheme?.bodyMedium,
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.planColon} ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: (membership?.usersMembershipPlans ?? [])
                          .map((e) => e.name)
                          .join(', '),
                      style: context.textTheme?.bodyMedium,
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.levelColon} ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: membership?.usersMembershipLevel.name ?? '',
                      style: context.textTheme?.bodyMedium,
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.validitySinceColon} ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: membership?.fromDate.dateFormat ?? '',
                      style: context.textTheme?.bodyMedium,
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${PiixCopiesDeprecated.validityUntilColon} ',
                      style: context.primaryTextTheme?.titleMedium,
                    ),
                    TextSpan(
                      text: membership?.toDate.dateFormat ?? '',
                      style: context.textTheme?.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
