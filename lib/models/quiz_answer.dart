import 'quiz.dart';
import 'quiz_attempt.dart';

class QuizAnswer {
  final String id;
  final String attemptId;
  final String quizId;
  final List<String> selectedAnswerIds;
  final bool isCorrect;
  final int pointsEarned;
  final DateTime answeredAt;

  QuizAnswer({
    required this.id,
    required this.attemptId,
    required this.quizId,
    required this.selectedAnswerIds,
    required this.isCorrect,
    required this.pointsEarned,
    required this.answeredAt,
  });

  // Check if answer is empty
  bool get isEmpty => selectedAnswerIds.isEmpty;

  // Get single selected answer (for backward compatibility)
  String? get selectedAnswer =>
      selectedAnswerIds.isNotEmpty ? selectedAnswerIds.first : null;

  // Validation
  static String? validate(List<String> selectedAnswerIds) {
    if (selectedAnswerIds.isEmpty) {
      return 'Vui lòng chọn ít nhất một đáp án';
    }
    return null;
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attemptId': attemptId,
      'quizId': quizId,
      'selectedAnswerIds': selectedAnswerIds,
      'isCorrect': isCorrect,
      'pointsEarned': pointsEarned,
      'answeredAt': answeredAt.toIso8601String(),
    };
  }

  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    // Handle backward compatibility for selectedAnswers field
    List<String> selectedIds;
    if (json.containsKey('selectedAnswerIds')) {
      selectedIds = (json['selectedAnswerIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } else if (json.containsKey('selectedAnswers')) {
      selectedIds = (json['selectedAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } else {
      selectedIds = [];
    }

    return QuizAnswer(
      id: json['id'] as String,
      attemptId: json['attemptId'] as String,
      quizId: json['quizId'] as String,
      selectedAnswerIds: selectedIds,
      isCorrect: json['isCorrect'] as bool,
      pointsEarned: json['pointsEarned'] as int,
      answeredAt: DateTime.parse(json['answeredAt'] as String),
    );
  }

  // CopyWith method
  QuizAnswer copyWith({
    String? id,
    String? attemptId,
    String? quizId,
    List<String>? selectedAnswerIds,
    bool? isCorrect,
    int? pointsEarned,
    DateTime? answeredAt,
  }) {
    return QuizAnswer(
      id: id ?? this.id,
      attemptId: attemptId ?? this.attemptId,
      quizId: quizId ?? this.quizId,
      selectedAnswerIds: selectedAnswerIds ?? this.selectedAnswerIds,
      isCorrect: isCorrect ?? this.isCorrect,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizAnswer && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for analyzing answers
extension QuizAnswerListExtension on List<QuizAnswer> {
  List<QuizAnswer> byAttempt(String attemptId) {
    return where((answer) => answer.attemptId == attemptId).toList();
  }

  List<QuizAnswer> correctOnly() {
    return where((answer) => answer.isCorrect).toList();
  }

  List<QuizAnswer> incorrectOnly() {
    return where((answer) => !answer.isCorrect).toList();
  }

  int get correctCount => correctOnly().length;

  int get incorrectCount => incorrectOnly().length;

  int get totalPoints {
    return fold(0, (sum, answer) => sum + answer.pointsEarned);
  }

  double get accuracyRate {
    if (isEmpty) return 0.0;
    return (correctCount / length) * 100;
  }
}

/// Detailed information about a quiz answer for result display
class QuizAnswerDetail {
  final Quiz question;
  final QuizAnswer userAnswer;
  final bool isCorrect;
  final List<String> correctAnswerIds;
  final String? explanation;

  QuizAnswerDetail({
    required this.question,
    required this.userAnswer,
    required this.isCorrect,
    required this.correctAnswerIds,
    this.explanation,
  });
}

/// Complete quiz result with attempt, answers, and statistics
class QuizResult {
  final QuizAttempt attempt;
  final List<QuizAnswerDetail> answers;
  final Map<String, dynamic> statistics;

  QuizResult({
    required this.attempt,
    required this.answers,
    required this.statistics,
  });
}

