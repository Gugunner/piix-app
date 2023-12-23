import 'package:flutter/material.dart';

abstract class AppThemeRulesInterface {
  ThemeData get theme => ThemeData();

  set theme(ThemeData theme) {}

  void set({
    required Color scaffoldBackgroundColor,
    required String fontFamily,
    required Color primaryColor,
    required Color primaryColorLight,
    required Color dividerColor,
    required Color secondaryHeaderColor,
  }) {
    theme = ThemeData();
  }

  AppBarTheme get appBarTheme => const AppBarTheme();

  ElevatedButtonThemeData get elevatedButtonTheme =>
      const ElevatedButtonThemeData();

  TextButtonThemeData get textButtonTheme => const TextButtonThemeData();

  OutlinedButtonThemeData get outlinedButtonTheme =>
      const OutlinedButtonThemeData();

  InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme();

  TextTheme get textTheme => const TextTheme();

  TextTheme get primaryTextTheme => const TextTheme();

  ///Subtitle3 reference
  TextStyle get labelLarge => const TextStyle();

  ///Subtitle4 reference
  TextStyle get bodyLarge => const TextStyle();

  //TODO: Add link button text style

  //TODO: Enabled/Active text style

  ColorScheme get colorScheme => ColorScheme.fromSwatch();

  TooltipThemeData get tooltipTheme => const TooltipThemeData();

  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      const BottomNavigationBarThemeData();

  DrawerThemeData get drawerTheme => const DrawerThemeData();
}
