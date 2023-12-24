import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a invoice tag, receives a color, label, and icon
///
class InvoiceTagDeprecated extends StatelessWidget {
  const InvoiceTagDeprecated({
    super.key,
    required this.tagLabel,
    required this.tagColor,
    required this.width,
    this.height,
    this.tagIcon,
  });
  final Color tagColor;
  final String tagLabel;
  final IconData? tagIcon;
  final double width;
  final double? height;

  double get horizontalPadding => tagIcon != null ? 2 : 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 24.h,
      padding:
          EdgeInsets.symmetric(vertical: 2.h, horizontal: horizontalPadding.w),
      decoration: BoxDecoration(
          color: tagColor,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            tagLabel,
            style: context.primaryTextTheme?.titleSmall?.copyWith(
              color: PiixColors.space,
            ),
          ),
          if (tagIcon != null)
            Icon(
              tagIcon,
              color: PiixColors.white,
              size: 14.h,
            ),
        ],
      ),
    );
  }
}
