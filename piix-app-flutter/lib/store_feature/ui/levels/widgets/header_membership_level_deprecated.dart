import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains the current level text and current level in a rich text
///
class HeaderMembershipLevelDeprecated extends StatelessWidget {
  const HeaderMembershipLevelDeprecated({Key? key}) : super(key: key);

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final currentLevel =
        membershipBLoC.selectedMembership?.usersMembershipLevel.name;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mediumPadding.h, vertical: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: PiixCopiesDeprecated.currentLevel,
              style: context.primaryTextTheme?.titleMedium,
            ),
            TextSpan(text: currentLevel ?? ''),
          ],
          style: context.textTheme?.bodyMedium,
        ),
      ),
    );
  }
}
