import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This is a content of basic info bottom alert when MembershipAlert is basic
///form
///
class BasicInfoBottomAlertContent extends StatelessWidget {
  const BasicInfoBottomAlertContent({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final largeStyle = context.bodyLarge?.copyWith(
      color: PiixColors.white,
      height: 11.sp / 11.sp,
      letterSpacing: 0.01,
    );
    final semiBoldStyle = context.bodyLarge?.copyWith(
      color: PiixColors.white,
      fontWeight: FontWeight.w600,
      height: 11.sp / 11.sp,
      letterSpacing: 0.01,
    );
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${PiixCopiesDeprecated.membershipFillBasicInfo} ',
              style: largeStyle,
            ),
            TextSpan(
              text: PiixCopiesDeprecated.fromHere,
              style: semiBoldStyle,
            ),
          ],
        ),
        style: context.bodyLarge?.copyWith(
          color: PiixColors.white,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
