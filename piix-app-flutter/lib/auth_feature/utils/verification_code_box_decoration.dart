import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///Its a specific [InputDecoration] subclass to be used with
///the [VerificationCodeBox].
final class VerificationCodeBoxDecoration extends InputDecoration {
  VerificationCodeBoxDecoration({
    super.enabled,
    super.filled = false,
    this.hasError = false,
  }) : super(
          fillColor: hasError ? PiixColors.error : PiixColors.primary,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasError
                  ? PiixColors.error
                  : filled!
                      ? PiixColors.primary
                      : PiixColors.infoDefault,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.w),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: PiixColors.secondaryLight, width: 1),
            borderRadius: BorderRadius.circular(4.w),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: PiixColors.error, width: 1),
            borderRadius: BorderRadius.circular(4.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: hasError ? PiixColors.error : PiixColors.active,
                width: 1),
            borderRadius: BorderRadius.circular(4.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: PiixColors.error, width: 1),
            borderRadius: BorderRadius.circular(4.w),
          ),
          // constraints: BoxConstraints(maxWidth: 40.w, maxHeight: 48.h),
        );

  final bool hasError;
}
