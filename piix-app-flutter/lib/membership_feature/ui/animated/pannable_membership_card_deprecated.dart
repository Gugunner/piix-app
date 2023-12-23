import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/ui/animated/app_pannable_membership_card_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';

@Deprecated('Use instead PannableMembershipCard')

///Membership Card used for valid active or inactive memberships.
///
///Used when the [user] has [memberships] either one or more.
class PannableMembershipCardOld extends AppPannableMembershipCardOld {
  PannableMembershipCardOld({
    super.key,
    required this.user,
    required this.membership,
  }) : super(
          child: _MembershipCardStackInformation(
            user: user,
            membership: membership,
          ),
          color: PiixColors.level1,
        );

  final UserAppModel user;
  final MembershipModel membership;

  @override
  State<PannableMembershipCardOld> createState() =>
      _PannableMembershipCardState();
}

class _PannableMembershipCardState
    extends AppPannableMembershipCardOldState<PannableMembershipCardOld> {}

///Content for the [PannableMembershipCardOld].
///
///Shows the membership and user information in the card
class _MembershipCardStackInformation extends ConsumerWidget {
  const _MembershipCardStackInformation({
    required this.user,
    required this.membership,
  });

  final UserAppModel user;
  final MembershipModel membership;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMainUser = ref.watch(isMainUserProvider);
    final membershipType = isMainUser
        ? MembershipCopies.mainMembership
        : PiixCopiesDeprecated.singularProtectedText;
    final protectedLength = 0;
    return Container(
      padding: EdgeInsets.fromLTRB(
        12.w,
        16.h,
        0,
        16.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width,
            child: Text(
              '${PiixCopiesDeprecated.membershipWord} ${membership.package?.name}',
              style: context.accentTextTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text.rich(
            TextSpan(
              text: '${PiixCopiesDeprecated.id} ',
              children: [
                TextSpan(
                  text: user.uniqueId,
                  style: context.labelMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ],
              style: context.accentTextTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text.rich(
            TextSpan(
              text: '$membershipType: ',
              children: [
                TextSpan(
                  text: user.displayShortFullName,
                  style: context.labelMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ],
              style: context.accentTextTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text.rich(
            TextSpan(
              text: '${PiixCopiesDeprecated.levelLabel}: ',
              children: [
                TextSpan(
                  text: 'membership.usersMembershipLevel.name',
                  style: context.labelMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ],
              style: context.accentTextTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text.rich(
            TextSpan(
              text: '${PiixCopiesDeprecated.protectedText}: ',
              children: [
                TextSpan(
                  text:
                      '$protectedLength ${PiixCopiesDeprecated.singularProtectedText}'
                      '${protectedLength.pluralWithS}',
                  style: context.labelMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ],
              style: context.accentTextTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text.rich(
            TextSpan(
              text: '${PiixCopiesDeprecated.validity}: ',
              children: [
                TextSpan(
                  text: '${membership.package?.fromDate.dateFormat} - '
                      '${membership.package?.toDate.dateFormat}',
                  style: context.labelMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ],
              style: context.accentTextTheme?.labelMedium?.copyWith(
                color: PiixColors.space,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
