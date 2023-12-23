import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a grid of skeleton cards, require the number of cards
///to show,
///As optional parameters it has crossAxisCount, mainAxisSpacing,
///crossAxisSpacing
///
class GridCardsSkeletonDeprecated extends StatelessWidget {
  const GridCardsSkeletonDeprecated({
    super.key,
    required this.numberOfCards,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 20,
    this.crossAxisSpacing = 16,
  });
  final int numberOfCards;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing.h,
      crossAxisSpacing: crossAxisSpacing.h,
      children: List.generate(numberOfCards, (index) {
        return const SkeletonDeprecated();
      }),
    );
  }
}
