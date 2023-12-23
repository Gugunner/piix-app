import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/grid_cards_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a additional benefits per supplier catalog skeleton
///This widget only shows when a loading state is present
///
class AdditionalBenefitsPerSupplierCatalogSkeletonDeprecated
    extends StatelessWidget {
  const AdditionalBenefitsPerSupplierCatalogSkeletonDeprecated({super.key});

  double get benefitSkeletonPadding => 21;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: true,
        child: LayoutBuilder(builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: maxHeight.percentageSize(0.038),
              horizontal: ConstantsDeprecated.mediumPadding.w,
            ),
            child: Column(
              children: [
                //This is the component for special offers
                Padding(
                  padding:
                      EdgeInsets.only(bottom: maxHeight.percentageSize(0.031)),
                  child: RowTextSkeletonDeprecated(
                    listOfWidths: [
                      maxWidth.percentageSize(0.425),
                      maxWidth.percentageSize(0.238),
                    ],
                  ),
                ),
                //This is the component for combo image
                Padding(
                  padding:
                      EdgeInsets.only(bottom: maxHeight.percentageSize(0.045)),
                  child: SkeletonDeprecated(
                      height: maxHeight.percentageSize(0.234)),
                ),
                //This is the component for benefit types title
                Padding(
                  padding:
                      EdgeInsets.only(bottom: maxHeight.percentageSize(0.038)),
                  child: RowTextSkeletonDeprecated(
                    listOfWidths: [
                      maxWidth.percentageSize(0.375),
                      maxWidth.percentageSize(0.366),
                    ],
                  ),
                ),
                //This is the component for benefit types cards
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: maxHeight.percentageSize(0.020),
                      left: benefitSkeletonPadding.w,
                      right: benefitSkeletonPadding.w,
                    ),
                    child: const GridCardsSkeletonDeprecated(numberOfCards: 4),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
