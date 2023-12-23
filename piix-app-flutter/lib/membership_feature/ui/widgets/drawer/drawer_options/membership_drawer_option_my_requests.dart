import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "My requests" option and navigates to [MyRequestsScreen].
final class MembershipDrawerOptionMyRequests extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionMyRequests({super.key});

  ///Return the AppLocalization message of "My requests".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.myRequests;

  ///Navigates to [MyRequestsScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
