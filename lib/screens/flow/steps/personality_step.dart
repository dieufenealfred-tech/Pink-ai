import 'package:flutter/material.dart';

import '../../../widgets/option_chip.dart';

class PersonalityStep extends StatelessWidget {
  const PersonalityStep({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What’s their vibe?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose what fits best.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OptionChip(label: '😌 Chill', onTap: () => onSelected('Chill')),
              OptionChip(label: '🙈 Shy', onTap: () => onSelected('Shy')),
              OptionChip(
                label: '🚀 Ambitious',
                onTap: () => onSelected('Ambitious'),
              ),
              OptionChip(
                label: '😎 Confident',
                onTap: () => onSelected('Confident'),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Tap one to keep the momentum.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
