import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/date_plan.dart';
import '../theme/app_theme.dart';
import '../widgets/luxe_button.dart';
import '../widgets/plan_section_card.dart';
import 'intro_page.dart';

class FullResultPage extends StatelessWidget {
  const FullResultPage({super.key, required this.plan});

  final DatePlan plan;

  String _formatPlan() {
    return '''
${plan.title}

${plan.summary}

Outfit advice:
${plan.outfit.map((item) => '• $item').join('\n')}

What to say:
${plan.whatToSay.map((item) => '• $item').join('\n')}

How to act:
${plan.howToAct.map((item) => '• $item').join('\n')}

Mistakes to avoid:
${plan.mistakesToAvoid.map((item) => '• $item').join('\n')}

Perfect timing:
${plan.timing.map((item) => '• $item').join('\n')}
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your full plan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    plan.summary,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            PlanSectionCard(
              title: 'Outfit advice',
              icon: Icons.checkroom,
              content: _buildBulletList(plan.outfit),
            ),
            PlanSectionCard(
              title: 'What to say',
              icon: Icons.chat_bubble_outline,
              content: _buildBulletList(plan.whatToSay),
            ),
            PlanSectionCard(
              title: 'How to act',
              icon: Icons.self_improvement,
              content: _buildBulletList(plan.howToAct),
            ),
            PlanSectionCard(
              title: 'Mistakes to avoid',
              icon: Icons.report_problem_outlined,
              content: _buildBulletList(plan.mistakesToAvoid),
            ),
            PlanSectionCard(
              title: 'Perfect timing',
              icon: Icons.schedule,
              content: _buildBulletList(plan.timing),
            ),
            const SizedBox(height: 16),
            LuxeButton(
              label: 'Copy plan',
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _formatPlan()));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Plan copied to clipboard.')),
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            LuxeButton(
              label: 'Start over',
              isPrimary: false,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const IntroPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
