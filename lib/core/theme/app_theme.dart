import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand & Violet Palette
  static const Color violet900 = Color(0xFF4C1D95);
  static const Color violet700 = Color(0xFF6D28D9);
  static const Color violet600 = Color(0xFF7C3AED);
  static const Color violet500 = Color(0xFF8B5CF6);
  static const Color violet400 = Color(0xFFA78BFA);
  static const Color violet100 = Color(0xFFEDE9FE);
  static const Color violet50 = Color(0xFFF5F3FF);

  // Background & Surfaces
  static const Color lavenderBg = Color(0xFFF8F7FC);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color line = Color(0xFFECEAF4);

  // Functional Status Colors
  static const Color pink500 = Color(0xFFF43F5E);
  static const Color pink100 = Color(0xFFFFE4E9);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color green600 = Color(0xFF10B981);
  static const Color green100 = Color(0xFFD1FAE5);

  // Text & Inks
  static const Color ink900 = Color(0xFF1E1B2E);
  static const Color ink600 = Color(0xFF6B7280);
  static const Color ink400 = Color(0xFF9CA3AF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [violet600, violet500, violet400],
    stops: [0.0, 0.55, 1.0],
  );

  static const LinearGradient brandIconGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [violet600, violet400],
  );

  // Typography Helpers
  static TextStyle poppins({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
    Color color = ink900,
    double? letterSpacing,
    double? height,
  }) {
    try {
      return GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    } catch (_) {
      return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    }
  }

  static TextStyle inter({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w400,
    Color color = ink600,
    double? letterSpacing,
    double? height,
  }) {
    try {
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    } catch (_) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    }
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: lavenderBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: violet600,
        primary: violet600,
        surface: surfaceWhite,
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: lavenderBg,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
