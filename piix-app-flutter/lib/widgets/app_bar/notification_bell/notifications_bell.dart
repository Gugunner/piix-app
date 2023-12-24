import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_barrel_file.dart';

///Builds a Bell [Icon] with a floating [AlertBubble] that
///shows notifications [count].
final class NotificationsBell extends StatelessWidget {
  const NotificationsBell(
    this.count, {
    super.key,
    required this.onTap,
  });

  final int count;

  final VoidCallback onTap;

  ///The default shape for the bell.
  IconData get _icon => Icons.notifications;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AlertBubbleIcon(
        AppBarIcon(_icon),
        count: count,
      ),
    );
  }
}
