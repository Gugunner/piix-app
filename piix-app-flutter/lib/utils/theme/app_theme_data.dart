import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/button_theme/app_elevated_button_theme.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A base class that defines the properties of the
///[AppThemeData]
base class _AppThemeDataBase {
  late ThemeData _themeData;

  late ThemeData _initialThemeData;

  ThemeData get currentThemeData => _themeData;

  ///Changes the [ThemeData] of this
  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
  }

  ///Reverts any change to [ThemeData]
  void resetThemeData() {
    _themeData = _initialThemeData;
  }
}

///A singleton class that contains the theme used inside the app
///if needed this class can set a different theme, and can be called
///outside of any [BuildContext].
final class AppThemeData extends _AppThemeDataBase {
  static final AppThemeData _instance = AppThemeData._singleton();

  factory AppThemeData() => _instance;

  AppThemeData._singleton() {
    _initialThemeData = ThemeData(
      scaffoldBackgroundColor: PiixColors.space,
      fontFamily: 'Raleway',
      primaryColor: PiixColors.primary,
      primaryColorLight: PiixColors.primaryLight,
      hintColor: PiixColors.infoDefault,
      dividerColor: PiixColors.secondaryLight,
      hoverColor: PiixColors.active,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primaryMainSwatch,
      ).copyWith(
        secondary: PiixColors.twilightBlue,
        error: PiixColors.error,
        onSurface: PiixColors.active,
      ),
      textTheme: BaseTextTheme().textTheme,
      primaryTextTheme: PrimaryTextTheme().textTheme,
      secondaryHeaderColor: PiixColors.secondaryHeaderColor,
      appBarTheme: AppDefaultBarTheme(),
      filledButtonTheme: AppFilledButtonTheme(),
      elevatedButtonTheme: AppElevatedButtonTheme(),
      outlinedButtonTheme: AppOutlinedButtonTheme(),
      textButtonTheme: AppTextButtonTheme(),
      inputDecorationTheme: AppInputDecorationTheme(),
      tooltipTheme: AppToolTipTheme(),
      bottomNavigationBarTheme: AppBottomNavigationBarTheme(),
      drawerTheme: const AppDrawerTheme(),
      radioTheme: AppRadioButtonTheme(),
      checkboxTheme: AppCheckboxTheme(),
      switchTheme: AppSwitchButtonTheme(),
      dialogTheme: AppDialogTheme(),
    );
    setThemeData(_initialThemeData);
  }
}
