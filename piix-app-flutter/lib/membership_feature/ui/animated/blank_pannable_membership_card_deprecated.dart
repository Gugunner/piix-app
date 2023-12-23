import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/ui/animated/app_pannable_membership_card_deprecated.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';


@Deprecated('Use instead BlankPannableMembershipCard')
///Membership Card used when the user has no memberships or
///could not be loaded.
class BlankPannableMembershipCardOld extends AppPannableMembershipCardOld {
  const BlankPannableMembershipCardOld({super.key})
      : super(
          child: const _BlankMembershipCardInformation(),
          logoColor: PiixColors.contrast,
          color: PiixColors.secondaryLight,
        );

  @override
  State<StatefulWidget> createState() => _BlankPannableMembershipCardState();
}

class _BlankPannableMembershipCardState
    extends AppPannableMembershipCardOldState<BlankPannableMembershipCardOld> {}

class _BlankMembershipCardInformation extends StatelessWidget {
  const _BlankMembershipCardInformation();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        12.w,
        12.w,
        12.w,
      ),
      width: context.width,
      height: 160.h,
      child: Center(
        child: SizedBox(
          child: Text(
            MembershipCopies.blankMembership,
            style: context.accentTextTheme?.labelLarge?.copyWith(
              color: PiixColors.contrast,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
