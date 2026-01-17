class ListeningQuestion {
  final String id;
  final String type; // multiple_choice, fill_blank, true_false
  final String question;
  final List<String> options;
  final String correctAnswer;
  final int timeStamp; // vị trí trong audio (seconds)

  ListeningQuestion({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.timeStamp,
  });

  factory ListeningQuestion.fromJson(Map<String, dynamic> json) {
    return ListeningQuestion(
      id: json['id'] as String,
      type: json['type'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswer: json['correctAnswer'] as String,
      timeStamp: json['timeStamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'timeStamp': timeStamp,
    };
  }

  bool isMultipleChoice() => type == 'multiple_choice';
  bool isFillBlank() => type == 'fill_blank';
  bool isTrueFalse() => type == 'true_false';
}
