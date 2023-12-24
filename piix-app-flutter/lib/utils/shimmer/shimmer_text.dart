import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

//TODO: Analyze if it is needed for 4.0
class ShimmerText extends StatelessWidget {
  const ShimmerText({
    super.key,
    required this.child,
    this.isLoading = false,
  });

  final Text child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: context.width,
        height: 24.h,
        child: const Card(),
      );
    }
    return SizedBox(
      child: child,
    );
  }
}
