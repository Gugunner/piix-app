import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';

///A composed class that shows as a vertical list all the
///[UserMembershipAttribute] subclass [_attributes].
final class UserMembershipCardContent extends StatelessWidget {
  const UserMembershipCardContent({
    super.key,
    required this.user,
    required this.membership,
  });

  ///All the data pertaining a user in the current session.
  final UserAppModel user;

  ///All the data pertaining the membership in session.
  final MembershipModel membership;

  ///The vertical space between each [_attributes]
  double get _space => 4.h;

  ///The list of key, value subclasses.
  List<UserMembershipAttribute> _getAttributes(BuildContext context) => [
        //TODO: Change to requestId once new membership service deploys Piix 4.0
        RequestIdAttribute(context, requestId: membership.membershipId.substring(0, 10)),
        ShortNameAttribute(context, shortName: user.displayShortFullName),
        //TODO: Change conditional once new membership service deploys Piix 4.0
        // if (membership.usersMembershipPlans.isNotNullOrEmpty)
        //   MyGroupAttribute(membership.usersMembershipPlans.length),
        MembershipSinceAttribute(context, memberSince: membership.registerDate),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserMembershipCardHeader(),
        SizedBox(height: _space),
        ..._getAttributes(context).map(
          (child) => Container(
            margin: EdgeInsets.only(bottom: _space),
            child: child,
          ),
        )
      ],
    );
  }
}
