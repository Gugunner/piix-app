import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

/// Creates an alert info that shows a message and an action button.
class PiixAlertInfoDeprecated extends StatelessWidget {
  const PiixAlertInfoDeprecated(
      {Key? key,
      this.title = '',
      required this.subtitle,
      this.icon,
      this.actionText,
      this.actionStyle,
      this.onAction,
      this.onClose,
      this.backgroundColor})
      : super(key: key);

  final String title;
  final String subtitle;
  final String? actionText;
  final TextStyle? actionStyle;
  final VoidCallback? onAction;
  final VoidCallback? onClose;
  final IconData? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: backgroundColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ).copyWith(bottom: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: PiixColors.white, size: 20.h),
                  SizedBox(width: context.width * 0.023),
                ],
                Flexible(
                  child: SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title.isNotEmpty)
                          Text(
                            title,
                            style: context.primaryTextTheme?.headlineSmall
                                ?.copyWith(
                              color: PiixColors.space,
                            ),
                          ),
                        Text(
                          subtitle,
                          style: context.textTheme?.bodyMedium?.copyWith(
                            color: PiixColors.space,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (onClose != null)
            Positioned(
              right: context.width * 0.023,
              top: context.height * 0.005,
              child: GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.clear,
                  color: PiixColors.white,
                  size: 18.h,
                ),
              ),
            ),
          if (onAction != null)
            Positioned(
              bottom: 8.h,
              right: 16.w,
              child: GestureDetector(
                onTap: onAction,
                child: Text(
                  (actionText ?? PiixCopiesDeprecated.fillLabel).toUpperCase(),
                  style: actionStyle ??
                      context.accentTextTheme?.labelMedium?.copyWith(
                        color: PiixColors.space,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
