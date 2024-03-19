import 'package:flutter/material.dart';

abstract final class PiixColors {
  // Primary Colors
  static const Color primary = Color(0xFF0D47A1);
  static const Color active = Color(0xFF2962FF);
  static const Color infoDefault = Color(0xFF52595B);
  static const Color space = Color(0xFFFFFFFF);
  static const Color contrast = Color(0xFF0D0D0D);
  // Secondary Colors
  static const Color secondary = Color(0xFF8D989C);
  static const Color secondaryLight = Color(0xFFD9D9D9);
  static const Color inactive = Color(0xFFAAC0EB);
  // Succes
  static const Color success = Color(0xFF4CAF50);
  // Warning
  static const Color highlight = Color(0xFFFF640D);
  static const Color process = Color(0xFFF0843D);
  static const Color warning = Color(0xFFFF9800);
  static const Color shine = Color(0xFFFFC107);
  // Error
  static const Color error = Color(0xFFCD2B2B);
  static const Color alert = Color(0xFFDB5858);
  // Background
  static const Color stormy = Color(0xFFEDEFF3);
  static const Color cloud = Color(0xFFF3F3F3);
  static const Color sky = Color(0xFFFAFAFA);
  // Colores Beneficios
  static const Color assist = Color(0xFF7CB342);
  static const Color insurance = Color(0xFF2196F3);
  static const Color services = Color(0xFFD81B60);
  static const Color rewards = Color(0xFF512EA8);
  // Gradientes
  static const LinearGradient linearGradient = LinearGradient(
    colors: [Color(0xFFECF1FB), Color(0xFFF1F5FB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  // Levels
  static const Color piixBasic = Color(0xFF90A4AE);
  static const Color piixPremium = Color(0xFF154360);
  static const Color nC = Color(0xFFE7C36D);
}
