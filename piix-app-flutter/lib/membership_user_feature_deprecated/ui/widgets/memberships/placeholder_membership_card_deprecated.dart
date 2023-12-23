import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/user_info_texts_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///A simple placeholder membership card when no memberships are found
///for the user
class PlaceHolderMembershipCardDeprecated extends StatelessWidget {
  const PlaceHolderMembershipCardDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 36.w,
      ),
      child: Stack(
        children: [
          ShimmerWrap(
            child: Image.asset(
              PiixAssets.membershipPlaceHolder,
              height: context.height * 0.5,
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 0,
            left: 0,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 35.w,
              ),
              child: const UserInfoTextsDeprecated(),
            ),
          ),
        ],
      ),
    );
  }
}
