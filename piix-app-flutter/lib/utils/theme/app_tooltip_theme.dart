import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A default [AppToolTipTheme] with
///pre defined properties.
///
///Use copyWith to overwrite any property.
final class AppToolTipTheme extends TooltipThemeData {
  AppToolTipTheme()
      : super(
          textStyle: BaseTextTheme().labelMedium.copyWith(
                color: PiixColors.space,
              ),
          decoration: BoxDecoration(
            color: PiixColors.tooltipBackground,
            borderRadius: BorderRadius.circular(
              4,
            ),
          ),
        );
}
