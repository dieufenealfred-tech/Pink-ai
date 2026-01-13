import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/luxe_button.dart';

class AgeStep extends StatefulWidget {
  const AgeStep({
    super.key,
    required this.onNext,
    required this.initialRange,
  });

  final ValueChanged<String> onNext;
  final String initialRange;

  @override
  State<AgeStep> createState() => _AgeStepState();
}

class _AgeStepState extends State<AgeStep> {
  static const List<String> _stops = ['18', '25', '30', '40+'];
  double _value = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialRange.isNotEmpty) {
      final index = _stops.indexOf(widget.initialRange);
      if (index >= 0) {
        _value = index.toDouble();
      }
    }
  }

  String get _selected => _stops[_value.round()];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How old are they?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Just a range is perfect.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _selected,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primary,
                      ),
                ),
                Slider(
                  value: _value,
                  min: 0,
                  max: 3,
                  divisions: 3,
                  activeColor: AppTheme.primary,
                  label: _selected,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _stops
                      .map(
                        (stop) => Text(
                          stop,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'This helps us match the vibe.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textDark.withOpacity(0.7),
                ),
          ),
          const Spacer(),
          LuxeButton(
            label: 'Next',
            onPressed: () => widget.onNext(_selected),
          ),
        ],
      ),
    );
  }
}
