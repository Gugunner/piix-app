import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "My membership" option and navigates to [MyMembershipHomeScreen].
class MembershipDrawerOptionMyMembership extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionMyMembership({super.key});

  ///Return the AppLocalization message of "My membership".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.myMembership;
  ///Navigates to [MyMembershipHomeScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
