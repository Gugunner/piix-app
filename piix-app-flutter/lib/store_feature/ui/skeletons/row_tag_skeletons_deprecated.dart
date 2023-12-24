import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a skeleton for tags
///
class RowTagSkeletonDeprecated extends StatelessWidget {
  const RowTagSkeletonDeprecated({
    super.key,
    required this.listOfWidths,
    this.dividerWidth = 11,
  });
  final List<double> listOfWidths;
  final double dividerWidth;

  double get tagSkeletonHigh => 15;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        listOfWidths.length,
        (index) {
          final paddingLeft =
              index < listOfWidths.length - 1 ? dividerWidth.h : 0.0;
          return Padding(
            padding: EdgeInsets.only(right: paddingLeft),
            child: SkeletonDeprecated(
              height: tagSkeletonHigh.h,
              width: listOfWidths[index],
            ),
          );
        },
      ),
    );
  }
}
