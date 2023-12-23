import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

final class SmallRoundControlButton extends StatelessWidget {
  const SmallRoundControlButton({
    super.key,
    required this.onTap,
    this.child,
  });

  final VoidCallback onTap;

  final Widget? child;

  double get _diameter => 32.w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _diameter,
      height: _diameter,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Material(
        color: PiixColors.infoDefault,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_diameter),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(_diameter),
          onTap: onTap,
          splashColor: PiixColors.space.withOpacity(0.65),
          child: child,
        ),
      ),
    );
  }
}
