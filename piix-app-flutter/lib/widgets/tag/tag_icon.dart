import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A specific [Icon] sized for tags.
class TagIcon extends StatelessWidget {
  const TagIcon({
    super.key,
    required this.icon,
    this.color = PiixColors.space,
  });

  ///The shape to show inside the [Icon].
  final IconData icon;
  ///The color of the [Icon].
  final Color color;

  ///The default size of the [Icon].
  @protected
  double get _size => 12.w;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: _size,
    );
  }
}
