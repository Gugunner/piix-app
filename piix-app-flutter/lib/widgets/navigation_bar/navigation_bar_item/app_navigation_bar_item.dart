import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/widgets/app_bar/notification_bell/app_bar_alert_bubble_icon.dart';
///The basic [BottomNavigationBarItem] for the app with default 
///[size] and [backgroundColor].
///
///This [BottomNavigationBarItem] creates an [icon] with an [AlertBubble], 
///so it also requires a [notificationsCount] value and an [iconData] vecto.
base class AppNavigationBarItem extends BottomNavigationBarItem {
  AppNavigationBarItem(
     {
      this.notificationsCount = 0,
    required this.iconData,
    super.label,
  }) : super(
          icon: AlertBubbleIcon(
            Icon(
              iconData,
              size: 32.w,
            ),
            count: notificationsCount,
          ),
          backgroundColor: PiixColors.cloud,
        );

  final IconData iconData;

  final int notificationsCount;
}
