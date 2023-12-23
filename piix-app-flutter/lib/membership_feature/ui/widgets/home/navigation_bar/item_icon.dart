import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///A fixed [size] icon
class ItemIcon extends StatelessWidget {
  const ItemIcon({
    super.key,
    required this.icon,
  });

  ///The icon to be shown inside a NavigationItem
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52.w,
      child: Icon(
        icon,
        size: 24.w,
      ),
    );
  }
}
