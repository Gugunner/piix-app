import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/banner_plan_container.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/plan_selector_skeleton.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';

///This widget is the skeleton plans loader, only shows when [PlanState] is
///idle or getting
///
class PlanSkeleton extends StatelessWidget {
  const PlanSkeleton({Key? key}) : super(key: key);
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BannerPlanContainer(),
        Text(
          PiixCopiesDeprecated.configureYourProtected,
          style: context.primaryTextTheme?.titleSmall,
        ).padHorizontal(mediumPadding.w).padBottom(19.h),
        Shimmer(
          child: ShimmerLoading(
            isLoading: true,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                return Container(
                  width: context.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: mediumPadding.w,
                  ),
                  child: Column(
                    children: [
                      RowTextSkeletonDeprecated(listOfWidths: [
                        maxWidth.percentageSize(0.594),
                        maxWidth.percentageSize(0.116),
                      ]).padBottom(11.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SkeletonDeprecated(
                          height: 10.h,
                          width: maxWidth.percentageSize(0.60),
                        ),
                      ).padBottom(19.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonDeprecated(
                            height: 10.h,
                            width: maxWidth.percentageSize(0.238),
                          ).padTop(8.h),
                          PlanSelector(maxWidth: maxWidth),
                        ],
                      ).padBottom(29.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonDeprecated(
                            height: 10.h,
                            width: maxWidth.percentageSize(0.238),
                          ).padTop(8.h),
                          PlanSelector(maxWidth: maxWidth),
                        ],
                      ).padBottom(29.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonDeprecated(
                            height: 10.h,
                            width: maxWidth.percentageSize(0.238),
                          ).padTop(8.h),
                          PlanSelector(maxWidth: maxWidth),
                        ],
                      ).padBottom(40.h),
                      SkeletonDeprecated(
                        height: 10.h,
                        width: maxWidth.percentageSize(0.862),
                      ).padBottom(8.h),
                      SkeletonDeprecated(
                        height: 10.h,
                        width: maxWidth.percentageSize(0.550),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
