import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/luxe_button.dart';
import '../../../widgets/option_card.dart';

class LocationStep extends StatefulWidget {
  const LocationStep({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.onOtherNext,
  });

  final String selected;
  final ValueChanged<String> onSelected;
  final ValueChanged<String> onOtherNext;

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  final TextEditingController _controller = TextEditingController();
  String _selected = '';

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSelection(String value) {
    if (value == 'Other') {
      setState(() {
        _selected = value;
      });
      return;
    }
    widget.onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    final isOther = _selected == 'Other';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where is the date happening?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Pick a place or type your own.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          OptionCard(
            title: 'Café',
            icon: const Text('☕', style: TextStyle(fontSize: 20)),
            onTap: () => _handleSelection('Café'),
          ),
          const SizedBox(height: 14),
          OptionCard(
            title: 'Restaurant',
            icon: const Text('🍽', style: TextStyle(fontSize: 20)),
            onTap: () => _handleSelection('Restaurant'),
          ),
          const SizedBox(height: 14),
          OptionCard(
            title: 'Bar',
            icon: const Text('🍸', style: TextStyle(fontSize: 20)),
            onTap: () => _handleSelection('Bar'),
          ),
          const SizedBox(height: 14),
          OptionCard(
            title: 'Walk',
            icon: const Text('🌿', style: TextStyle(fontSize: 20)),
            onTap: () => _handleSelection('Walk'),
          ),
          const SizedBox(height: 14),
          OptionCard(
            title: 'Other',
            icon: const Text('✍️', style: TextStyle(fontSize: 20)),
            selected: isOther,
            onTap: () => _handleSelection('Other'),
          ),
          if (isOther) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type location',
              ),
              onChanged: (_) => setState(() {}),
            ),
          ],
          const Spacer(),
          if (isOther)
            LuxeButton(
              label: 'Next',
              onPressed: _controller.text.trim().isEmpty
                  ? null
                  : () => widget.onOtherNext(_controller.text.trim()),
            )
          else
            Row(
              children: [
                Icon(Icons.place, color: AppTheme.primary.withOpacity(0.7)),
                const SizedBox(width: 8),
                Text(
                  'Choose the vibe. We’ll do the rest.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
