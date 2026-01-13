import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/luxe_button.dart';

class BudgetStep extends StatefulWidget {
  const BudgetStep({
    super.key,
    required this.onNext,
    required this.initialValue,
  });

  final ValueChanged<String> onNext;
  final String initialValue;

  @override
  State<BudgetStep> createState() => _BudgetStepState();
}

class _BudgetStepState extends State<BudgetStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What’s your budget?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Enter what feels comfortable for you.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$ ',
              hintText: 'Enter amount',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Text(
            'No judgment. Great dates exist at every budget.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textDark.withOpacity(0.7),
                ),
          ),
          const Spacer(),
          LuxeButton(
            label: 'Next',
            onPressed: _controller.text.trim().isEmpty
                ? null
                : () => widget.onNext(_controller.text.trim()),
          ),
        ],
      ),
    );
  }
}
