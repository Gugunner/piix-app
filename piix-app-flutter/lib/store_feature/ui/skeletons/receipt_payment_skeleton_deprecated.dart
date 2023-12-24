import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/column_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Will be removed in 4.0')

///This is a loading skeleton for receipt payment screen
///
class ReceiptPaymentSkeletonDeprecated extends StatelessWidget {
  const ReceiptPaymentSkeletonDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        return Container(
          width: context.width,
          color: PiixColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SkeletonDeprecated(
                height: maxHeight.percentageSize(0.508),
              ).padBottom(14.h),
              ColumnTextSkeletonDeprecated(
                listOfWidths: [
                  maxWidth.percentageSize(0.709),
                  maxWidth.percentageSize(0.512)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ).padBottom(10.h),
              SkeletonDeprecated(
                height: 36.h,
                width: maxWidth.percentageSize(0.25),
              ).padBottom(60.h),
              SkeletonDeprecated(
                height: 40.h,
                width: maxWidth.percentageSize(0.850),
              ).padBottom(3.h),
              SkeletonDeprecated(
                height: 10.h,
                width: maxWidth.percentageSize(0.806),
              ).padBottom(32.h),
              ColumnTextSkeletonDeprecated(
                listOfWidths: [
                  maxWidth.percentageSize(0.794),
                  maxWidth.percentageSize(0.681)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
