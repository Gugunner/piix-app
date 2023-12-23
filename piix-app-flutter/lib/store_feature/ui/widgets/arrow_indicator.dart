import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('No longer in use 4.0')

///This widget contains an arrow indicator to indicate if there are more modules
class ArrowIndicatorDeprecated extends StatelessWidget {
  const ArrowIndicatorDeprecated(
      {super.key, this.direction = ConstantsDeprecated.right});
  final String direction;

  IconData get directionIcon => direction == ConstantsDeprecated.right
      ? Icons.arrow_forward_ios
      : Icons.arrow_back_ios;

  @override
  Widget build(BuildContext context) {
    return Icon(directionIcon,
        color: PiixColors.tertiaryText.withOpacity(0.6), size: 55.h);
  }
}
