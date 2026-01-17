enum AttemptStatus {
  inProgress,
  completed,
  abandoned;

  String toJson() => name;

  static AttemptStatus fromJson(String json) {
    return AttemptStatus.values.firstWhere((e) => e.name == json);
  }

  String get displayName {
    switch (this) {
      case AttemptStatus.inProgress:
        return 'Đang làm';
      case AttemptStatus.completed:
        return 'Hoàn thành';
      case AttemptStatus.abandoned:
        return 'Đã bỏ';
    }
  }
}

class QuizAttempt {
  final String id;
  final String userId;
  final String lessonId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final AttemptStatus status;
  final int totalQuestions;
  final int correctAnswers;
  final int totalPoints;
  final int maxPoints;
  final int durationSeconds;

  QuizAttempt({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.startedAt,
    this.completedAt,
    required this.status,
    required this.totalQuestions,
    this.correctAnswers = 0,
    this.totalPoints = 0,
    required this.maxPoints,
    this.durationSeconds = 0,
  });

  // Calculate percentage score
  double get percentage {
    if (maxPoints == 0) return 0.0;
    return (totalPoints / maxPoints) * 100;
  }

  // Get grade based on percentage
  String get grade {
    final percent = percentage;
    if (percent >= 90) return 'Xuất sắc';
    if (percent >= 80) return 'Giỏi';
    if (percent >= 70) return 'Khá';
    if (percent >= 60) return 'Trung bình';
    if (percent >= 50) return 'Yếu';
    return 'Kém';
  }

  // Check if passed (>= 60%)
  bool get isPassed => percentage >= 60;

  // Get formatted duration
  String get formattedDuration {
    final duration = Duration(seconds: durationSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // Calculate duration from start and end times
  static int calculateDuration(DateTime startedAt, DateTime? completedAt) {
    if (completedAt == null) return 0;
    return completedAt.difference(startedAt).inSeconds;
  }

  // Check if attempt is in progress
  bool get isInProgress => status == AttemptStatus.inProgress;

  // Check if attempt is completed
  bool get isCompleted => status == AttemptStatus.completed;

  // Get accuracy rate
  double get accuracyRate {
    if (totalQuestions == 0) return 0.0;
    return (correctAnswers / totalQuestions) * 100;
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'lessonId': lessonId,
      'startedAt': startedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status.toJson(),
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'totalPoints': totalPoints,
      'maxPoints': maxPoints,
      'durationSeconds': durationSeconds,
    };
  }

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      id: json['id'] as String,
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      status: AttemptStatus.fromJson(json['status'] as String),
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      totalPoints: json['totalPoints'] as int? ?? 0,
      maxPoints: json['maxPoints'] as int,
      durationSeconds: json['durationSeconds'] as int? ?? 0,
    );
  }

  // CopyWith method
  QuizAttempt copyWith({
    String? id,
    String? userId,
    String? lessonId,
    DateTime? startedAt,
    DateTime? completedAt,
    AttemptStatus? status,
    int? totalQuestions,
    int? correctAnswers,
    int? totalPoints,
    int? maxPoints,
    int? durationSeconds,
  }) {
    return QuizAttempt(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalPoints: totalPoints ?? this.totalPoints,
      maxPoints: maxPoints ?? this.maxPoints,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizAttempt && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for sorting attempts
extension QuizAttemptListExtension on List<QuizAttempt> {
  List<QuizAttempt> sortByDate({bool descending = true}) {
    final sorted = List<QuizAttempt>.from(this);
    sorted.sort((a, b) {
      final comparison = a.startedAt.compareTo(b.startedAt);
      return descending ? -comparison : comparison;
    });
    return sorted;
  }

  List<QuizAttempt> byUser(String userId) {
    return where((attempt) => attempt.userId == userId).toList();
  }

  List<QuizAttempt> byLesson(String lessonId) {
    return where((attempt) => attempt.lessonId == lessonId).toList();
  }

  List<QuizAttempt> completedOnly() {
    return where((attempt) => attempt.isCompleted).toList();
  }

  double get averageScore {
    if (isEmpty) return 0.0;
    final total = fold(0.0, (sum, attempt) => sum + attempt.percentage);
    return total / length;
  }

  QuizAttempt? get bestAttempt {
    if (isEmpty) return null;
    return reduce((a, b) => a.percentage > b.percentage ? a : b);
  }
}
