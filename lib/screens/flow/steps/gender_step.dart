import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/option_card.dart';

class GenderStep extends StatelessWidget {
  const GenderStep({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who is this date for?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'We’ll tailor everything to this choice.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          OptionCard(
            title: 'Man',
            icon: const Text('👨', style: TextStyle(fontSize: 22)),
            onTap: () => onSelected('Man'),
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: 'Woman',
            icon: const Text('👩', style: TextStyle(fontSize: 22)),
            onTap: () => onSelected('Woman'),
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: 'Other',
            icon: const Text('💖', style: TextStyle(fontSize: 22)),
            onTap: () => onSelected('Other'),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.favorite, color: AppTheme.primary.withOpacity(0.6)),
              const SizedBox(width: 8),
              Text(
                'Always forward. Always focused.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
