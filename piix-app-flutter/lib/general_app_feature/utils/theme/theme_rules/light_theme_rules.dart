import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/text_accent_styles.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/text_base_styles.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/text_primary_styles.dart';
import 'package:piix_mobile/general_app_feature/utils/theme/theme_rules/app_theme_rules_interface.dart';

@Deprecated('Use instead AppThemeData')
class AppLightThemeRules implements AppThemeRulesInterface {
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
        filledButtonTheme: filledButtonTheme,
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
        drawerTheme: drawerTheme,
      );

  @override
  AppBarTheme get appBarTheme {
    const textAccentStyles = TextAccentStyles.instance;
    return AppBarTheme(
      centerTitle: true,
      titleTextStyle: textAccentStyles.displayMedium?.copyWith(
        color: PiixColors.space,
      ),
      toolbarTextStyle: textAccentStyles.displayMedium?.copyWith(
        color: PiixColors.space,
      ),
      actionsIconTheme: IconThemeData(
        size: 28.w,
        color: PiixColors.space,
      ),
    );
  }

  FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            primaryTextTheme.titleMedium?.copyWith(color: PiixColors.space),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.inactive;
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return PiixColors.primary;
              }
              return PiixColors.active;
            },
          ),
          foregroundColor: const MaterialStatePropertyAll(PiixColors.space),
          overlayColor: const MaterialStatePropertyAll(PiixColors.primary),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(8.w, 32.h),
          ),
          iconColor: const MaterialStatePropertyAll(PiixColors.space),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return const BorderSide(
                  color: PiixColors.inactive,
                );
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return const BorderSide(color: PiixColors.primary);
              }
              return const BorderSide(color: PiixColors.active);
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
          ),
        ),
      );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            primaryTextTheme.titleMedium?.copyWith(color: PiixColors.space),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.inactive;
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return PiixColors.primary;
              }
              return PiixColors.active;
            },
          ),
          foregroundColor: const MaterialStatePropertyAll(PiixColors.space),
          overlayColor: const MaterialStatePropertyAll(PiixColors.primary),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(8.w, 32.h),
          ),
          iconColor: const MaterialStatePropertyAll(PiixColors.space),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return const BorderSide(
                  color: PiixColors.inactive,
                );
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return const BorderSide(color: PiixColors.primary);
              }
              return const BorderSide(color: PiixColors.active);
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
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
                return PiixColors.inactive;
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.selected)) {
                return PiixColors.primary;
              }
              return PiixColors.active;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(MaterialState.disabled)) {
              return labelLarge.copyWith(
                color: PiixColors.inactive,
              );
            }
            return labelLarge.copyWith(
              color: PiixColors.active,
            );
          }),
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (states) {
              final titleMedium = primaryTextTheme.titleMedium;
              if (states.contains(MaterialState.disabled)) {
                return titleMedium?.copyWith(
                  color: PiixColors.inactive,
                );
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return titleMedium?.copyWith(
                  color: PiixColors.primary,
                );
              }
              return titleMedium?.copyWith(
                color: PiixColors.active,
              );
            },
          ),
          backgroundColor: MaterialStateProperty.all(PiixColors.space),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PiixColors.inactive;
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return PiixColors.primary;
              }
              return PiixColors.active;
            },
          ),
          overlayColor: const MaterialStatePropertyAll(PiixColors.primary),
          elevation: MaterialStateProperty.all(3),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 8.h,
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(8.w, 32.h),
          ),
          iconColor: const MaterialStatePropertyAll(PiixColors.space),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return const BorderSide(
                  color: PiixColors.inactive,
                );
              }
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.selected)) {
                return const BorderSide(color: PiixColors.primary);
              }
              return const BorderSide(color: PiixColors.active);
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
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
  TextStyle get labelLarge => TextStyle(
        fontSize: 12.sp,
        height: 18.sp / 12.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get bodyLarge => TextStyle(
        fontSize: 11.sp,
        height: 16.sp / 11.sp,
        letterSpacing: 0.4,
        fontWeight: FontWeight.normal,
      );

  @override
  ColorScheme get colorScheme => ColorScheme.fromSwatch(
        primarySwatch: primaryMainSwatch,
      ).copyWith(
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
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
    );
  }

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme {
    final textBaseStyles = TextBaseStyles.instance;
    return BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedItemColor: PiixColors.twilightBlue,
      unselectedItemColor: PiixColors.secondary,
      selectedLabelStyle: textBaseStyles.bodyMedium.copyWith(
        color: PiixColors.primary,
      ),
      unselectedLabelStyle: textBaseStyles.bodyMedium.copyWith(
        color: PiixColors.secondary,
      ),
      selectedIconTheme: IconThemeData(
        size: 24.h,
      ),
    );
  }

  @override
  DrawerThemeData get drawerTheme => const DrawerThemeData(
        backgroundColor: PiixColors.primary,
        elevation: 4,
      );
}
