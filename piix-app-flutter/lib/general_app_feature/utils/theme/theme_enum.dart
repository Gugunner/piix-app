import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/theme_rules/light_theme_rules.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

enum AppThemeMode { light, dark }

@Deprecated('Use AppThemeData wrapped inside a Riverpod Provider')
extension BuildTheme on AppThemeMode {
  ThemeData get theme {
    switch (this) {
      case AppThemeMode.light:
        final rules = AppLightThemeRules();
        rules.set(
          scaffoldBackgroundColor: PiixColors.space,
          fontFamily: 'Raleway',
          primaryColor: PiixColors.primary,
          primaryColorLight: PiixColors.primaryLight,
          dividerColor: PiixColors.brownGrey,
          secondaryHeaderColor: PiixColors.secondaryHeaderColor,
        );
        return rules.theme;
      case AppThemeMode.dark:
        final rules = AppLightThemeRules();
        rules.set(
          scaffoldBackgroundColor: PiixColors.blueGrey2,
          fontFamily: 'Raleway',
          primaryColor: PiixColors.errorLight,
          primaryColorLight: PiixColors.errorLight,
          dividerColor: PiixColors.successMain,
          secondaryHeaderColor: PiixColors.secondaryHeaderColor,
        );
        return rules.theme;
    }
  }
}
