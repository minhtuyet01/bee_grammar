/// Exercise types in a CEFR lesson
enum CEFRExerciseType {
  warmup,
  input,
  practice,
  production,
  review,
}

/// Question types for CEFR exercises
enum CEFRQuestionType {
  multipleChoice,
  dragAndDrop,
  fillInBlank,
  matching,
  speaking,
  writing,
  listening,
  imageMatching,
}

/// Represents a single exercise in a CEFR lesson
class CEFRExercise {
  final String id;
  final CEFRExerciseType type;
  final CEFRQuestionType questionType;
  final String instruction;
  final dynamic content; // Flexible content (String, Map, List)
  final List<String> options;
  final dynamic correctAnswer;
  final String? audioUrl;
  final String? imageUrl;
  final String? explanation;
  final int points;

  CEFRExercise({
    required this.id,
    required this.type,
    required this.questionType,
    required this.instruction,
    required this.content,
    this.options = const [],
    required this.correctAnswer,
    this.audioUrl,
    this.imageUrl,
    this.explanation,
    this.points = 10,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'questionType': questionType.name,
        'instruction': instruction,
        'content': content,
        'options': options,
        'correctAnswer': correctAnswer,
        'audioUrl': audioUrl,
        'imageUrl': imageUrl,
        'explanation': explanation,
        'points': points,
      };

  factory CEFRExercise.fromJson(Map<String, dynamic> json) => CEFRExercise(
        id: json['id'],
        type: CEFRExerciseType.values.firstWhere((e) => e.name == json['type']),
        questionType: CEFRQuestionType.values.firstWhere((e) => e.name == json['questionType']),
        instruction: json['instruction'],
        content: json['content'],
        options: List<String>.from(json['options'] ?? []),
        correctAnswer: json['correctAnswer'],
        audioUrl: json['audioUrl'],
        imageUrl: json['imageUrl'],
        explanation: json['explanation'],
        points: json['points'] ?? 10,
      );
}
