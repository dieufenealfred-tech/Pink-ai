import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LuxeButton extends StatelessWidget {
  const LuxeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        AppTheme.primary,
        AppTheme.primary.withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: isPrimary ? null : AppTheme.white,
          foregroundColor: isPrimary ? AppTheme.white : AppTheme.primary,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: isPrimary ? gradient : null,
            borderRadius: BorderRadius.circular(28),
            border: isPrimary
                ? null
                : Border.all(color: AppTheme.primary.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
