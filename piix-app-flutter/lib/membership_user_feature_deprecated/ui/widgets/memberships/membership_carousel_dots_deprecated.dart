import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widgets is a carousel dots for list of memberships.
class MembershipCarouselDotsDeprecated extends StatelessWidget {
  const MembershipCarouselDotsDeprecated({
    super.key,
    required this.memberships,
    required this.currentMembership,
  });
  final List<MembershipModelDeprecated> memberships;
  final int currentMembership;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PiixColors.greyWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...memberships.map((item) {
            final index = memberships.indexOf(item);
            final dotSize = currentMembership == index ? 10.h : 6.h;
            final dotColor = currentMembership == index
                ? PiixColors.darkSkyBlue
                : PiixColors.coolGrey.withOpacity(0.5);

            return Container(
              width: dotSize,
              height: dotSize,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
              ),
            );
          })
        ],
      ),
    );
  }
}
