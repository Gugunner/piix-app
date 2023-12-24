import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')
class PiixCameraZoomSliderDeprecated extends StatelessWidget {
  const PiixCameraZoomSliderDeprecated({
    super.key,
    required this.maxZoomLevel,
    required this.minZoomLevel,
    required this.currentZoomLevel,
    required this.onChangedZoom,
  });

  final double maxZoomLevel;
  final double minZoomLevel;
  final double currentZoomLevel;
  final Function(double)? onChangedZoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: Slider(
              value: currentZoomLevel,
              min: minZoomLevel,
              max: maxZoomLevel,
              activeColor: PiixColors.white,
              inactiveColor: PiixColors.white.withOpacity(0.6),
              onChanged: onChangedZoom,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Text(
                '${currentZoomLevel.toStringAsFixed(1)} x',
                style: context.labelSmall?.copyWith(
                  color: PiixColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
