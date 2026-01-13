import 'package:flutter/material.dart';

import 'screens/intro_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PinkAiApp());
}

class PinkAiApp extends StatelessWidget {
  const PinkAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pink AI',
      theme: AppTheme.theme,
      home: const IntroPage(),
    );
  }
}
