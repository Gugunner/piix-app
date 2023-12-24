import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/camera_feature/camera_ui_barrel_file.dart';

class CameraZoomSlider extends StatelessWidget {
  const CameraZoomSlider({
    super.key,
    this.currentZoomLevel = 1.0,
    this.minZoomLevel = 1.0,
    this.maxZoomLevel = 1.0,
    this.onChanged,
  });

  final double currentZoomLevel;

  final double minZoomLevel;

  final double maxZoomLevel;

  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: ZoomSliderThemeData(
        maxZoomLevel: maxZoomLevel.toInt(),
        minZoomLevel: minZoomLevel.toInt(),
        context: context,
        thumbRadius: 24.w,
        trackHeight: 20.h,
        tickMarkRadius: 6.w,
      ),
      child: Slider(
        value: currentZoomLevel,
        min: minZoomLevel,
        max: maxZoomLevel > 3 ? 2.0 : maxZoomLevel,
        divisions: maxZoomLevel.toInt() - 1,
        onChanged: onChanged,
      ),
    );
  }
}
