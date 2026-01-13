import 'package:flutter/material.dart';

import 'screens/splash_page.dart';

void main() {
  runApp(const PinkAiApp());
}

class PinkAiApp extends StatelessWidget {
  const PinkAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pink AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
