import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A predefined [DialogTheme] with a specified [backgroundColor],
///[shape] and [shadowColor].
final class AppDialogTheme extends DialogTheme {
  AppDialogTheme()
      : super(
          backgroundColor: PiixColors.space,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
            side: BorderSide(
              color: PiixColors.contrast10,
            ),
          ),
          shadowColor: Colors.transparent,
        );
}
