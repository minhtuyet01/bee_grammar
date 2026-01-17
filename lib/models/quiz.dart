import 'dart:math';

enum QuizType {
  multipleChoice,
  multipleAnswer,
  trueFalse,
  fillInBlank;

  String toJson() => name;

  static QuizType fromJson(String json) {
    return QuizType.values.firstWhere((e) => e.name == json);
  }

  String get displayName {
    switch (this) {
      case QuizType.multipleChoice:
        return 'Trắc nghiệm 1 đáp án';
      case QuizType.multipleAnswer:
        return 'Trắc nghiệm nhiều đáp án';
      case QuizType.trueFalse:
        return 'Đúng/Sai';
      case QuizType.fillInBlank:
        return 'Điền vào chỗ trống';
    }
  }
}

enum DifficultyLevel {
  easy,
  medium,
  hard;

  String toJson() => name;

  static DifficultyLevel fromJson(String json) {
    return DifficultyLevel.values.firstWhere((e) => e.name == json);
  }

  String get displayName {
    switch (this) {
      case DifficultyLevel.easy:
        return 'Dễ';
      case DifficultyLevel.medium:
        return 'Trung bình';
      case DifficultyLevel.hard:
        return 'Khó';
    }
  }
}

class QuizOption {
  final String id;
  final String text;
  final int orderIndex;

  QuizOption({
    required this.id,
    required this.text,
    required this.orderIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'orderIndex': orderIndex,
    };
  }

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'] as String,
      text: json['text'] as String,
      orderIndex: json['orderIndex'] as int,
    );
  }

  QuizOption copyWith({
    String? id,
    String? text,
    int? orderIndex,
  }) {
    return QuizOption(
      id: id ?? this.id,
      text: text ?? this.text,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizOption && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Quiz {
  final String id;
  final String lessonId;
  final String questionText;
  final QuizType type;
  final List<QuizOption> options;
  final List<String> correctAnswerIds; // Support multiple correct answers
  final String? explanation;
  final int points;
  final int orderIndex;
  final DifficultyLevel difficulty;
  final DateTime createdAt;
  final DateTime updatedAt;

  Quiz({
    required this.id,
    required this.lessonId,
    required this.questionText,
    required this.type,
    required this.options,
    required this.correctAnswerIds,
    this.explanation,
    this.points = 1,
    required this.orderIndex,
    this.difficulty = DifficultyLevel.medium,
    required this.createdAt,
    required this.updatedAt,
  });

  // Get single correct answer (for backward compatibility)
  String get correctAnswer => correctAnswerIds.first;

  // Check if answer is correct
  bool isCorrect(List<String> selectedAnswerIds) {
    if (selectedAnswerIds.isEmpty) return false;

    // Sort both lists for comparison
    final sortedSelected = List<String>.from(selectedAnswerIds)..sort();
    final sortedCorrect = List<String>.from(correctAnswerIds)..sort();

    // Check if lists are equal
    if (sortedSelected.length != sortedCorrect.length) return false;

    for (int i = 0; i < sortedSelected.length; i++) {
      if (sortedSelected[i] != sortedCorrect[i]) return false;
    }

    return true;
  }

  // Check if single answer is correct (for single choice questions)
  bool isSingleAnswerCorrect(String answerId) {
    return correctAnswerIds.contains(answerId);
  }

  // Get shuffled options (for randomizing display order)
  List<QuizOption> getShuffledOptions({int? seed}) {
    final shuffled = List<QuizOption>.from(options);
    final random = seed != null ? Random(seed) : Random();
    shuffled.shuffle(random);
    return shuffled;
  }

  // Get option by ID
  QuizOption? getOptionById(String id) {
    try {
      return options.firstWhere((option) => option.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get correct option texts
  List<String> get correctAnswerTexts {
    return correctAnswerIds
        .map((id) => getOptionById(id)?.text)
        .where((text) => text != null)
        .cast<String>()
        .toList();
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'questionText': questionText,
      'type': type.toJson(),
      'options': options.map((o) => o.toJson()).toList(),
      'correctAnswerIds': correctAnswerIds,
      'explanation': explanation,
      'points': points,
      'orderIndex': orderIndex,
      'difficulty': difficulty.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    // Handle backward compatibility for correctAnswer field
    List<String> correctIds;
    if (json.containsKey('correctAnswerIds')) {
      correctIds = (json['correctAnswerIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } else if (json.containsKey('correctAnswer')) {
      correctIds = [json['correctAnswer'] as String];
    } else {
      throw Exception('No correct answer specified in quiz data');
    }

    return Quiz(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      questionText: json['questionText'] as String,
      type: QuizType.fromJson(json['type'] as String),
      options: (json['options'] as List<dynamic>)
          .map((e) => QuizOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswerIds: correctIds,
      explanation: json['explanation'] as String?,
      points: json['points'] as int? ?? 1,
      orderIndex: json['orderIndex'] as int,
      difficulty: json['difficulty'] != null
          ? DifficultyLevel.fromJson(json['difficulty'] as String)
          : DifficultyLevel.medium,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // CopyWith method
  Quiz copyWith({
    String? id,
    String? lessonId,
    String? questionText,
    QuizType? type,
    List<QuizOption>? options,
    List<String>? correctAnswerIds,
    String? explanation,
    int? points,
    int? orderIndex,
    DifficultyLevel? difficulty,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Quiz(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      questionText: questionText ?? this.questionText,
      type: type ?? this.type,
      options: options ?? this.options,
      correctAnswerIds: correctAnswerIds ?? this.correctAnswerIds,
      explanation: explanation ?? this.explanation,
      points: points ?? this.points,
      orderIndex: orderIndex ?? this.orderIndex,
      difficulty: difficulty ?? this.difficulty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Quiz && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for sorting quizzes
extension QuizListExtension on List<Quiz> {
  List<Quiz> sortByOrderIndex() {
    final sorted = List<Quiz>.from(this);
    sorted.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return sorted;
  }

  List<Quiz> byLesson(String lessonId) {
    return where((quiz) => quiz.lessonId == lessonId).toList();
  }

  List<Quiz> byDifficulty(DifficultyLevel difficulty) {
    return where((quiz) => quiz.difficulty == difficulty).toList();
  }

  int get totalPoints {
    return fold(0, (sum, quiz) => sum + quiz.points);
  }
}
