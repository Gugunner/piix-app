import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_text.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/memberships/placeholder_membership_card_deprecated.dart';
import 'package:piix_mobile/ui/common/logout_button_deprecated.dart';

///This widget is used when we do not have membership information

@Deprecated('Use instead BlankMembershipHomeScreen')
class BlankMembership extends StatelessWidget {
  const BlankMembership({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 26.w,
            ),
            child: ShimmerText(
              isLoading: isLoading,
              child: Text(PiixCopiesDeprecated.noAssociatedMemberships,
                  style: context.textTheme?.titleMedium,
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          const PlaceHolderMembershipCardDeprecated(),
          SizedBox(
            height: 16.h,
          ),
          if (!isLoading) const LogoutButtonOld(),
        ],
      ),
    );
  }
}
