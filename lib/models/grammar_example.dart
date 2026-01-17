/// Represents a grammar example sentence
class GrammarExample {
  final String sentence;
  final String translation;
  final String explanation;
  final bool isCorrect; // true for correct example, false for incorrect

  const GrammarExample({
    required this.sentence,
    required this.translation,
    required this.explanation,
    this.isCorrect = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'sentence': sentence,
      'translation': translation,
      'explanation': explanation,
      'isCorrect': isCorrect,
    };
  }

  factory GrammarExample.fromJson(Map<String, dynamic> json) {
    return GrammarExample(
      sentence: json['sentence'] as String,
      translation: json['translation'] as String,
      explanation: json['explanation'] as String,
      isCorrect: json['isCorrect'] as bool? ?? true,
    );
  }

  GrammarExample copyWith({
    String? sentence,
    String? translation,
    String? explanation,
    bool? isCorrect,
  }) {
    return GrammarExample(
      sentence: sentence ?? this.sentence,
      translation: translation ?? this.translation,
      explanation: explanation ?? this.explanation,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
