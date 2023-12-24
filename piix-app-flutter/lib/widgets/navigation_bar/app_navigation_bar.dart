import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_barrel_file.dart';

///The default [BottomNavigationBar] of the app.
final class AppNavigationBar extends BottomNavigationBar {
  AppNavigationBar(this.context, {
    super.key,
    this.myMembershipNotificationsCount = 0,
    this.myGroupNotificationsCount = 0,
    this.storeNotificationsCount = 0,
    this.profileNotificationsCount = 0,
    this.newItems,
    super.currentIndex,
    super.onTap,
  }) : super(
          items: newItems ??
              [
                MyMembershipBarItem(context,
                    notificationsCount: myMembershipNotificationsCount),
                MyGroupBarItem(context,
                    notificationsCount: myGroupNotificationsCount),
                StoreBarItem(context,
                    notificationsCount: storeNotificationsCount),
                MyProfileBarItem(context,
                    notificationsCount: profileNotificationsCount),
              ],
          type: BottomNavigationBarType.shifting,
          backgroundColor: PiixColors.cloud,
          selectedItemColor: PiixColors.primary,
          unselectedItemColor: PiixColors.secondary,
          selectedLabelStyle: BaseTextTheme()
              .textTheme
              .bodyMedium
              ?.copyWith(color: PiixColors.primary),
          unselectedLabelStyle: BaseTextTheme()
              .textTheme
              .bodyMedium
              ?.copyWith(color: PiixColors.secondary),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        );

  final int myMembershipNotificationsCount;

  final int myGroupNotificationsCount;

  final int storeNotificationsCount;

  final int profileNotificationsCount;

  final List<BottomNavigationBarItem>? newItems;

  final BuildContext context;
}
