import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///When the benefit is already acquired, this is the banner that will appear.
///
class AlreadyAcquiredAdditionalBenefitBannerDeprecated extends StatelessWidget {
  const AlreadyAcquiredAdditionalBenefitBannerDeprecated(
      {super.key,
      required this.label,
      this.color = PiixColors.successMain,
      this.height = 30,
      this.labelStyle,
      this.borderRadius});
  final String label;
  final Color? color;
  final double height;
  final TextStyle? labelStyle;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: context.width,
      padding: EdgeInsets.all(
        4.w,
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: borderRadius ?? null),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: labelStyle ??
              context.accentTextTheme?.titleLarge?.copyWith(
                color: PiixColors.white,
                height: 12.sp / 12.sp,
              ),
        ),
      ),
    );
  }
}
