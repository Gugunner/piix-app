import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/utils/piix_memberships_util_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a additional benefit detail card
///depending on the name of the benefit is the color, and the icon to show
///
class AdditionalBenefitCardDeprecated extends StatelessWidget {
  const AdditionalBenefitCardDeprecated({
    super.key,
    required this.name,
    required this.textColor,
    this.iconColor,
    this.onTap,
  });
  final String name;
  final Color textColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getBenefitTypeColor(name),
        ),
        margin: EdgeInsets.only(bottom: 20.h, left: 16.h, right: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              getBenefitTypeIcon(name),
              size: 40.h,
              color: iconColor ?? textColor,
            ),
            Text(
              name,
              style: context.primaryTextTheme?.titleSmall?.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
