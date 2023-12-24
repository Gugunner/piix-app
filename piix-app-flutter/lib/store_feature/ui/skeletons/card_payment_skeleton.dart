import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_tag_skeletons_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///This is a card payment skeleton, includes a row tag skeleton, amd skeleton
///text
///
class CardPaymentSkeleton extends StatelessWidget {
  const CardPaymentSkeleton({
    super.key,
    required this.maxWidth,
    this.firstListOfWidths = const [],
    this.secondListOfWidths = const [],
  });
  final double maxWidth;
  final List<double> firstListOfWidths;
  final List<double> secondListOfWidths;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Container(
          color: PiixColors.greyWhite,
          width: maxWidth,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonDeprecated(
                      height: 10.h, width: maxWidth.percentageSize(0.197))
                  .padBottom(10.h),
              RowTagSkeletonDeprecated(listOfWidths: firstListOfWidths)
                  .padBottom(firstListOfWidths.isEmpty ? 0.h : 6.h),
              RowTagSkeletonDeprecated(listOfWidths: secondListOfWidths),
            ],
          ),
        ));
  }
}
