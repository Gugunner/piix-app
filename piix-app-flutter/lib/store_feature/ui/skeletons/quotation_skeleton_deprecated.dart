import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/column_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a quotation list skeleton
///
class QuotationSkeletonDeprecated extends StatelessWidget {
  const QuotationSkeletonDeprecated({Key? key}) : super(key: key);

  double get mediumPading => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          return Container(
            width: context.width,
            margin: EdgeInsets.symmetric(
              vertical: maxHeight.percentageSize(0.026),
              horizontal: mediumPading.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Render a total amount and discount card
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonDeprecated(
                        height: maxHeight.percentageSize(0.160),
                        width: maxWidth.percentageSize(0.248),
                      ),
                      SkeletonDeprecated(
                        height: maxHeight.percentageSize(0.160),
                        width: maxWidth.percentageSize(0.591),
                      ),
                    ]).padBottom(mediumPading.h),
                //Simulate a title
                SkeletonDeprecated(
                  height: maxHeight.percentageSize(0.049),
                  width: maxWidth.percentageSize(0.569),
                ).center().padBottom(10.h),
                //Simulate column of texts
                ColumnTextSkeletonDeprecated(listOfWidths: [
                  maxWidth.percentageSize(0.550),
                  maxWidth.percentageSize(0.300),
                ]).center().padBottom(11.h),
                //Simulate a info card
                SkeletonDeprecated(
                  height: maxHeight.percentageSize(0.164),
                  width: maxWidth,
                ).padBottom(29.h),
                //Simulate a info card
                ColumnTextSkeletonDeprecated(listOfWidths: [
                  maxWidth.percentageSize(0.506),
                ]).center().padBottom(38.h),
                //Simulate a text
                ColumnTextSkeletonDeprecated(listOfWidths: [
                  maxWidth.percentageSize(0.628),
                  maxWidth.percentageSize(0.219),
                  maxWidth.percentageSize(0.653),
                ]).padBottom(21.h),
                //Simulate a column of texts
                RowTextSkeletonDeprecated(listOfWidths: [
                  maxWidth.percentageSize(0.372),
                  maxWidth.percentageSize(0.372),
                ]).padBottom(8.h),
                SkeletonDeprecated(
                  height: 10.h,
                  width: maxWidth.percentageSize(0.372),
                ).padBottom(22.h),
                //Simulate a column of texts
                RowTextSkeletonDeprecated(listOfWidths: [
                  maxWidth.percentageSize(0.372),
                  maxWidth.percentageSize(0.372),
                ]).padBottom(8.h),
                SkeletonDeprecated(
                  height: 10.h,
                  width: maxWidth.percentageSize(0.372),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
