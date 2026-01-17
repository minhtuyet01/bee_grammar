/// Tracks user progress for a specific lesson
class UserLessonProgress {
  final String userId;
  final String unitId;
  final String lessonId;
  final bool isCompleted;
  final int score; // 0-100
  final DateTime? completedAt;
  final int attempts;
  final Map<String, dynamic> errors; // Error tracking for review
  final int xpEarned;
  final int diamondsEarned;

  UserLessonProgress({
    required this.userId,
    required this.unitId,
    required this.lessonId,
    this.isCompleted = false,
    this.score = 0,
    this.completedAt,
    this.attempts = 0,
    this.errors = const {},
    this.xpEarned = 0,
    this.diamondsEarned = 0,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'unitId': unitId,
        'lessonId': lessonId,
        'isCompleted': isCompleted,
        'score': score,
        'completedAt': completedAt?.toIso8601String(),
        'attempts': attempts,
        'errors': errors,
        'xpEarned': xpEarned,
        'diamondsEarned': diamondsEarned,
      };

  factory UserLessonProgress.fromJson(Map<String, dynamic> json) => UserLessonProgress(
        userId: json['userId'],
        unitId: json['unitId'],
        lessonId: json['lessonId'],
        isCompleted: json['isCompleted'] ?? false,
        score: json['score'] ?? 0,
        completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
        attempts: json['attempts'] ?? 0,
        errors: Map<String, dynamic>.from(json['errors'] ?? {}),
        xpEarned: json['xpEarned'] ?? 0,
        diamondsEarned: json['diamondsEarned'] ?? 0,
      );

  UserLessonProgress copyWith({
    bool? isCompleted,
    int? score,
    DateTime? completedAt,
    int? attempts,
    Map<String, dynamic>? errors,
    int? xpEarned,
    int? diamondsEarned,
  }) {
    return UserLessonProgress(
      userId: userId,
      unitId: unitId,
      lessonId: lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      completedAt: completedAt ?? this.completedAt,
      attempts: attempts ?? this.attempts,
      errors: errors ?? this.errors,
      xpEarned: xpEarned ?? this.xpEarned,
      diamondsEarned: diamondsEarned ?? this.diamondsEarned,
    );
  }
}
