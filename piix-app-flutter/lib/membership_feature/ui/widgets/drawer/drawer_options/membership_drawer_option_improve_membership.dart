import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "Improve my membership" option and navigates to [StoreHomeScreen].
final class MembershipDrawerOptionImproveMembership extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionImproveMembership({super.key});

  ///Return the AppLocalization message of "Improve my membership".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.improveMembership;

  ///Navigates to [StoreHomeScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
