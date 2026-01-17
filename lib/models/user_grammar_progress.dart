import 'grammar_test.dart';

/// Tracks user's progress for a specific grammar unit
class UserGrammarProgress {
  final String userId;
  final String unitId;
  final Map<String, bool> completedTopics; // topicId -> completed
  final Map<String, int> exerciseScores; // exerciseId -> score (0-100)
  final Map<String, TestResult> testResults; // testId -> result
  final DateTime lastAccessed;
  final int totalXpEarned;

  const UserGrammarProgress({
    required this.userId,
    required this.unitId,
    this.completedTopics = const {},
    this.exerciseScores = const {},
    this.testResults = const {},
    required this.lastAccessed,
    this.totalXpEarned = 0,
  });

  // Calculate overall progress for the unit
  double calculateProgress(int totalTopics) {
    if (totalTopics == 0) return 0.0;
    return completedTopics.values.where((completed) => completed).length / totalTopics;
  }

  // Get average exercise score
  double get averageExerciseScore {
    if (exerciseScores.isEmpty) return 0.0;
    final total = exerciseScores.values.reduce((a, b) => a + b);
    return total / exerciseScores.length;
  }

  // Check if unit test is passed
  bool get hasPassedUnitTest {
    return testResults.values.any((result) => result.passed);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'unitId': unitId,
      'completedTopics': completedTopics,
      'exerciseScores': exerciseScores,
      'testResults': testResults.map((key, value) => MapEntry(key, value.toJson())),
      'lastAccessed': lastAccessed.toIso8601String(),
      'totalXpEarned': totalXpEarned,
    };
  }

  factory UserGrammarProgress.fromJson(Map<String, dynamic> json) {
    return UserGrammarProgress(
      userId: json['userId'] as String,
      unitId: json['unitId'] as String,
      completedTopics: Map<String, bool>.from(json['completedTopics'] as Map? ?? {}),
      exerciseScores: Map<String, int>.from(json['exerciseScores'] as Map? ?? {}),
      testResults: (json['testResults'] as Map? ?? {}).map(
        (key, value) => MapEntry(
          key as String,
          TestResult.fromJson(value as Map<String, dynamic>),
        ),
      ),
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
      totalXpEarned: json['totalXpEarned'] as int? ?? 0,
    );
  }

  UserGrammarProgress copyWith({
    String? userId,
    String? unitId,
    Map<String, bool>? completedTopics,
    Map<String, int>? exerciseScores,
    Map<String, TestResult>? testResults,
    DateTime? lastAccessed,
    int? totalXpEarned,
  }) {
    return UserGrammarProgress(
      userId: userId ?? this.userId,
      unitId: unitId ?? this.unitId,
      completedTopics: completedTopics ?? this.completedTopics,
      exerciseScores: exerciseScores ?? this.exerciseScores,
      testResults: testResults ?? this.testResults,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      totalXpEarned: totalXpEarned ?? this.totalXpEarned,
    );
  }

  // Helper method to mark a topic as completed
  UserGrammarProgress markTopicCompleted(String topicId) {
    final updated = Map<String, bool>.from(completedTopics);
    updated[topicId] = true;
    return copyWith(
      completedTopics: updated,
      lastAccessed: DateTime.now(),
    );
  }

  // Helper method to save exercise score
  UserGrammarProgress saveExerciseScore(String exerciseId, int score, int xpReward) {
    final updatedScores = Map<String, int>.from(exerciseScores);
    updatedScores[exerciseId] = score;
    return copyWith(
      exerciseScores: updatedScores,
      totalXpEarned: totalXpEarned + xpReward,
      lastAccessed: DateTime.now(),
    );
  }

  // Helper method to save test result
  UserGrammarProgress saveTestResult(String testId, TestResult result, int xpReward) {
    final updatedResults = Map<String, TestResult>.from(testResults);
    updatedResults[testId] = result;
    return copyWith(
      testResults: updatedResults,
      totalXpEarned: totalXpEarned + (result.passed ? xpReward : 0),
      lastAccessed: DateTime.now(),
    );
  }
}
