import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFFF4F9A);
  static const Color softPink = Color(0xFFFFE6F0);
  static const Color textDark = Color(0xFF2B2B2B);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
    );

    return base.copyWith(
      scaffoldBackgroundColor: softPink,
      colorScheme: base.colorScheme.copyWith(
        primary: primary,
        secondary: primary,
        surface: white,
        onSurface: textDark,
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: textDark,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: textDark,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
