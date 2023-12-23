import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Use instead CloseXButton')
///Use to add a [X] button to close any overlay, such as banners, dialogs,
///snackbars, etc..
///
///Pass the [onClose] method to handle the callback method.
///To change the color just pass the new [iconColor].
class CloseOverlayGesture extends StatelessWidget {
  const CloseOverlayGesture({
    super.key,
    required this.onClose,
    this.iconColor,
  });

  ///The callback when closing any overlay
  final VoidCallback? onClose;

  ///The color for the [X] icon
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.h,
      right: 12.w,
      child: GestureDetector(
        onTap: onClose,
        child: Icon(
          Icons.close,
          color: iconColor ?? PiixColors.space,
          size: 16.w,
        ),
      ),
    );
  }
}
