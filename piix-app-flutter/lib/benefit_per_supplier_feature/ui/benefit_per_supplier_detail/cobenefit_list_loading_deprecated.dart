import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_loading.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a loading screen for cobenefit list
///
class CobenefitListLoadingDeprecated extends StatelessWidget {
  const CobenefitListLoadingDeprecated({
    super.key,
    required this.isLoading,
  });
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: List.generate(
              3,
              (index) => Card(
                child: SizedBox(
                  height: kMinInteractiveDimension,
                  width: context.width,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
