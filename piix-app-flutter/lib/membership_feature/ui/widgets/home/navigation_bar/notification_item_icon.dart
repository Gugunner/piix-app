import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/item_icon.dart';

///A simple fixed Icon that shows a red bubble with the [count] value
///of current notifications.
class NotificationItemIcon extends StatelessWidget {
  const NotificationItemIcon({super.key, required this.icon, this.count = 0})
      : assert(count >= 0);

  ///Number of notifications to show
  ///in a red bubble
  final int count;

  ///The icon to be shown inside a NavigationItem
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ItemIcon(icon: icon),
        if (count > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Bounce(
              from: 24.h,
              animate: true,
              duration: const Duration(milliseconds: 600),
              child: _NotificationBubble(count),
            ),
          ),
      ],
    );
  }
}

///The red bubble floating over a [NotificationItemIcon]
class _NotificationBubble extends StatelessWidget {
  const _NotificationBubble(this.count) : assert(count >= 0);

  ///Number of notifications to show
  ///in a red bubble
  final int count;

  ///Maximum value to show of notifications
  int get maxCount => 99;

  @override
  Widget build(BuildContext context) {
    final displayCount = count > maxCount ? maxCount : count;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.w,
        horizontal: 4.w,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: PiixColors.error,
      ),
      child: Text(
        '$displayCount',
        style: context.bodySmall?.copyWith(
          color: PiixColors.white,
        ),
      ),
    );
  }
}
