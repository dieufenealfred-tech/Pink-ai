import 'dart:async';

import 'package:flutter/material.dart';

import '../models/date_inputs.dart';
import '../models/date_plan.dart';
import '../services/openai_service.dart';
import '../theme/app_theme.dart';
import '../widgets/step_progress.dart';
import 'preview_locked_page.dart';

class GeneratingPage extends StatefulWidget {
  const GeneratingPage({super.key, required this.inputs});

  final DateInputs inputs;

  @override
  State<GeneratingPage> createState() => _GeneratingPageState();
}

class _GeneratingPageState extends State<GeneratingPage> {
  final List<String> _items = const [
    'Outfit advice',
    'What to say',
    'How to act',
    'Mistakes to avoid',
    'Perfect timing',
  ];
  final List<bool> _revealed = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _revealed.addAll(List<bool>.filled(_items.length, false));
    _animateChecklist();
    _generatePlan();
  }

  Future<void> _animateChecklist() async {
    for (var i = 0; i < _items.length; i++) {
      await Future.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      setState(() {
        _revealed[i] = true;
      });
    }
  }

  Future<void> _generatePlan() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final plan = await OpenAIService().generatePlan(widget.inputs);
      if (!mounted) return;
      _goToPreview(plan);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  void _goToPreview(DatePlan plan) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PreviewLockedPage(plan: plan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const StepProgress(currentStep: 7, totalSteps: 7),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Creating your perfect plan…',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ...List.generate(_items.length, (index) {
              final visible = _revealed[index];
              return AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _items[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            if (_error != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Something went wrong.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _generatePlan,
                    child: const Text('Try again'),
                  ),
                ],
              )
            else if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
