import 'package:flutter/material.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/theme/app_text_styles.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';

/// A class that holds the app theme data.
class AppTheme {
  static ThemeData get themeData => ThemeData(
      primaryColor: PiixColors.primary,
      disabledColor: PiixColors.inactive,
      primaryColorLight: PiixColors.active,
      focusColor: PiixColors.primary,
      hoverColor: PiixColors.primary,
      splashColor: PiixColors.primary,
      hintColor: PiixColors.infoDefault,
      scaffoldBackgroundColor: PiixColors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextBaseStyle.bodyMedium,
        labelStyle: TextBaseStyle.titleMedium.copyWith(
          color: PiixColors.infoDefault,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.active,
          ),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.inactive,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.primary,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: PiixColors.error,
          ),
        ),
        focusColor: PiixColors.primary,
        hoverColor: PiixColors.primary,
        fillColor: PiixColors.active,
        errorStyle: TextBaseStyle.labelMedium.copyWith(
          color: PiixColors.error,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextBaseStyle.displayLarge,
        displayMedium: TextBaseStyle.displayMedium,
        displaySmall: TextBaseStyle.displaySmall,
        headlineLarge: TextBaseStyle.headlineLarge,
        headlineMedium: TextBaseStyle.headlineMedium,
        headlineSmall: TextBaseStyle.headlineSmall,
        titleLarge: TextBaseStyle.titleLarge,
        titleMedium: TextBaseStyle.titleMedium,
        titleSmall: TextBaseStyle.titleSmall,
        labelLarge: TextBaseStyle.labelLarge,
        labelMedium: TextBaseStyle.labelMedium,
        labelSmall: TextBaseStyle.labelSmall,
        bodyLarge: TextBaseStyle.bodyLarge,
        bodyMedium: TextBaseStyle.bodyMedium,
        bodySmall: TextBaseStyle.bodySmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll<TextStyle>(
            TextBaseStyle.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.selected) ||
                states.contains(MaterialState.dragged)) {
              return PiixColors.primary;
            }
            return PiixColors.active;
          }),
          foregroundColor:
              const MaterialStatePropertyAll<Color>(PiixColors.space),
          minimumSize:
              const MaterialStatePropertyAll<Size>(Size(Sizes.p16, Sizes.p56)),
          shape:
              MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.p8),
          )),
          iconColor: const MaterialStatePropertyAll<Color>(PiixColors.space),
          iconSize: const MaterialStatePropertyAll<double>(Sizes.p16),
        ),
      ));
}
