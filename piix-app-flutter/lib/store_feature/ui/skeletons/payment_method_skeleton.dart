import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/card_payment_skeleton.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/column_text_skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/skeleton_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///This is a loading skeleton payment method screen
///
class PaymentMethodSkeleton extends StatelessWidget {
  const PaymentMethodSkeleton({super.key});
  double get mediumPading => ConstantsDeprecated.mediumPadding;
  double get textPadding => 10;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          return Container(
            width: context.width,
            color: PiixColors.white,
            padding: EdgeInsets.symmetric(
              vertical: maxHeight.percentageSize(0.026),
              horizontal: mediumPading.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Render a total amount and discount card
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonDeprecated(
                        height: maxHeight.percentageSize(0.160),
                        width: maxWidth.percentageSize(0.248),
                      ),
                      SkeletonDeprecated(
                        height: maxHeight.percentageSize(0.160),
                        width: maxWidth.percentageSize(0.591),
                      ),
                    ]).padBottom(mediumPading.h),
                SkeletonDeprecated(
                  height: textPadding.h,
                  width: maxWidth.percentageSize(0.669),
                ).padBottom(18.h),
                ColumnTextSkeletonDeprecated(listOfWidths: [
                  maxWidth,
                  maxWidth.percentageSize(0.615),
                ]).padBottom(25.h),
                CardPaymentSkeleton(
                  maxWidth: maxWidth,
                  firstListOfWidths: [
                    maxWidth.percentageSize(0.078),
                  ],
                ).padBottom(textPadding.h),
                CardPaymentSkeleton(
                  maxWidth: maxWidth,
                  firstListOfWidths: [
                    maxWidth.percentageSize(0.181),
                    maxWidth.percentageSize(0.078),
                    maxWidth.percentageSize(0.078),
                    maxWidth.percentageSize(0.181),
                    maxWidth.percentageSize(0.078),
                  ],
                  secondListOfWidths: [
                    maxWidth.percentageSize(0.141),
                  ],
                ).padBottom(textPadding.h),
                CardPaymentSkeleton(
                  maxWidth: maxWidth,
                  firstListOfWidths: [
                    maxWidth.percentageSize(0.078),
                    maxWidth.percentageSize(0.112),
                    maxWidth.percentageSize(0.078),
                  ],
                ).padBottom(textPadding.h),
                Card(
                    elevation: 0,
                    child: Container(
                      color: PiixColors.greyWhite,
                      width: maxWidth,
                      padding: EdgeInsets.only(left: 15.w, top: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonDeprecated(
                                  height: textPadding.h,
                                  width: maxWidth.percentageSize(0.197))
                              .padBottom(textPadding.h)
                        ],
                      ),
                    ))
                //Simulate a title
              ],
            ),
          );
        },
      ),
    );
  }
}
