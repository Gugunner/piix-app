import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';

/// A class that displays the app logo as an [SvgPicture].
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/app_brand/piix_logo.svg'.hardcoded,
      color: Theme.of(context).primaryColor,
      width: 288.w,
      height: 80.h,
    );
  }
}