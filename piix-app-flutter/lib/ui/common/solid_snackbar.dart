import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

SnackBar solidSnackBar({required String snackText, required bool isError}) {
  return SnackBar(
    content: Text(snackText,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(12), fontWeight: FontWeight.w400),
        textAlign: TextAlign.center),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    duration: const Duration(milliseconds: 3000),
    backgroundColor: isError ? PiixColors.errorMain : PiixColors.successMain,
  );
}
