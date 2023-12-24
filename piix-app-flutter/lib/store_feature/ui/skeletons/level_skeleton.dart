import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/column_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

///This widget is the skeleton levels loader, only shows when [LevelState] is
///idle or getting
///
class LevelSkeleton extends StatelessWidget {
  const LevelSkeleton({super.key});

  double get mediumPading => ConstantsDeprecated.mediumPadding;
  double get textSkeletonHigh => 10;
  double get tagHeight => 48;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: true,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final maxWidth = constraints.maxWidth;
            return Container(
              width: maxWidth,
              margin: EdgeInsets.only(
                top: 31.h,
                left: mediumPading.w,
                right: mediumPading.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonDeprecated(
                    height: textSkeletonHigh.h,
                    width: maxWidth.percentageSize(0.225),
                  ).padBottom(22.h),
                  ColumnTextSkeletonDeprecated(listOfWidths: [
                    maxWidth,
                    maxWidth,
                    maxWidth.percentageSize(0.512)
                  ]).padBottom(27.h),
                  SkeletonDeprecated(
                    height: tagHeight.h,
                    width: maxWidth,
                  ).padBottom(24.h),
                  SkeletonDeprecated(
                    height: tagHeight.h,
                    width: maxWidth,
                  ).padBottom(34.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SkeletonDeprecated(
                            height: textSkeletonHigh.h,
                            width: maxWidth.percentageSize(0.138),
                          ).padBottom(25.h),
                          ColumnTextSkeletonDeprecated(listOfWidths: [
                            maxWidth.percentageSize(0.425),
                            maxWidth.percentageSize(0.425),
                            maxWidth.percentageSize(0.425)
                          ]),
                        ],
                      ).padLeft(34.w),
                      SkeletonDeprecated(
                        height: 96.h,
                        width: maxWidth.percentageSize(0.188),
                      ).padRight(34.w)
                    ],
                  ).padBottom(37.h),
                  SkeletonDeprecated(
                    height: textSkeletonHigh.h,
                    width: maxWidth.percentageSize(0.406),
                  ).padBottom(22.h),
                  ColumnTextSkeletonDeprecated(listOfWidths: [
                    maxWidth,
                    maxWidth,
                    maxWidth.percentageSize(0.512)
                  ]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
