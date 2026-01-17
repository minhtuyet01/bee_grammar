import 'cefr_exercise.dart';

/// Represents a CEFR-based lesson within a unit
class CEFRLesson {
  final String id;
  final String unitId;
  final String title;
  final String objective;
  final int order;
  final int estimatedMinutes;
  final List<CEFRExercise> exercises;
  final int xpReward;
  final int diamondReward;
  final bool isCompleted;
  final int? score;
  final bool isLocked;

  CEFRLesson({
    required this.id,
    required this.unitId,
    required this.title,
    required this.objective,
    required this.order,
    this.estimatedMinutes = 5,
    required this.exercises,
    this.xpReward = 50,
    this.diamondReward = 10,
    this.isCompleted = false,
    this.score,
    this.isLocked = false,
  });

  int get totalPoints => exercises.fold(0, (sum, ex) => sum + ex.points);

  Map<String, dynamic> toJson() => {
        'id': id,
        'unitId': unitId,
        'title': title,
        'objective': objective,
        'order': order,
        'estimatedMinutes': estimatedMinutes,
        'exercises': exercises.map((e) => e.toJson()).toList(),
        'xpReward': xpReward,
        'diamondReward': diamondReward,
        'isCompleted': isCompleted,
        'score': score,
        'isLocked': isLocked,
      };

  factory CEFRLesson.fromJson(Map<String, dynamic> json) => CEFRLesson(
        id: json['id'],
        unitId: json['unitId'],
        title: json['title'],
        objective: json['objective'],
        order: json['order'],
        estimatedMinutes: json['estimatedMinutes'] ?? 5,
        exercises: (json['exercises'] as List).map((e) => CEFRExercise.fromJson(e)).toList(),
        xpReward: json['xpReward'] ?? 50,
        diamondReward: json['diamondReward'] ?? 10,
        isCompleted: json['isCompleted'] ?? false,
        score: json['score'],
        isLocked: json['isLocked'] ?? false,
      );

  CEFRLesson copyWith({
    bool? isCompleted,
    int? score,
    bool? isLocked,
  }) {
    return CEFRLesson(
      id: id,
      unitId: unitId,
      title: title,
      objective: objective,
      order: order,
      estimatedMinutes: estimatedMinutes,
      exercises: exercises,
      xpReward: xpReward,
      diamondReward: diamondReward,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
