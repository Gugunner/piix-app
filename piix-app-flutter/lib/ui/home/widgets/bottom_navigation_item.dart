import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/ui/home/widgets/switcher_animated_bottom_icon.dart';

@Deprecated('Use either ItemIcon or NotificationItemIcon')
class BottomNavigationIcon extends StatelessWidget {
  const BottomNavigationIcon({
    super.key,
    required this.icon,
    this.numberOfNotifications = 0,
    this.isAnimated = false,
  });
  final IconData icon;
  final int numberOfNotifications;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42.w,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 24.h,
            ),
          ),
          if (numberOfNotifications > 0)
            SwitcherAnimatedBottomIcon(
              isAnimated: isAnimated,
              numberOfNotifications: numberOfNotifications,
            )
        ],
      ),
    );
  }
}
