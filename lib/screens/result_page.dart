import 'package:flutter/material.dart';

import '../models/date_inputs.dart';
import '../models/date_plan.dart';
import '../widgets/plan_section_card.dart';
import 'form_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.plan, required this.inputs});

  final DatePlan plan;
  final DateInputs inputs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your personalized date plan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    PlanSectionCard(
                      title: 'Outfit',
                      content: Text(plan.outfit),
                    ),
                    PlanSectionCard(
                      title: 'First words',
                      content: _buildList(plan.firstWords),
                    ),
                    PlanSectionCard(
                      title: 'Attitude',
                      content: _buildList(plan.attitude),
                    ),
                    PlanSectionCard(
                      title: 'Mistakes to avoid',
                      content: _buildList(plan.mistakes),
                    ),
                    PlanSectionCard(
                      title: 'Timing',
                      content: Text(plan.timing),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => FormPage(gender: inputs.gender),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('New date, new plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('• $item'),
          ),
      ],
    );
  }
}
