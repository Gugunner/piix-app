import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///This widget is a skeleton with grey decoration for all skeleton pages
///
@Deprecated('Use instead ShimmerWidgetWrapper and pass the box shape and color')
class SkeletonDeprecated extends StatelessWidget {
  const SkeletonDeprecated({super.key, this.width, this.height});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: PiixColors.skeletonGrey,
        ),
      ),
    );
  }
}
