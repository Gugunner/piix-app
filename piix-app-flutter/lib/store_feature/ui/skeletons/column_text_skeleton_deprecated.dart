import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a column of text skeletons
///require the list of the widths of each element

@Deprecated('Use ShimmerColumn instead')
class ColumnTextSkeletonDeprecated extends StatelessWidget {
  const ColumnTextSkeletonDeprecated({
    super.key,
    required this.listOfWidths,
    this.dividerHeight = 6,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });
  final List<double> listOfWidths;
  final double dividerHeight;
  final CrossAxisAlignment crossAxisAlignment;

  double get textSkeletonHigh => 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: List.generate(
        listOfWidths.length,
        (index) {
          final paddingBottom =
              index < listOfWidths.length - 1 ? dividerHeight.h : 0.0;
          return Padding(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: SkeletonDeprecated(
              height: textSkeletonHigh.h,
              width: listOfWidths[index],
            ),
          );
        },
      ),
    );
  }
}
