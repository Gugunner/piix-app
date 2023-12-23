import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

class AppCircularLoader extends StatefulWidget {
  const AppCircularLoader({super.key});

  @override
  State<AppCircularLoader> createState() => _AppCircularLoaderState();
}

class _AppCircularLoaderState extends State<AppCircularLoader>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> color;
  late AnimationController controller;

  void startAnimation() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    color = ColorTween(begin: PiixColors.active, end: PiixColors.active)
        .animate(controller);
  }

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.w,
      width: 50.w,
      child: CircularProgressIndicator.adaptive(
        // backgroundColor: PiixColors.active,
        valueColor: color,
      ),
    );
  }
}
