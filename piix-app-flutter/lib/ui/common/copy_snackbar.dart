import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

SnackBar copySnackBar({
  required String snackText,
  required BuildContext context,
}) {
  return SnackBar(
    content: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
            decoration: BoxDecoration(
                color: PiixColors.infoDefault,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snackText,
                      style: context.textTheme?.bodyMedium?.copyWith(
                        color: PiixColors.space,
                      ),
                      textAlign: TextAlign.center)
                ]))),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    duration: const Duration(milliseconds: 1200),
    backgroundColor: Colors.transparent,
  );
}
