import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

class CameraScreenInstructions extends StatelessWidget {
  const CameraScreenInstructions({
    super.key,
    required this.instructions,
  });

  final String instructions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 206.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: PiixColors.contrast,
        borderRadius: BorderRadius.circular(
          5.w,
        ),
      ),
      child: Text(
        instructions,
        style: context.accentTextTheme?.titleSmall?.copyWith(
          color: PiixColors.space.withOpacity(0.7),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}