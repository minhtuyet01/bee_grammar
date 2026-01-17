/// Test types
enum TestType {
  unit, // Test for a specific unit
  level, // Test for a CEFR level (A1, A2, etc.)
  mock, // Mock exam
}

/// Represents a grammar test
class GrammarTest {
  final String id;
  final String title;
  final String description;
  final TestType type;
  final String? unitId; // For unit tests
  final String? level; // For level tests (A1, A2, B1, B2)
  final List<String> questionIds;
  final int timeLimit; // in minutes
  final int passingScore; // percentage (0-100)
  final int xpReward;

  const GrammarTest({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.unitId,
    this.level,
    required this.questionIds,
    this.timeLimit = 30,
    this.passingScore = 70,
    this.xpReward = 500,
  });

  int get totalQuestions => questionIds.length;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'unitId': unitId,
      'level': level,
      'questionIds': questionIds,
      'timeLimit': timeLimit,
      'passingScore': passingScore,
      'xpReward': xpReward,
    };
  }

  factory GrammarTest.fromJson(Map<String, dynamic> json) {
    return GrammarTest(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      type: TestType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TestType.unit,
      ),
      unitId: json['unitId'] as String?,
      level: json['level'] as String?,
      questionIds: (json['questionIds'] as List).cast<String>(),
      timeLimit: json['timeLimit'] as int? ?? 30,
      passingScore: json['passingScore'] as int? ?? 70,
      xpReward: json['xpReward'] as int? ?? 500,
    );
  }

  GrammarTest copyWith({
    String? id,
    String? title,
    String? description,
    TestType? type,
    String? unitId,
    String? level,
    List<String>? questionIds,
    int? timeLimit,
    int? passingScore,
    int? xpReward,
  }) {
    return GrammarTest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      unitId: unitId ?? this.unitId,
      level: level ?? this.level,
      questionIds: questionIds ?? this.questionIds,
      timeLimit: timeLimit ?? this.timeLimit,
      passingScore: passingScore ?? this.passingScore,
      xpReward: xpReward ?? this.xpReward,
    );
  }
}

/// Result of a test attempt
class TestResult {
  final String testId;
  final int score; // percentage (0-100)
  final int correctAnswers;
  final int totalQuestions;
  final DateTime completedAt;
  final int timeTaken; // in seconds
  final bool passed;
  final Map<String, String> userAnswers; // questionId -> answer

  const TestResult({
    required this.testId,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.completedAt,
    required this.timeTaken,
    required this.passed,
    required this.userAnswers,
  });

  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'score': score,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'completedAt': completedAt.toIso8601String(),
      'timeTaken': timeTaken,
      'passed': passed,
      'userAnswers': userAnswers,
    };
  }

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      testId: json['testId'] as String,
      score: json['score'] as int,
      correctAnswers: json['correctAnswers'] as int,
      totalQuestions: json['totalQuestions'] as int,
      completedAt: DateTime.parse(json['completedAt'] as String),
      timeTaken: json['timeTaken'] as int,
      passed: json['passed'] as bool,
      userAnswers: Map<String, String>.from(json['userAnswers'] as Map),
    );
  }
}
