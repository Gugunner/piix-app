import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead AppTag')

/// Creates a tag with a text and a background color.
//TODO: Check Tag vs UI design
class PiixTagStoreDeprecated extends StatelessWidget {
  const PiixTagStoreDeprecated({
    Key? key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.labelStyle,
    this.iconRight = true,
    this.action,
    this.isClaims = false,
    this.horizontalPadding = 0,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? textColor;
  final String? text;
  final Icon? icon;
  final bool iconRight;
  final VoidCallback? action;
  final bool isClaims;
  final double horizontalPadding;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();
    final isTextNull = text == null;
    return GestureDetector(
      onTap: action,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenUtil.setWidth(4),
          ),
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (icon != null && !iconRight)
              //   icon!.padRight(!isTextNull ? 1.w : 0).padVertical(4.w),
              if (text != null)
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: labelStyle ??
                      context.primaryTextTheme?.titleSmall?.copyWith(
                        color: textColor ?? PiixColors.space,
                      ),
                ),
              if (icon != null && iconRight)
                icon!
                    .padRight(horizontalPadding.w)
                    .padLeft(
                      !isTextNull ? 1.w : horizontalPadding.w,
                    )
                    .padVertical(4.w),
            ],
          )),
    );
  }
}
