class DateInputs {
  const DateInputs({
    required this.gender,
    required this.age,
    required this.location,
    required this.personality,
    required this.budget,
    required this.goal,
  });

  final String gender;
  final int age;
  final String location;
  final String personality;
  final String budget;
  final String goal;

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age': age,
      'location': location,
      'personality': personality,
      'budget': budget,
      'goal': goal,
    };
  }
}
