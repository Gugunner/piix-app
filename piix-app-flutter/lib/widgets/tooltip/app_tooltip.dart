import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:super_tooltip/super_tooltip.dart';


///The app configured [SuperTooltip] that uses InheritedWidget pattern.
final class AppTooltip extends SuperTooltip {
  AppTooltip({
    super.key,
    required super.content,
    super.popupDirection,
    super.child,
    super.controller,
  }) : super(
          showCloseButton: ShowCloseButton.inside,
          closeButtonSize: 20.w,
          overlayDimensions: const EdgeInsets.all(0),
          bubbleDimensions: const EdgeInsets.all(0),
          closeButtonColor: PiixColors.space,
          showBarrier: false,
          backgroundColor: PiixColors.infoDefault,
          borderRadius: 4.w,
          shadowColor: Colors.transparent,
          borderColor: Colors.transparent,
        );
}
