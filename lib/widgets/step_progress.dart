import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StepProgress extends StatelessWidget {
  const StepProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final dots = List<Widget>.generate(totalSteps, (index) {
      final isActive = index < currentStep;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 14 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primary : AppTheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $currentStep/$totalSteps',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Row(children: dots),
      ],
    );
  }
}
