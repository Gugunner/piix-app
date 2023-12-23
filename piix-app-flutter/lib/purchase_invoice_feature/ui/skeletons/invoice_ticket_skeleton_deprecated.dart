import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/skeletons/skeleton_circular.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/column_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/row_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';

@Deprecated('Will be removed in 4.0')

///This is a purchase ticket skeleton
class InvoiceTicketSkeletonDeprecated extends StatelessWidget {
  const InvoiceTicketSkeletonDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            return SizedBox(
              width: context.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerWrap(
                    child: SizedBox(
                      height: 135.h,
                      width: maxWidth,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  ColumnTextSkeletonDeprecated(
                    listOfWidths: [
                      maxWidth.percentageSize(0.80),
                      maxWidth.percentageSize(0.525)
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ColumnTextSkeletonDeprecated(
                    listOfWidths: [
                      maxWidth.percentageSize(0.637),
                      maxWidth.percentageSize(0.525)
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ShimmerWrap(
                    child: SizedBox(
                      height: 131.h,
                      width: maxWidth.percentageSize(0.9),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  SkeletonCircular(
                    height: 24.h,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ColumnTextSkeletonDeprecated(
                    listOfWidths: [
                      maxWidth.percentageSize(0.525),
                      maxWidth.percentageSize(0.8),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  RowTextSkeletonDeprecated(
                          listOfWidths: [maxWidth.percentageSize(0.216)])
                      .padHorizontal(32.w),
                  SizedBox(
                    height: 12.h,
                  ),
                  RowTextSkeletonDeprecated(listOfWidths: [
                    maxWidth.percentageSize(0.372),
                    maxWidth.percentageSize(0.372)
                  ]).padHorizontal(32.w)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
