import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a template for a row of separate expandable texts
///
class RowTextInvoiceCardDeprecated extends StatelessWidget {
  const RowTextInvoiceCardDeprecated({
    super.key,
    required this.leftText,
    required this.rightText,
    this.hasTooltip = false,
    this.leftStyle,
    this.rightStyle,
  });
  final String leftText;
  final TextStyle? leftStyle;
  final String rightText;
  final TextStyle? rightStyle;
  final bool hasTooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 12,
            child: Text(
              leftText,
              style: leftStyle ?? context.textTheme?.bodyMedium,
            ),
          ),
          Flexible(
            flex: 14,
            child: Builder(
              builder: (context) {
                final child = Text(
                  rightText,
                  style: rightStyle ?? context.textTheme?.bodyMedium,
                  overflow: hasTooltip ? TextOverflow.ellipsis : null,
                );
                if (hasTooltip)
                  return TooltipRowTextInvoiceCardDeprecated(
                    message: rightText,
                    child: child,
                  );
                return child;
              },
            ),
          ),
        ],
      ),
    );
  }
}


@Deprecated('Will be removed in 4.0')
class TooltipRowTextInvoiceCardDeprecated extends StatelessWidget {
  const TooltipRowTextInvoiceCardDeprecated({
    super.key,
    required this.message,
    this.child,
  });

  final String message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      verticalOffset: 8.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: PiixColors.mainText, borderRadius: BorderRadius.circular(4)),
      triggerMode: TooltipTriggerMode.tap,
      textStyle: context.textTheme?.labelMedium?.copyWith(
        color: PiixColors.space,
      ),
      child: child,
    );
  }
}
