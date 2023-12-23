import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Use instead AppDrawerTheme')
///A default [DrawerThemeData] with
///pre defined properties.
///
///Use copyWith to overwrite any property.
final class AppThemeDrawer extends DrawerThemeData {
  const AppThemeDrawer()
      : super(
          backgroundColor: PiixColors.primary,
          elevation: 4,
        );
}
