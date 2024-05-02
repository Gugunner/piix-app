import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';


///Centralizes the decorations used for different [Widget].
class AppDecorations {
  static InputDecoration singleCodeBoxDecoration({
    bool filled = false,
    bool hasError = false,
    bool hover = false,
  }) =>
      InputDecoration(
        fillColor: hasError
            ? PiixColors.error
            : filled
                ? PiixColors.primary
                : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: hasError
                ? PiixColors.error
                : filled
                    ? PiixColors.primary
                    : hover
                        ? PiixColors.active
                        : PiixColors.infoDefault,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4.w),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: PiixColors.inactive, width: 1),
          borderRadius: BorderRadius.circular(4.w),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: PiixColors.error, width: 1),
          borderRadius: BorderRadius.circular(4.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: hasError ? PiixColors.error : PiixColors.active,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: PiixColors.error, width: 1),
          borderRadius: BorderRadius.circular(4.w),
        ),
      );
}
