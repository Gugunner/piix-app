import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';

///This widget render a row of text skeletons
///require the list of the widths of each element
///
class RowTextSkeleton extends StatelessWidget {
  const RowTextSkeleton({
    super.key,
    required this.heights,
    this.widthBetweenElements = 6,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.width = 10,
  });
  final List<double> heights;
  final double widthBetweenElements;
  final CrossAxisAlignment crossAxisAlignment;
  final double width;

  @override
  Widget build(BuildContext context) {
    final rowWidth = heights
        .map((_) => width + widthBetweenElements.w)
        .reduce((value, element) => value + element);
    return SizedBox(
      width: rowWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: crossAxisAlignment,
        children: heights.map(
          (height) {
            return Container(
              margin: EdgeInsets.only(bottom: widthBetweenElements.h),
              child: ShimmerWrap(
                child: SizedBox(
                  width: width,
                  height: height,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
