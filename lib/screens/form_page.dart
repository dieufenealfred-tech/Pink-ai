import 'package:flutter/material.dart';

import '../models/date_inputs.dart';
import 'paywall_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.gender});

  final String gender;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();

  String? _location;
  String? _personality;
  String? _budget;
  String? _goal;

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final inputs = DateInputs(
      gender: widget.gender,
      age: int.parse(_ageController.text.trim()),
      location: _location!,
      personality: _personality!,
      budget: _budget!,
      goal: _goal!,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaywallPage(inputs: inputs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tell us about your date',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an age.';
                    }
                    final parsed = int.tryParse(value.trim());
                    if (parsed == null || parsed < 18 || parsed > 120) {
                      return 'Please enter a valid age (18-120).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _location,
                  items: const [
                    DropdownMenuItem(value: 'Cafe', child: Text('Cafe')),
                    DropdownMenuItem(value: 'Restaurant', child: Text('Restaurant')),
                    DropdownMenuItem(value: 'Bar', child: Text('Bar')),
                    DropdownMenuItem(value: 'Walk', child: Text('Walk')),
                  ],
                  onChanged: (value) => setState(() => _location = value),
                  decoration: const InputDecoration(
                    labelText: 'Where is the date?',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? 'Please choose one.' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _personality,
                  items: const [
                    DropdownMenuItem(value: 'Chill', child: Text('Chill')),
                    DropdownMenuItem(value: 'Shy', child: Text('Shy')),
                    DropdownMenuItem(value: 'Ambitious', child: Text('Ambitious')),
                    DropdownMenuItem(value: 'Confident', child: Text('Confident')),
                  ],
                  onChanged: (value) => setState(() => _personality = value),
                  decoration: const InputDecoration(
                    labelText: 'The person is mostly',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? 'Please choose one.' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _budget,
                  items: const [
                    DropdownMenuItem(value: r'$', child: Text(r'$')),
                    DropdownMenuItem(value: r'$$', child: Text(r'$$')),
                    DropdownMenuItem(value: r'$$$', child: Text(r'$$$')),
                  ],
                  onChanged: (value) => setState(() => _budget = value),
                  decoration: const InputDecoration(
                    labelText: 'Your budget',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? 'Please choose one.' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _goal,
                  items: const [
                    DropdownMenuItem(value: 'Casual', child: Text('Casual')),
                    DropdownMenuItem(value: 'Romantic', child: Text('Romantic')),
                    DropdownMenuItem(value: 'Serious', child: Text('Serious')),
                  ],
                  onChanged: (value) => setState(() => _goal = value),
                  decoration: const InputDecoration(
                    labelText: 'Your goal',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? 'Please choose one.' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Generate my plan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
