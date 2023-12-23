import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/camera_feature/camera_ui_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

final class ZoomSliderThemeData extends SliderThemeData {
  ZoomSliderThemeData({
    required this.maxZoomLevel,
    required this.minZoomLevel,
    required this.context,
    this.thumbRadius = 20,
    this.trackHeight = 20,
    this.tickMarkRadius = 6,
  }) : super(
          activeTrackColor: PiixColors.space.withOpacity(0.65),
          inactiveTrackColor: PiixColors.space.withOpacity(0.65),
          trackHeight: trackHeight,
          thumbShape: ZoomSliderThumbShape(
            buildContext: context,
            radius: thumbRadius,
            min: minZoomLevel,
            max: maxZoomLevel,
          ),
          thumbColor: ColorUtils.lighten(PiixColors.contrast, 0.1),
          overlayColor:
              ColorUtils.lighten(PiixColors.contrast, 0.1).withAlpha(32),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 32.w),
          tickMarkShape:
              RoundSliderTickMarkShape(tickMarkRadius: tickMarkRadius),
          activeTickMarkColor: PiixColors.infoDefault,
          inactiveTickMarkColor: PiixColors.infoDefault,
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: ColorUtils.lighten(PiixColors.contrast, 0.1),
          valueIndicatorTextStyle:
              context.labelLarge?.copyWith(color: PiixColors.space),
        );

  final int maxZoomLevel;

  final int minZoomLevel;

  final double thumbRadius;

  @override
  final double trackHeight;

  final double tickMarkRadius;

  final BuildContext context;
}
