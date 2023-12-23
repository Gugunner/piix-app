import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/color_utils.dart';

enum ColorVariant {
  one,
  two,
}

final _minCardWidth = 68.w;
final _maxCardWidth = 288.w;

final _minCardHeight = 32.h;

class AppCardOld extends StatelessWidget {
  const AppCardOld({
    super.key,
    this.variant = ColorVariant.one,
    this.child,
    this.color,
    this.width,
  });

  final ColorVariant variant;
  final Widget? child;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final shadowColor = ColorUtils.lighten(PiixColors.contrast10, 0.5);
    return Container(
      width: width,
      constraints: BoxConstraints(
        minWidth: _minCardWidth,
        maxWidth: _maxCardWidth,
        minHeight: _minCardHeight,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 0.01,
            blurRadius: 0.05,
            offset: const Offset(0.5, 0),
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: shadowColor,
            spreadRadius: 0,
            blurRadius: 0.05,
            offset: const Offset(-0.1, -0.1),
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: shadowColor,
            spreadRadius: 2,
            blurRadius: 0.05,
            offset: const Offset(0, 0.5),
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: child,
    );
  }

  Color get cardColor {
    if (color != null) return color!;
    if (variant == ColorVariant.one) return PiixColors.space;
    return PiixColors.sky;
  }
}
