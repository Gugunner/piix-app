import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_logo/app_bar_logo.dart';
import 'package:piix_mobile/widgets/app_bar/defined_app_bar.dart';

///A predefined [AppBar] that contains the app logo in its [actions]
///property.
///
///It may contain a back arrow or not depending on where in the stack is
///the [Scaffold] that contains it.
final class LogoAppBar extends DefinedAppBar {
  LogoAppBar({
    super.key,
    super.leading,
    Color? logoColor,
    Size? size,
    super.backgroundColor,
    super.foregroundColor,
    super.elevation,
    super.systemOverlayStyle,
  }) : super(
          actions: [
            AppBarLogo(
              color: logoColor,
              size: size,
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        );
}
