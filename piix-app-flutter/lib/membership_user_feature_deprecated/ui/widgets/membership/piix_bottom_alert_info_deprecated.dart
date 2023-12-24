import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a custom bottom alert info.
class PiixBottomAlertInfoDeprecated extends StatelessWidget {
  const PiixBottomAlertInfoDeprecated(
      {Key? key, required this.child, required this.color, this.onTap})
      : super(key: key);

  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: screenUtil.setWidth(7),
              vertical: screenUtil.setHeight(9)),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
