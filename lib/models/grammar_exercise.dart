/// Exercise types for grammar practice
enum ExerciseType {
  fillInBlank,
  multipleChoice,
  errorCorrection,
  sentenceReorder,
  transformation,
}

/// Represents a grammar exercise/question
class GrammarExercise {
  final String id;
  final String topicId;
  final ExerciseType type;
  final String question;
  final List<String>? options; // For multiple choice
  final String correctAnswer;
  final String explanation;
  final int difficulty; // 1 = easy, 2 = medium, 3 = hard
  final int xpReward;

  const GrammarExercise({
    required this.id,
    required this.topicId,
    required this.type,
    required this.question,
    this.options,
    required this.correctAnswer,
    required this.explanation,
    this.difficulty = 1,
    this.xpReward = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'type': type.name,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'difficulty': difficulty,
      'xpReward': xpReward,
    };
  }

  factory GrammarExercise.fromJson(Map<String, dynamic> json) {
    return GrammarExercise(
      id: json['id'] as String,
      topicId: json['topicId'] as String,
      type: ExerciseType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ExerciseType.fillInBlank,
      ),
      question: json['question'] as String,
      options: (json['options'] as List?)?.cast<String>(),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      difficulty: json['difficulty'] as int? ?? 1,
      xpReward: json['xpReward'] as int? ?? 10,
    );
  }

  bool checkAnswer(String userAnswer) {
    return userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
  }

  GrammarExercise copyWith({
    String? id,
    String? topicId,
    ExerciseType? type,
    String? question,
    List<String>? options,
    String? correctAnswer,
    String? explanation,
    int? difficulty,
    int? xpReward,
  }) {
    return GrammarExercise(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      type: type ?? this.type,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      difficulty: difficulty ?? this.difficulty,
      xpReward: xpReward ?? this.xpReward,
    );
  }
}
