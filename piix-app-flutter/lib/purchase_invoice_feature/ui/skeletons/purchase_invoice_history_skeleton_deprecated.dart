import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_column_deprecated.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

/// This widget is a skelton loading screen of purchase invoice history
///
class PurchaseInvoiceHistorySkeletonDeprecated extends StatelessWidget {
  const PurchaseInvoiceHistorySkeletonDeprecated({super.key});

  double get textSkeletonHigh => 10;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            return Container(
              width: context.width,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 24.h,
              ),
              child: IgnorePointer(
                ignoring: true,
                child: ListView(
                  children: [
                    ShimmerWrap(
                      child: SizedBox(
                        height: 24.h,
                        width: context.width,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ShimmerWrap(
                      child: SizedBox(
                        height: 32.h,
                        width: context.width,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ShimmerColumnDeprecated(
                      widths: List.generate(4, (index) => maxWidth),
                      height: 160.h,
                      heightBetweenElements: 20.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
