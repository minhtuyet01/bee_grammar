/// Exercise types in a lesson
enum ExerciseType {
  warmup,
  input,
  practice,
  production,
  review,
}

/// Question types for exercises
enum QuestionType {
  multipleChoice,
  dragAndDrop,
  fillInBlank,
  matching,
  speaking,
  writing,
  listening,
  imageMatching,
}

/// Represents a single exercise in a lesson
class Exercise {
  final String id;
  final ExerciseType type;
  final QuestionType questionType;
  final String instruction;
  final dynamic content; // Flexible content (String, Map, List)
  final List<String> options;
  final dynamic correctAnswer;
  final String? audioUrl;
  final String? imageUrl;
  final String? explanation;
  final int points;

  Exercise({
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

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        type: ExerciseType.values.firstWhere((e) => e.name == json['type']),
        questionType: QuestionType.values.firstWhere((e) => e.name == json['questionType']),
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
