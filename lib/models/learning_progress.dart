enum ProgressStatus {
  notStarted,
  inProgress,
  completed,
  mastered;

  String toJson() => name;

  static ProgressStatus fromJson(String json) {
    return ProgressStatus.values.firstWhere((e) => e.name == json);
  }

  String get displayName {
    switch (this) {
      case ProgressStatus.notStarted:
        return 'Chưa bắt đầu';
      case ProgressStatus.inProgress:
        return 'Đang học';
      case ProgressStatus.completed:
        return 'Đã hoàn thành';
      case ProgressStatus.mastered:
        return 'Đã thành thạo';
    }
  }
}

class LearningProgress {
  final String id;
  final String userId;
  final String lessonId;
  final ProgressStatus status;
  final int attemptCount;
  final double bestScore;
  final DateTime? lastAttemptAt;
  final DateTime firstAccessedAt;
  final DateTime updatedAt;

  LearningProgress({
    required this.id,
    required this.userId,
    required this.lessonId,
    this.status = ProgressStatus.notStarted,
    this.attemptCount = 0,
    this.bestScore = 0.0,
    this.lastAttemptAt,
    required this.firstAccessedAt,
    required this.updatedAt,
  });

  // Check if user has started the lesson
  bool get hasStarted => status != ProgressStatus.notStarted;

  // Check if user has completed the lesson
  bool get isCompleted =>
      status == ProgressStatus.completed || status == ProgressStatus.mastered;

  // Check if user has mastered the lesson (>= 90% best score)
  bool get isMastered => bestScore >= 90.0;

  // Get progress percentage (0-100)
  double get progressPercentage {
    switch (status) {
      case ProgressStatus.notStarted:
        return 0.0;
      case ProgressStatus.inProgress:
        return bestScore > 0 ? bestScore : 25.0;
      case ProgressStatus.completed:
        return bestScore;
      case ProgressStatus.mastered:
        return 100.0;
    }
  }

  // Determine status based on score
  static ProgressStatus determineStatus({
    required double score,
    required int attemptCount,
  }) {
    if (attemptCount == 0) {
      return ProgressStatus.notStarted;
    } else if (score >= 90.0) {
      return ProgressStatus.mastered;
    } else if (score >= 60.0) {
      return ProgressStatus.completed;
    } else {
      return ProgressStatus.inProgress;
    }
  }

  // Update progress with new attempt result
  LearningProgress updateWithAttempt({
    required double score,
    required DateTime attemptTime,
  }) {
    final newBestScore = score > bestScore ? score : bestScore;
    final newAttemptCount = attemptCount + 1;
    final newStatus = determineStatus(
      score: newBestScore,
      attemptCount: newAttemptCount,
    );

    return copyWith(
      status: newStatus,
      attemptCount: newAttemptCount,
      bestScore: newBestScore,
      lastAttemptAt: attemptTime,
      updatedAt: DateTime.now(),
    );
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'lessonId': lessonId,
      'status': status.toJson(),
      'attemptCount': attemptCount,
      'bestScore': bestScore,
      'lastAttemptAt': lastAttemptAt?.toIso8601String(),
      'firstAccessedAt': firstAccessedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory LearningProgress.fromJson(Map<String, dynamic> json) {
    return LearningProgress(
      id: json['id'] as String,
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as String,
      status: ProgressStatus.fromJson(json['status'] as String),
      attemptCount: json['attemptCount'] as int? ?? 0,
      bestScore: (json['bestScore'] as num?)?.toDouble() ?? 0.0,
      lastAttemptAt: json['lastAttemptAt'] != null
          ? DateTime.parse(json['lastAttemptAt'] as String)
          : null,
      firstAccessedAt: DateTime.parse(json['firstAccessedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // CopyWith method
  LearningProgress copyWith({
    String? id,
    String? userId,
    String? lessonId,
    ProgressStatus? status,
    int? attemptCount,
    double? bestScore,
    DateTime? lastAttemptAt,
    DateTime? firstAccessedAt,
    DateTime? updatedAt,
  }) {
    return LearningProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      status: status ?? this.status,
      attemptCount: attemptCount ?? this.attemptCount,
      bestScore: bestScore ?? this.bestScore,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      firstAccessedAt: firstAccessedAt ?? this.firstAccessedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LearningProgress && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for analyzing progress
extension LearningProgressListExtension on List<LearningProgress> {
  List<LearningProgress> byUser(String userId) {
    return where((progress) => progress.userId == userId).toList();
  }

  List<LearningProgress> byLesson(String lessonId) {
    return where((progress) => progress.lessonId == lessonId).toList();
  }

  List<LearningProgress> byStatus(ProgressStatus status) {
    return where((progress) => progress.status == status).toList();
  }

  List<LearningProgress> completedOnly() {
    return where((progress) => progress.isCompleted).toList();
  }

  List<LearningProgress> masteredOnly() {
    return where((progress) => progress.isMastered).toList();
  }

  double get averageScore {
    if (isEmpty) return 0.0;
    final total = fold(0.0, (sum, progress) => sum + progress.bestScore);
    return total / length;
  }

  int get totalAttempts {
    return fold(0, (sum, progress) => sum + progress.attemptCount);
  }

  double get completionRate {
    if (isEmpty) return 0.0;
    return (completedOnly().length / length) * 100;
  }
}
