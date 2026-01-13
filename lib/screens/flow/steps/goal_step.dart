import 'package:flutter/material.dart';

import '../../../widgets/option_card.dart';

class GoalStep extends StatelessWidget {
  const GoalStep({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What’s your goal?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: 'Casual connection',
            icon: const Text('💬', style: TextStyle(fontSize: 20)),
            onTap: () => onSelected('Casual connection'),
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: 'Romantic spark',
            icon: const Text('💕', style: TextStyle(fontSize: 20)),
            onTap: () => onSelected('Romantic spark'),
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: 'Strong impression',
            icon: const Text('🔥', style: TextStyle(fontSize: 20)),
            onTap: () => onSelected('Strong impression'),
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: 'Serious potential',
            icon: const Text('❤️', style: TextStyle(fontSize: 20)),
            onTap: () => onSelected('Serious potential'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
