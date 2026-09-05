import 'package:flutter/material.dart';

/// Centralized design tokens for the authentication module.
/// All colors, text styles, and decorations are defined here so that
/// every auth widget draws from a single source of truth.
class AuthTheme {
  AuthTheme._(); // prevent instantiation

  // ──────────────────────────── Colors ────────────────────────────

  static const Color primaryBlue = Color(0xFF1565D8);
  static const Color primaryBlueLight = Color(0xFF1E88E5);
  static const Color primaryBlueDark = Color(0xFF0D47A1);

  static const Color pageBackground = Color(0xFFF0F2F5);
  static const Color cardBackground = Color(0xFFFFFFFF);

  static const Color inputBackground = Color(0xFFF7F8F9);
  static const Color inputBorder = Color(0xFFE8ECF4);
  static const Color inputFocusBorder = primaryBlue;

  static const Color textPrimary = Color(0xFF1E232C);
  static const Color textSecondary = Color(0xFF8391A1);
  static const Color textLink = primaryBlue;

  static const Color dividerColor = Color(0xFFE8ECF4);

  static const Color googleRed = Color(0xFFDB4437);
  static const Color facebookBlue = Color(0xFF1877F2);

  static const Color illustrationYellow = Color(0xFFFFCA28);
  static const Color illustrationBlue = Color(0xFF42A5F5);
  static const Color illustrationGreen = Color(0xFF66BB6A);
  static const Color illustrationPink = Color(0xFFEF5350);

  // ──────────────────────────── Radii ─────────────────────────────

  static const double cardRadius = 24.0;
  static const double inputRadius = 12.0;
  static const double buttonRadius = 12.0;

  // ──────────────────────────── Spacing ───────────────────────────

  static const double cardPaddingH = 28.0;
  static const double cardPaddingV = 32.0;
  static const double fieldSpacing = 16.0;

  // ──────────────────────────── Text Styles ───────────────────────

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.3,
    height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textLink,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  // ──────────────────────────── Input Decoration ──────────────────

  static InputDecoration inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: inputHint,
      prefixIcon: Icon(prefixIcon, color: textSecondary, size: 22),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: inputBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputRadius),
        borderSide: const BorderSide(color: inputBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputRadius),
        borderSide: const BorderSide(color: inputBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputRadius),
        borderSide: const BorderSide(color: inputFocusBorder, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputRadius),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputRadius),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}
