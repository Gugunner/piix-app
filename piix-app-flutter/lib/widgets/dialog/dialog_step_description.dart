import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/dialog/bubble_dialog_stepper.dart';

///A numbered instruction to explain the steps of a processs
class DialogStepDescription extends StatelessWidget {
  const DialogStepDescription({
    super.key,
    required this.header,
    required this.description,
    this.step = 0,
  });

  ///What the instruction is about
  final String header;

  ///The instruction
  final String description;

  ///Then instruction number
  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BubbleDialogStepper(step),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.infoDefault,
                ),
              ),
              Text(
                description,
                style: context.bodyMedium?.copyWith(
                  color: PiixColors.infoDefault,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
