import 'package:flutter/material.dart';

import '../models/date_inputs.dart';
import '../models/date_plan.dart';
import '../services/openai_service.dart';
import 'result_page.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key, required this.inputs});

  final DateInputs inputs;

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  final OpenAIService _service = OpenAIService();
  bool _isLoading = false;
  String? _error;
  DatePlan? _plan;

  Future<void> _unlock() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      _plan ??= await _service.generatePlan(widget.inputs);
      if (!mounted) {
        return;
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResultPage(plan: _plan!, inputs: widget.inputs),
        ),
      );
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                'Don’t mess this up.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'We’ll help you say the right thing, wear the right thing, '
                'and avoid the wrong moves.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 16),
              _buildLockedPreview(context),
              const SizedBox(height: 20),
              _buildChecklist('Outfit advice'),
              _buildChecklist('What to say'),
              _buildChecklist('How to act'),
              _buildChecklist('Mistakes to avoid'),
              _buildChecklist('Perfect timing'),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
              const Spacer(),
              ElevatedButton(
                onPressed: _isLoading ? null : _unlock,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Unlock full plan — \\$4.99'),
              ),
              const SizedBox(height: 8),
              Text(
                'One-time purchase. No subscription.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklist(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 18, color: Colors.pink.shade400),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedPreview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium preview',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Outfit that matches the venue…',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            'A clean opening line that feels natural…',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            'How to build momentum without trying too hard…',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
