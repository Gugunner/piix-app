import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/text_theme/accent_text_theme.dart';

///A default [AppBarTheme] with
///pre defined properties.
///
///Use copyWith to overwrite any property.
class AppDefaultBarTheme extends AppBarTheme {
   AppDefaultBarTheme()
      : super(
          centerTitle: true,
          toolbarHeight: 54.h,
          backgroundColor: PiixColors.primary,
          foregroundColor: PiixColors.space,
          titleTextStyle: AccentTextTheme()
              .displayMedium
              ?.copyWith(color: PiixColors.space),
          toolbarTextStyle: AccentTextTheme()
              .displayMedium
              ?.copyWith(color: PiixColors.space),
          actionsIconTheme: IconThemeData(
            size: 12.w,
            color: PiixColors.space,
          )
        );
}
