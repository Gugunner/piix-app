import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a column of text skeletons
///require the list of the widths of each element
///
class ShimmerColumnDeprecated extends StatelessWidget {
  const ShimmerColumnDeprecated({
    super.key,
    required this.widths,
    this.heightBetweenElements = 6,
    this.height = 10,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });
  final List<double> widths;
  final double heightBetweenElements;
  final CrossAxisAlignment crossAxisAlignment;

  final double height;

  @override
  Widget build(BuildContext context) {
    final columnHeight = widths
        .map((_) => height + heightBetweenElements.h)
        .reduce((value, element) => value + element);
    return SizedBox(
      height: columnHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: crossAxisAlignment,
        children: widths.map(
          (width) {
            return Container(
              margin: EdgeInsets.only(bottom: heightBetweenElements.h),
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
