import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_text.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a membership headers, contains a welcome text, and
///instructions text.
class MembershipHeaderDeprecated extends StatelessWidget {
  const MembershipHeaderDeprecated({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final userBLoC = context.watch<UserBLoCDeprecated>();
    final user = userBLoC.user;
    final memberships = userBLoC.user?.memberships ?? [];
    final membershipInstructionsText = memberships.length > 0
        ? PiixCopiesDeprecated.membershipInstructions
        : PiixCopiesDeprecated.noMembershipsText;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: ShimmerText(
            isLoading: isLoading,
            child: Text(
              '${PiixCopiesDeprecated.welcomeText} '
              '${user?.displayNames(max: 1)} '
              '${user?.displayLastNames(max: 1)}',
              // overflow: TextOverflow.ellipsis,
              style: context.textTheme?.titleMedium,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        // const Expanded(child: SizedBox()),
        SizedBox(
          child: ShimmerText(
            isLoading: isLoading,
            child: Text(
              membershipInstructionsText,
              style: context.textTheme?.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
