import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///An Inherited [Icon] subclass with default
///[size] and [color].
///
///Pass an [IconData] to change [Icon] shape.
class AppBarIcon extends Icon {
  AppBarIcon(super.icon, {super.key})
      : super(
          size: 20.w,
          color: PiixColors.space,
        );
}
