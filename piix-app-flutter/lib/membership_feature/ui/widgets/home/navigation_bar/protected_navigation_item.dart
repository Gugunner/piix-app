import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/notification_item_icon.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';

///Use inside [MembershipNavigationBar] to show the protected option
class ProtectedNavigationItem extends BottomNavigationBarItem {
  ProtectedNavigationItem(this.notificationCount)
      : super(
          icon: NotificationItemIcon(
            icon: PiixIcons.protegidos,
            count: notificationCount,
          ),
          backgroundColor: PiixColors.cloud,
          label: PiixCopiesDeprecated.protectedText,
        );

  //The number of protected currently not assigned
  //to show as a notification bubble
  final int notificationCount;
}
