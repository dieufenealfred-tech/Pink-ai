import 'package:flutter/material.dart';

import 'screens/splash_page.dart';

void main() {
  runApp(const PinkAiApp());
}

class PinkAiApp extends StatelessWidget {
  const PinkAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFE86FB7);
    const backgroundColor = Color(0xFFFFF7FB);
    return MaterialApp(
      title: 'Pink AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: const Color(0xFF2A2A2A),
              displayColor: const Color(0xFF2A2A2A),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: Color(0xFF2A2A2A),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
