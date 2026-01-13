class DatePlan {
  const DatePlan({
    required this.title,
    required this.summary,
    required this.outfit,
    required this.whatToSay,
    required this.howToAct,
    required this.mistakesToAvoid,
    required this.timing,
  });

  final String title;
  final String summary;
  final List<String> outfit;
  final List<String> whatToSay;
  final List<String> howToAct;
  final List<String> mistakesToAvoid;
  final List<String> timing;

  factory DatePlan.fromJson(Map<String, dynamic> json) {
    return DatePlan(
      title: json['title'] as String? ?? 'Your Luxury Date Plan',
      summary: json['summary'] as String? ?? '',
      outfit: List<String>.from(json['outfit'] as List? ?? const []),
      whatToSay: List<String>.from(json['what_to_say'] as List? ?? const []),
      howToAct: List<String>.from(json['how_to_act'] as List? ?? const []),
      mistakesToAvoid:
          List<String>.from(json['mistakes_to_avoid'] as List? ?? const []),
      timing: List<String>.from(json['timing'] as List? ?? const []),
    );
  }
}
