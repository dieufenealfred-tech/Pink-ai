import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/date_inputs.dart';
import 'generating_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.gender});

  final String gender;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  static const int _totalSteps = 6;
  static const int _stepOffset = 2;
  final PageController _controller = PageController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _customLocationController =
      TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  int _currentStep = 0;
  int? _age;
  String? _locationType;
  String? _personality;
  double? _budgetAmount;
  String? _goal;

  bool _showCustomLocation = false;

  @override
  void dispose() {
    _controller.dispose();
    _ageController.dispose();
    _customLocationController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentStep < _totalSteps - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _selectOption(VoidCallback update) {
    HapticFeedback.lightImpact();
    setState(update);
  }

  bool get _ageValid => _age != null && _age! >= 18 && _age! <= 99;

  bool get _locationValid {
    if (_locationType == null) {
      return false;
    }
    if (_locationType == 'Other') {
      return _customLocationController.text.trim().isNotEmpty;
    }
    return true;
  }

  bool get _budgetValid => _budgetAmount != null;

  DateInputs _buildInputs() {
    return DateInputs(
      gender: widget.gender,
      age: _age!,
      locationType: _locationType!,
      customLocation: _locationType == 'Other'
          ? _customLocationController.text.trim()
          : null,
      personality: _personality!,
      budgetAmount: _budgetAmount!,
      goal: _goal!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: _goBack,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentStep + _stepOffset) / _totalSteps,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(8),
                    backgroundColor: Colors.pink.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Step ${_currentStep + _stepOffset} of $_totalSteps',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentStep = index);
                },
                children: [
                  _buildAgeStep(context),
                  _buildLocationStep(context),
                  _buildPersonalityStep(context),
                  _buildBudgetStep(context),
                  _buildGoalStep(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepLayout({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                ),
          ),
          const SizedBox(height: 24),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildAgeStep(BuildContext context) {
    return _buildStepLayout(
      context: context,
      icon: Icons.cake,
      title: 'How old is your date?',
      subtitle: 'Just an estimate.',
      child: Column(
        children: [
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              prefixIcon: Icon(Icons.person_outline),
            ),
            onChanged: (value) {
              final parsed = int.tryParse(value.trim());
              setState(() => _age = parsed);
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Must be between 18 and 99.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _ageValid ? _goNext : null,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep(BuildContext context) {
    return _buildStepLayout(
      context: context,
      icon: Icons.location_on_outlined,
      title: 'Where is the date happening?',
      subtitle: 'Set the scene.',
      child: Column(
        children: [
          _OptionCard(
            label: 'Cafe',
            icon: Icons.local_cafe,
            isSelected: _locationType == 'Cafe',
            onTap: () => _selectOption(() {
              _locationType = 'Cafe';
              _showCustomLocation = false;
            }),
          ),
          _OptionCard(
            label: 'Restaurant',
            icon: Icons.restaurant,
            isSelected: _locationType == 'Restaurant',
            onTap: () => _selectOption(() {
              _locationType = 'Restaurant';
              _showCustomLocation = false;
            }),
          ),
          _OptionCard(
            label: 'Bar',
            icon: Icons.local_bar,
            isSelected: _locationType == 'Bar',
            onTap: () => _selectOption(() {
              _locationType = 'Bar';
              _showCustomLocation = false;
            }),
          ),
          _OptionCard(
            label: 'Walk',
            icon: Icons.directions_walk,
            isSelected: _locationType == 'Walk',
            onTap: () => _selectOption(() {
              _locationType = 'Walk';
              _showCustomLocation = false;
            }),
          ),
          _OptionCard(
            label: 'Other',
            icon: Icons.edit_location_alt,
            isSelected: _locationType == 'Other',
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                _locationType = 'Other';
                _showCustomLocation = true;
              });
            },
          ),
          if (_showCustomLocation) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _customLocationController,
              decoration: const InputDecoration(
                labelText: 'Type the place',
                hintText: 'Type the place',
              ),
              onChanged: (_) => setState(() {}),
            ),
          ],
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _locationValid ? _goNext : null,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalityStep(BuildContext context) {
    return _buildStepLayout(
      context: context,
      icon: Icons.bolt,
      title: 'What’s their vibe?',
      subtitle: 'So we can match the energy.',
      child: Column(
        children: [
          _OptionCard(
            label: 'Chill',
            icon: Icons.self_improvement,
            isSelected: _personality == 'Chill',
            onTap: () => _selectOption(() => _personality = 'Chill'),
          ),
          _OptionCard(
            label: 'Shy',
            icon: Icons.psychology,
            isSelected: _personality == 'Shy',
            onTap: () => _selectOption(() => _personality = 'Shy'),
          ),
          _OptionCard(
            label: 'Confident',
            icon: Icons.star,
            isSelected: _personality == 'Confident',
            onTap: () => _selectOption(() => _personality = 'Confident'),
          ),
          _OptionCard(
            label: 'Ambitious',
            icon: Icons.trending_up,
            isSelected: _personality == 'Ambitious',
            onTap: () => _selectOption(() => _personality = 'Ambitious'),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _personality == null ? null : _goNext,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetStep(BuildContext context) {
    return _buildStepLayout(
      context: context,
      icon: Icons.payments_outlined,
      title: 'What’s your budget?',
      subtitle: 'No judgment. Just smart planning.',
      child: Column(
        children: [
          TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Budget amount',
              hintText: 'Enter your budget',
              prefixIcon: Icon(Icons.attach_money),
            ),
            onChanged: (value) {
              final parsed = double.tryParse(value.trim());
              if (parsed == null || parsed < 0 || parsed > 10000) {
                setState(() => _budgetAmount = null);
              } else {
                setState(() => _budgetAmount = parsed);
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            'You can enter any amount.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _budgetValid ? _goNext : null,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalStep(BuildContext context) {
    return _buildStepLayout(
      context: context,
      icon: Icons.favorite_border,
      title: 'What’s your goal?',
      subtitle: 'What outcome do you want?',
      child: Column(
        children: [
          _OptionCard(
            label: 'Casual',
            icon: Icons.chat_bubble_outline,
            isSelected: _goal == 'Casual',
            onTap: () => _selectOption(() => _goal = 'Casual'),
          ),
          _OptionCard(
            label: 'Romantic',
            icon: Icons.favorite,
            isSelected: _goal == 'Romantic',
            onTap: () => _selectOption(() => _goal = 'Romantic'),
          ),
          _OptionCard(
            label: 'Serious',
            icon: Icons.handshake,
            isSelected: _goal == 'Serious',
            onTap: () => _selectOption(() => _goal = 'Serious'),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goal == null
                  ? null
                  : () {
                      if (_ageValid &&
                          _locationValid &&
                          _personality != null &&
                          _budgetValid &&
                          _goal != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                GeneratingPage(inputs: _buildInputs()),
                          ),
                        );
                      }
                    },
              child: const Text('Generate my plan'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your plan is tailored to this moment.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.chevron_right,
              color: isSelected ? color : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
