import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///This widget is a dot indicator, receives a isActive flag
///
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  double get dotSize => 16.w;
  Color get colorDot => isActive ? PiixColors.active : PiixColors.greyTotalCard;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      height: dotSize,
      width: dotSize,
      decoration: BoxDecoration(
        color: colorDot,
        shape: BoxShape.circle,
      ),
    );
  }
}
