import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A thin [Container] rectangle that is either [_filledColor] or
///[_emptyColor] based on the [filled] property and with a specified [width].
final class AppFilledStep extends StatelessWidget {
  const AppFilledStep({
    super.key,
    required this.width,
    this.filled = false,
  });
  
  ///The specified size in the x axis.
  final double width;

  ///Whether the [Container] is [_filledColor] or
  ///[_emptyColor].
  final bool filled;

  ///The predefined size in the y axis.
  double get _height => 3.h;

  ///The color of the [Container] when [filled] is true.
  Color get _filledColor => PiixColors.primary;
  ///The color of the [Container] when [filled] is false.
  Color get _emptyColor => PiixColors.secondaryLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: _height,
      color: filled ? _filledColor : _emptyColor,
    );
  }
}
