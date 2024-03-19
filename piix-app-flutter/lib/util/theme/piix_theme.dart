import 'package:flutter/material.dart';
import 'piix_colors.dart';

class PiixThemeData {
  static ThemeData getThemeData() {
    return ThemeData(
      primaryColor: PiixColors.primary,
      hintColor: PiixColors.active,
      scaffoldBackgroundColor: PiixColors.space,
      appBarTheme: AppBarTheme(
        color: PiixColors.space,
        elevation: 0,
        iconTheme: IconThemeData(
          color: PiixColors.contrast,
        ),
      ),
    );
  }
}
