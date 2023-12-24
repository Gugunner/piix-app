import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/text_base_styles.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/text_primary_styles.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/theme_rules/app_theme_rules_interface.dart';

//TODO: Create a dark theme
class AppDarkThemeRules implements AppThemeRulesInterface {
  ThemeData? _theme;

  @override
  ThemeData get theme => _theme ?? ThemeData();

  @override
  set theme(ThemeData theme) {
    _theme = theme;
  }

  @override
  void set({
    required Color scaffoldBackgroundColor,
    required String fontFamily,
    required Color primaryColor,
    required Color primaryColorLight,
    required Color dividerColor,
    required Color secondaryHeaderColor,
  }) =>
      theme = ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        fontFamily: fontFamily,
        appBarTheme: appBarTheme,
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLight,
        elevatedButtonTheme: elevatedButtonTheme,
        textButtonTheme: textButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        dividerColor: dividerColor,
        secondaryHeaderColor: secondaryHeaderColor,
        inputDecorationTheme: inputDecorationTheme,
        textTheme: textTheme,
        primaryTextTheme: primaryTextTheme,
        colorScheme: colorScheme,
        tooltipTheme: tooltipTheme,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
      );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: PiixColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.successLight;
              }
              return PiixColors.successMain;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.white.withOpacity(0.6);
              }
              return PiixColors.white;
            },
          ),
        ),
      );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.successLight;
              }
              return PiixColors.successMain;
            },
          ),
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(3),
          backgroundColor: MaterialStateProperty.all(PiixColors.white),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(
                  color: PiixColors.lightBlueGreyThree.withOpacity(0.3),
                );
              }
              return const BorderSide(color: PiixColors.activeButton);
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.lightBlueGreyThree;
              }
              return PiixColors.activeButton;
            },
          ),
        ),
      );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        helperStyle: TextStyle(
          fontSize: 9.sp,
        ),
        labelStyle: TextStyle(
          fontSize: 11.sp,
        ),
        errorMaxLines: 5,
        focusColor: PiixColors.darkSkyBlue,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.brick,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.secondaryText,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.darkSkyBlue,
          ),
        ),
      );

  @override
  TextTheme get textTheme {
    final textBaseStyles = TextBaseStyles.instance;
    return TextTheme(
      displayLarge: textBaseStyles.displayLarge,
      displayMedium: textBaseStyles.displayMedium,
      displaySmall: textBaseStyles.displaySmall,
      headlineLarge: textBaseStyles.headlineLarge,
      headlineMedium: textBaseStyles.headlineMedium,
      headlineSmall: textBaseStyles.headlineSmall,
      titleLarge: textBaseStyles.titleLarge,
      titleMedium: textBaseStyles.titleMedium,
      titleSmall: textBaseStyles.titleSmall,
      labelLarge: textBaseStyles.labelLarge,
      labelMedium: textBaseStyles.labelMedium,
      labelSmall: textBaseStyles.labelSmall,
      bodyLarge: textBaseStyles.bodyLarge,
      bodyMedium: textBaseStyles.bodyMedium,
      bodySmall: textBaseStyles.bodySmall,
    );
  }

  @override
  TextTheme get primaryTextTheme {
    final textPrimaryStyles = TextPrimaryStyles.instance;
    return TextTheme(
      displayLarge: textPrimaryStyles.displayLarge,
      displayMedium: textPrimaryStyles.displayMedium,
      displaySmall: textPrimaryStyles.displaySmall,
      headlineLarge: textPrimaryStyles.headlineLarge,
      headlineMedium: textPrimaryStyles.headlineMedium,
      headlineSmall: textPrimaryStyles.headlineSmall,
      titleLarge: textPrimaryStyles.titleLarge,
      titleMedium: textPrimaryStyles.titleMedium,
      titleSmall: textPrimaryStyles.titleSmall,
      labelLarge: textPrimaryStyles.labelLarge,
      labelMedium: textPrimaryStyles.labelMedium,
      labelSmall: textPrimaryStyles.labelSmall,
      bodyLarge: textPrimaryStyles.bodyLarge,
      bodyMedium: textPrimaryStyles.bodyMedium,
      bodySmall: textPrimaryStyles.bodySmall,
    );
  }

  @override
  ColorScheme get colorScheme =>
      ColorScheme.fromSwatch(primarySwatch: primaryMainSwatch).copyWith(
        secondary: PiixColors.twilightBlue,
      );

  @override
  TooltipThemeData get tooltipTheme {
    final textBaseStyles = TextBaseStyles.instance;
    return TooltipThemeData(
      textStyle: textBaseStyles.labelMedium.copyWith(
        color: PiixColors.space,
      ),
      decoration: BoxDecoration(
        color: PiixColors.tooltipBackground,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme {
    final textBaseStyles = TextBaseStyles.instance;
    return BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedItemColor: PiixColors.twilightBlue,
      unselectedItemColor: PiixColors.unselectedTabGrey,
      selectedLabelStyle: textBaseStyles.bodyMedium.copyWith(
        color: PiixColors.primary,
      ),
      selectedIconTheme: IconThemeData(size: 24.h),
    );
  }

  @override
  TextStyle get labelLarge => TextStyle(
        fontSize: 12.sp,
        height: 18.sp / 12.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.bold,
        color: PiixColors.clearBlue,
      );

  @override
  TextStyle get bodyLarge => TextStyle(
        fontSize: 11.sp,
        height: 16.sp / 11.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
      );
      
        @override
        // TODO: implement drawerTheme
        DrawerThemeData get drawerTheme => throw UnimplementedError();
}
