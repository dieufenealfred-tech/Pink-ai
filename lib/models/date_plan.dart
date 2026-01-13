class DatePlan {
  const DatePlan({
    required this.outfit,
    required this.firstWords,
    required this.attitude,
    required this.mistakes,
    required this.timing,
  });

  final String outfit;
  final List<String> firstWords;
  final List<String> attitude;
  final List<String> mistakes;
  final String timing;

  factory DatePlan.fromJson(Map<String, dynamic> json) {
    return DatePlan(
      outfit: json['outfit'] as String,
      firstWords: List<String>.from(json['first_words'] as List),
      attitude: List<String>.from(json['attitude'] as List),
      mistakes: List<String>.from(json['mistakes'] as List),
      timing: json['timing'] as String,
    );
  }
}
