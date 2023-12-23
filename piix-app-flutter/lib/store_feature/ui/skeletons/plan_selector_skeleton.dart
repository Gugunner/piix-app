import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';

///This skeleton shows a simulate selector for number of protected
///
class PlanSelector extends StatelessWidget {
  const PlanSelector({super.key, required this.maxWidth});
  final double maxWidth;
  double get skeletonSize => 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SkeletonDeprecated(
              height: skeletonSize.h,
              width: skeletonSize.w,
            ),
            SkeletonDeprecated(
              height: skeletonSize.h,
              width: 56.w,
            ).padHorizontal(10.w),
            SkeletonDeprecated(
              height: skeletonSize.h,
              width: skeletonSize.w,
            )
          ],
        ).padBottom(6.h),
        SkeletonDeprecated(
          height: 10.h,
          width: maxWidth.percentageSize(0.122),
        )
      ],
    );
  }
}
