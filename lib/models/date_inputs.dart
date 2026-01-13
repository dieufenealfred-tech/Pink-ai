class DateInputs {
  const DateInputs({
    required this.gender,
    required this.age,
    required this.locationType,
    required this.customLocation,
    required this.personality,
    required this.budgetAmount,
    required this.goal,
  });

  final String gender;
  final int age;
  final String locationType;
  final String? customLocation;
  final String personality;
  final double budgetAmount;
  final String goal;

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age': age,
      'locationType': locationType,
      'customLocation': customLocation,
      'personality': personality,
      'budgetAmount': budgetAmount,
      'goal': goal,
    };
  }
}
