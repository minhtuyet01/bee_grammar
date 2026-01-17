class DailyGoal {
  final int targetLessons;
  final int completedLessons;
  final int targetMinutes;
  final int completedMinutes;
  final String motivationalQuote;
  final DateTime date;

  DailyGoal({
    required this.targetLessons,
    required this.completedLessons,
    required this.targetMinutes,
    required this.completedMinutes,
    required this.motivationalQuote,
    required this.date,
  });

  bool get isCompleted => 
      completedLessons >= targetLessons && completedMinutes >= targetMinutes;

  double get lessonsProgress => 
      targetLessons > 0 ? (completedLessons / targetLessons).clamp(0.0, 1.0) : 0.0;

  double get minutesProgress => 
      targetMinutes > 0 ? (completedMinutes / targetMinutes).clamp(0.0, 1.0) : 0.0;

  double get overallProgress => (lessonsProgress + minutesProgress) / 2;

  Map<String, dynamic> toJson() => {
        'targetLessons': targetLessons,
        'completedLessons': completedLessons,
        'targetMinutes': targetMinutes,
        'completedMinutes': completedMinutes,
        'motivationalQuote': motivationalQuote,
        'date': date.toIso8601String(),
      };

  factory DailyGoal.fromJson(Map<String, dynamic> json) => DailyGoal(
        targetLessons: json['targetLessons'] as int,
        completedLessons: json['completedLessons'] as int,
        targetMinutes: json['targetMinutes'] as int,
        completedMinutes: json['completedMinutes'] as int,
        motivationalQuote: json['motivationalQuote'] as String,
        date: DateTime.parse(json['date'] as String),
      );
}
