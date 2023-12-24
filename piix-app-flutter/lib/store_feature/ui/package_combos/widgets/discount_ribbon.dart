import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This widget render a ribbon for a package combo discount
///
class DiscountRibbon extends StatelessWidget {
  const DiscountRibbon({
    super.key,
    required this.discount,
  });
  final double discount;

  @override
  Widget build(BuildContext context) {
    final percentDiscount = (discount * 100).toStringAsFixed(0);

    return ClipPath(
      child: Container(
        width: context.width,
        color: PiixColors.highlight,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              height: 14.sp / 11.sp,
            ),
            children: [
              TextSpan(
                text: '$percentDiscount% ${PiixCopiesDeprecated.ofDiscount} ',
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.white,
                ),
              ),
              TextSpan(
                text: PiixCopiesDeprecated.inAllBenefits,
                style: context.textTheme?.bodyMedium?.copyWith(
                  color: PiixColors.highlight,
                ),
              ),
            ],
          ),
        ),
      ),
      clipper: _CustomClipPath(),
    );
  }
}

///This class paint a ribbon with clip path
///
class _CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.95, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
