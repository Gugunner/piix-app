import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/column_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_tag_skeletons_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a package combo list skeleton
///
class PackageComboListSkeletonDeprecated extends StatelessWidget {
  const PackageComboListSkeletonDeprecated({super.key});

  double get textSkeletonHigh => 10;
  double get horizontalPadding => 15;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            final tagWidth = maxWidth.percentageSize(0.212);
            return Container(
              width: context.width,
              margin: EdgeInsets.symmetric(
                vertical: maxHeight.percentageSize(0.037),
                horizontal: ConstantsDeprecated.mediumPadding.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //This is a title of package combos
                  SkeletonDeprecated(
                    height: textSkeletonHigh,
                    width: maxWidth.percentageSize(0.553),
                  ).padBottom(maxHeight.percentageSize(0.041)),
                  //This is a description of package combos
                  ColumnTextSkeletonDeprecated(listOfWidths: [
                    maxWidth,
                    maxWidth,
                    maxWidth.percentageSize(0.512)
                  ]).padBottom(maxHeight.percentageSize(0.070)),
                  //This is a title of package combo card
                  ColumnTextSkeletonDeprecated(listOfWidths: [
                    maxWidth.percentageSize(0.578),
                    maxWidth.percentageSize(0.325),
                  ]).padHorizontal(horizontalPadding).padBottom(11.h),
                  //This is a tag of package combo card
                  RowTagSkeletonDeprecated(listOfWidths: [tagWidth, tagWidth])
                      .padHorizontal(horizontalPadding)
                      .padBottom(22.h),
                  //This is a provider row of package combo card
                  RowTextSkeletonDeprecated(listOfWidths: [
                    maxWidth.percentageSize(0.444),
                    maxWidth.percentageSize(0.194),
                  ]).padHorizontal(horizontalPadding).padBottom(22.h),
                  //This is a description of package combo card
                  ColumnTextSkeletonDeprecated(listOfWidths: [
                    maxWidth,
                    maxWidth,
                    maxWidth.percentageSize(0.556)
                  ]).padHorizontal(horizontalPadding).padBottom(10.h),
                  //This is a discount of package combo card
                  SkeletonDeprecated(height: 24.h)
                      .padHorizontal(horizontalPadding)
                      .padBottom(20.h),
                  //This is a quotation button of package combo card
                  SkeletonDeprecated(height: 30.h)
                      .padHorizontal(54.w)
                      .padBottom(61.h),
                  //This is a title of package combo card
                  ColumnTextSkeletonDeprecated(listOfWidths: [
                    maxWidth.percentageSize(0.578),
                    maxWidth.percentageSize(0.325),
                  ]).padHorizontal(horizontalPadding).padBottom(11.h),
                  //This is a tag of package combo card
                  RowTagSkeletonDeprecated(listOfWidths: [tagWidth, tagWidth])
                      .padHorizontal(horizontalPadding),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
