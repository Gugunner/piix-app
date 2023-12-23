import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';

///This widget render a row of text skeletons
///require the list of the widths of each element
@Deprecated('Use ShimmerRow instead')
class RowTextSkeletonDeprecated extends StatelessWidget {
  const RowTextSkeletonDeprecated({
    super.key,
    required this.listOfWidths,
  });
  final List<double> listOfWidths;

  double get textSkeletonHigh => 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        listOfWidths.length,
        (index) => SkeletonDeprecated(
          height: textSkeletonHigh.h,
          width: listOfWidths[index],
        ),
      ),
    );
  }
}
