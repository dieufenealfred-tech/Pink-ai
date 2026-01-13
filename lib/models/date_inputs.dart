class DateInputs {
  const DateInputs({
    required this.gender,
    required this.ageRange,
    required this.location,
    required this.personality,
    required this.budget,
    required this.goal,
  });

  final String gender;
  final String ageRange;
  final String location;
  final String personality;
  final String budget;
  final String goal;

  DateInputs copyWith({
    String? gender,
    String? ageRange,
    String? location,
    String? personality,
    String? budget,
    String? goal,
  }) {
    return DateInputs(
      gender: gender ?? this.gender,
      ageRange: ageRange ?? this.ageRange,
      location: location ?? this.location,
      personality: personality ?? this.personality,
      budget: budget ?? this.budget,
      goal: goal ?? this.goal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age_range': ageRange,
      'location': location,
      'personality': personality,
      'budget': budget,
      'goal': goal,
    };
  }
}
