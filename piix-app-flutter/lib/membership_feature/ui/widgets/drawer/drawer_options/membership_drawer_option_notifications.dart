import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///An [IDrawerOptionNavigation] class that builds a [MembershipDrawerOption]
///that shows "Notifications" option and navigates to [NotificationsScreen].
final class MembershipDrawerOptionNotifications extends StatelessWidget
    implements IDrawerOptionNavigation {
  const MembershipDrawerOptionNotifications({super.key});

  ///Return the AppLocalization message of "Notifications".
  @override
  String getOptionMessage(BuildContext context) =>
      context.localeMessage.notifications;

  ///Navigates to [NotificationsScreen].
  @override
  void navigateTo(BuildContext context) {
    // TODO: implement navigateTo
  }

  @override
  Widget build(BuildContext context) {
    return MembershipDrawerOption(getOptionMessage(context), () => navigateTo);
  }
}
