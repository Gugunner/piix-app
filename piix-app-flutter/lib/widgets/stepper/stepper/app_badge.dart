import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A 20 by 20 circular badge that shows a [value] inside its center.
final class AppBadge extends StatelessWidget {
  const AppBadge(
    this.value, {
    super.key,
    this.color,
    this.valueColor,
  });
  
  final int value;

  final Color? color;

  final Color? valueColor;

  double get _width => 20.w;

  double get _height => 20.w;

  Color get _color => color ?? PiixColors.primary;

  Color get _valueColor => valueColor ?? PiixColors.space;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _color,
        ),
        child: Text(
          '$value',
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(color: _valueColor),
        ),
      ),
    );
  }
}
