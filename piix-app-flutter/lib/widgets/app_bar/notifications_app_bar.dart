import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_title.dart';
import 'package:piix_mobile/widgets/app_bar/defined_app_bar.dart';
import 'package:piix_mobile/widgets/app_bar/notification_bell/notifications_bell.dart';

///An [AppBar] that has [appBarTitle] and a [NotificationsBell] 
///element which triggers an action with an [onTap] callback execution.
///
///Shows the [notificationsCount] for the [NotificationsHub]
final class NotificationsAppBar extends DefinedAppBar {
  NotificationsAppBar({
    super.key,
    required this.appBarTitle,
    required this.onTap,
    this.notificationsCount = 0,
  }) : super(title: AppBarTitle(appBarTitle), actions: [
          SizedBox(width: 10.w),
          NotificationsBell(notificationsCount, onTap: onTap)
        ]);

  final String appBarTitle;

  final int notificationsCount;

  final VoidCallback onTap;
}
