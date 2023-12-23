import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/ui/home/widgets/notification_buble_icon.dart';
import 'package:provider/provider.dart';

@Deprecated('Use NotificationItemIcon')
///This widget switches between animated notification item or not
///
class SwitcherAnimatedBottomIcon extends StatelessWidget {
  const SwitcherAnimatedBottomIcon({
    super.key,
    required this.numberOfNotifications,
    this.isAnimated = false,
  });
  final bool isAnimated;
  final int numberOfNotifications;

  @override
  Widget build(BuildContext context) {
    final notificationBLoC = context.watch<NotificationBLoC>();
    return isAnimated
        ? Positioned(
            left: 24.2.sp,
            child: Bounce(
              from: ScreenUtil().setHeight(15),
              animate: false,
              controller: (controller) =>
                  notificationBLoC.closeSnackController = controller,
              child: NotificationBubbleIcon(
                notifications: numberOfNotifications,
              ),
            ),
          )
        : Align(
            alignment: Alignment.topRight,
            child: NotificationBubbleIcon(
              notifications: numberOfNotifications,
            ),
          );
  }
}
