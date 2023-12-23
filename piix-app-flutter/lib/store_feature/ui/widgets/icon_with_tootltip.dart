import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This component render an icon qith toltip,
///receives the message, and optional properties as icon, icon colors,
///and icon size
///
class IconWithTooltip extends StatelessWidget {
  const IconWithTooltip({
    super.key,
    required this.message,
    this.icon = Icons.info_outline_rounded,
    this.iconColor = PiixColors.activeButton,
    this.iconSize = 12,
  });
  final String message;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      triggerMode: TooltipTriggerMode.tap,
      message: message,
      decoration: const BoxDecoration(
        color: PiixColors.infoDefault,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      textStyle: context.textTheme?.labelMedium?.copyWith(
        color: PiixColors.space,
      ),
      verticalOffset: 10,
      showDuration: const Duration(seconds: 5),
      margin: EdgeInsets.only(left: 9.w),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize.h,
      ),
    );
  }
}
