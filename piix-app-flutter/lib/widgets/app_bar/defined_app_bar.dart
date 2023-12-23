import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A default [AppBar] that uses inherited widget pattern to define itself.
base class DefinedAppBar extends AppBar {
  DefinedAppBar({
    super.key,
    super.title,
    super.leading,
    super.actions,
    super.foregroundColor = PiixColors.space,
    super.backgroundColor = PiixColors.primary,
    super.elevation,
    super.systemOverlayStyle = SystemUiOverlayStyle.light,
  })  : assert(title != null || leading != null || actions != null),
        super(
          titleTextStyle: AccentTextTheme().textTheme.displayMedium?.copyWith(
                color: PiixColors.space,
              ),
          centerTitle: true,
          toolbarHeight: 54.h,
        );

  
}
