import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a row that contains two elements, a circle container with index and
///the label for a instruction to create plan quotation
///
class InfoDialogStepDeprecated extends StatelessWidget {
  const InfoDialogStepDeprecated({
    super.key,
    required this.step,
    required this.stepNumber,
  });
  final String step;
  final int stepNumber;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  double get circleSize => 20;
  Decoration get circleDecoration => const BoxDecoration(
        color: PiixColors.twilightBlue,
        shape: BoxShape.circle,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: circleSize.h,
            width: circleSize.h,
            margin: EdgeInsets.only(right: mediumPadding.w),
            decoration: circleDecoration,
            child: Text(
              '$stepNumber',
              textAlign: TextAlign.center,
              style: context.textTheme?.bodyMedium?.copyWith(
                color: PiixColors.space,
              ),
            )),
        Flexible(
          child: Text(
            step,
            style: context.textTheme?.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}
