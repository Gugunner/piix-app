import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/app_bar/static_app_bar_deprecated.dart';

@Deprecated('Use instead NotificationsAppBar')
class MembershipAppBar extends StaticAppBar {
  const MembershipAppBar({
    super.key,
    required super.title,
    this.notificationCount = 0,
  })  : assert(title != null && title.length > 0),
        assert(notificationCount >= 0);

  final int notificationCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaticAppBarBuilder(
      title: title,
      actions: [
        _NotificationsAlertButton(notificationCount: notificationCount),
      ],
    );
  }
}

class _NotificationsAlertButton extends StatelessWidget {
  const _NotificationsAlertButton({
    required this.notificationCount,
  });

  final int notificationCount;

  void toNofitications() {
    print('To Notification');
    //TODO: Add call detailed notifications
    //TODO: Uncomment line once new app bar is connected to auth process
    // Navigation.push(NotificationsScreen.routeName);
    //TODO: Delete after real navigation is added
    NavigatorKeyState().getNavigator()?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: toNofitications,
      icon: Stack(
        children: [
          SizedBox(
            height: context.height,
            child: const Icon(
              Icons.notifications,
            ),
          ),
          if (notificationCount > 0)
            Positioned(
              top: 0,
              right: 0,
              child: _NotificationsAlert(notificationCount: notificationCount),
            ),
        ],
      ),
    );
  }
}

class _NotificationsAlert extends StatelessWidget {
  const _NotificationsAlert({
    required this.notificationCount,
  });

  final int notificationCount;

  int get maxDisplayValue => 99;

  @override
  Widget build(BuildContext context) {
    final count = notificationCount > maxDisplayValue
        ? '$maxDisplayValue+'
        : '$notificationCount';
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 4.w,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: PiixColors.error,
      ),
      child: Text(
        '$count',
        style: context.bodySmall?.copyWith(
          color: PiixColors.white,
        ),
      ),
    );
  }
}
