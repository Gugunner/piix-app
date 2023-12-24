import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/key_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:super_tooltip/super_tooltip.dart';

/// Creates a custom tooltip.
///
/// [key] is the key of the [Widget] that will be used to show the tooltip,
/// it is necessary to show popup on the right place.
@Deprecated('Use AppTooltip instead')
class PiixTooltipDeprecated extends SuperTooltip {
  PiixTooltipDeprecated({
    super.key,
    required Widget content,
    GlobalKey? offsetKey,
    bool showCloseButton = true,
    bool showArrow = false,
    Color backgroundColor = PiixColors.tooltipBackground,
  }) : super(
            content: Material(color: Colors.transparent, child: content),
            popupDirection: offsetKey != null
                ? offsetKey.offset.dy > ScreenUtil.defaultSize.height / 1.5
                    ? TooltipDirection.up
                    : TooltipDirection.down
                : TooltipDirection.down,
            hasShadow: false,
            showCloseButton:
                showCloseButton ? ShowCloseButton.inside : ShowCloseButton.none,
            closeButtonColor: Colors.white,
            borderWidth: 0,
            arrowLength: showArrow ? 6.w : 0,
            closeButtonSize: 16.w,
            arrowBaseWidth: showArrow ? 10.w : 0,
            borderRadius: 4,
            backgroundColor: backgroundColor,
            controller: SuperTooltipController());
}
