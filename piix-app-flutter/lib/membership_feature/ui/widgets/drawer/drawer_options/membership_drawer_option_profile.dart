import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "Profile" option and navigates to [ProfileHomeScreen].
final class MembershipDrawerOptionProfile extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionProfile({super.key});

  ///Return the AppLocalization message of "Profile".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.profile;

  ///Navigates to [ProfileHomeScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
