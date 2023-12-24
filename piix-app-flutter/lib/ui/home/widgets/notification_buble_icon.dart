import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead NotificationItemIcon')
///This widget is a piix bottom navigation bar icon with notification bubbles.
class NotificationBubbleIcon extends StatelessWidget {
  const NotificationBubbleIcon({
    Key? key,
    required this.notifications,
  }) : super(key: key);
  final int notifications;

  String get numberOfNotifications => notifications.toString();
  bool get isOneDigit => numberOfNotifications.length == 1;
  double get horizontalPad => isOneDigit ? 4 : 3;
  double get bottomPad => isOneDigit ? 2 : 1.5;
  Color get bubbleColor => PiixColors.errorText;
  Decoration get bubbleDecoration => isOneDigit
      ? BoxDecoration(
          shape: BoxShape.circle,
          color: bubbleColor,
        )
      : ShapeDecoration(
          shape: const StadiumBorder(),
          color: bubbleColor,
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: horizontalPad.w,
            right: horizontalPad.w,
            bottom: bottomPad.h,
          ),
          decoration: bubbleDecoration,
          child: Text(
            numberOfNotifications,
            style: context.bodySmall?.copyWith(
              color: PiixColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
