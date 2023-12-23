import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A bubble that shows a number [step] at
///the center pass on an index or a constant int
///Do not exceed 100 items, starting at 0.
class BubbleDialogStepper extends StatelessWidget {
  const BubbleDialogStepper(
    this.step, {
    super.key,
    this.color,
  }) : assert(step >= 0 && step < 100);

  ///The step number
  final int step;

  ///Background color
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? PiixColors.primary,
      ),
      child: Text(
        '$step',
        style: context.bodyMedium?.copyWith(
          color: PiixColors.space,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
