import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a bullet with explain of color cells in comparison table
///
class MeaningTableColorDeprecated extends StatelessWidget {
  const MeaningTableColorDeprecated({
    super.key,
    this.meaningColor,
    this.borderColor,
    required this.meaningText,
  });
  final Color? meaningColor;
  final Color? borderColor;
  final String meaningText;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? PiixColors.cloud),
            color: meaningColor ?? PiixColors.space,
            shape: BoxShape.circle,
          ),
          height: mediumPadding.h,
          width: mediumPadding.w,
        ).padRight(10.w),
        Flexible(
          child: Text(
            meaningText,
            style: context.textTheme?.labelMedium,
          ),
        )
      ],
    );
  }
}
