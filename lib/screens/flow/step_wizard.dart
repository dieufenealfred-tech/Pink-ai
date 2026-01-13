import 'package:flutter/material.dart';

import '../../models/date_inputs.dart';
import '../../theme/app_theme.dart';
import '../../widgets/step_progress.dart';
import '../generating_page.dart';
import 'steps/age_step.dart';
import 'steps/budget_step.dart';
import 'steps/gender_step.dart';
import 'steps/goal_step.dart';
import 'steps/location_step.dart';
import 'steps/personality_step.dart';

class StepWizard extends StatefulWidget {
  const StepWizard({super.key});

  @override
  State<StepWizard> createState() => _StepWizardState();
}

class _StepWizardState extends State<StepWizard> {
  static const int _totalSteps = 7;
  final PageController _controller = PageController();
  int _currentIndex = 0;

  DateInputs _inputs = const DateInputs(
    gender: '',
    ageRange: '',
    location: '',
    personality: '',
    budget: '',
    goal: '',
  );

  void _nextStep() {
    if (_currentIndex < 5) {
      setState(() {
        _currentIndex += 1;
      });
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => GeneratingPage(inputs: _inputs),
        ),
      );
    }
  }

  void _updateInputs(DateInputs inputs) {
    setState(() {
      _inputs = inputs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final stepWidgets = [
      GenderStep(
        onSelected: (value) {
          _updateInputs(_inputs.copyWith(gender: value));
          _nextStep();
        },
      ),
      AgeStep(
        initialRange: _inputs.ageRange,
        onNext: (value) {
          _updateInputs(_inputs.copyWith(ageRange: value));
          _nextStep();
        },
      ),
      LocationStep(
        selected: _inputs.location,
        onSelected: (value) {
          _updateInputs(_inputs.copyWith(location: value));
          _nextStep();
        },
        onOtherNext: (value) {
          _updateInputs(_inputs.copyWith(location: value));
          _nextStep();
        },
      ),
      PersonalityStep(
        onSelected: (value) {
          _updateInputs(_inputs.copyWith(personality: value));
          _nextStep();
        },
      ),
      BudgetStep(
        initialValue: _inputs.budget,
        onNext: (value) {
          _updateInputs(_inputs.copyWith(budget: value));
          _nextStep();
        },
      ),
      GoalStep(
        onSelected: (value) {
          _updateInputs(_inputs.copyWith(goal: value));
          _nextStep();
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: StepProgress(
          currentStep: _currentIndex + 1,
          totalSteps: _totalSteps,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (_currentIndex == 0) {
              Navigator.of(context).pop();
            } else {
              setState(() {
                _currentIndex -= 1;
              });
              _controller.animateToPage(
                _currentIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.softPink, AppTheme.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: stepWidgets,
        ),
      ),
    );
  }
}
