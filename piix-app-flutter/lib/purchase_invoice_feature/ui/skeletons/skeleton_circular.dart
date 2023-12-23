import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///This widget is a skeleton circular with grey decoration for all skeleton pages
///
@Deprecated('Use instead ShimmerWidgetWrapper and pass the box shape and color')
class SkeletonCircular extends StatelessWidget {
  const SkeletonCircular({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        height: height,
        width: height,
        decoration: const BoxDecoration(
            color: PiixColors.skeletonGrey, shape: BoxShape.circle),
      ),
    );
  }
}
