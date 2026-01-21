import 'package:cloud_firestore/cloud_firestore.dart';

/// Question type enum
enum QuestionType {
  multipleChoice,
  fillInBlank,
  errorCorrection,
}

class TestQuestion {
  final String id;
  final String question;
  final QuestionType type;
  
  // For multiple choice
  final List<String>? options;
  final int? correctAnswer;
  
  // For fill in blank
  final String? correctAnswerText;
  final String? hint;
  
  // For error correction
  final String? incorrectSentence;
  final String? errorWord;
  final String? correctedWord;
  final int? errorPosition;
  
  final String explanation;
  final String category;
  final String level;

  TestQuestion({
    required this.id,
    required this.question,
    this.type = QuestionType.multipleChoice,
    this.options,
    this.correctAnswer,
    this.correctAnswerText,
    this.hint,
    this.incorrectSentence,
    this.errorWord,
    this.correctedWord,
    this.errorPosition,
    required this.explanation,
    required this.category,
    required this.level,
  });

  factory TestQuestion.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    final typeStr = data['type'] as String? ?? 'multipleChoice';
    final type = typeStr == 'fillInBlank' 
        ? QuestionType.fillInBlank 
        : typeStr == 'errorCorrection'
        ? QuestionType.errorCorrection
        : QuestionType.multipleChoice;
    
    return TestQuestion(
      id: data['id'] ?? doc.id,
      question: data['question'] ?? '',
      type: type,
      options: data['options'] != null 
          ? List<String>.from(data['options']) 
          : null,
      correctAnswer: data['correctAnswer'],
      correctAnswerText: data['correctAnswerText'],
      hint: data['hint'],
      incorrectSentence: data['incorrectSentence'],
      errorWord: data['errorWord'],
      correctedWord: data['correctedWord'],
      errorPosition: data['errorPosition'],
      explanation: data['explanation'] ?? '',
      category: data['category'] ?? '',
      level: data['level'] ?? 'beginner',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'question': question,
      'type': type == QuestionType.fillInBlank 
          ? 'fillInBlank' 
          : type == QuestionType.errorCorrection
          ? 'errorCorrection'
          : 'multipleChoice',
      'options': options,
      'correctAnswer': correctAnswer,
      'correctAnswerText': correctAnswerText,
      'hint': hint,
      'incorrectSentence': incorrectSentence,
      'errorWord': errorWord,
      'correctedWord': correctedWord,
      'errorPosition': errorPosition,
      'explanation': explanation,
      'category': category,
      'level': level,
      'isActive': true,
    };
  }

  /// Convert to Map for local caching
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'type': type == QuestionType.fillInBlank 
          ? 'fillInBlank' 
          : type == QuestionType.errorCorrection
          ? 'errorCorrection'
          : 'multipleChoice',
      'options': options,
      'correctAnswer': correctAnswer,
      'correctAnswerText': correctAnswerText,
      'hint': hint,
      'incorrectSentence': incorrectSentence,
      'errorWord': errorWord,
      'correctedWord': correctedWord,
      'errorPosition': errorPosition,
      'explanation': explanation,
      'category': category,
      'level': level,
    };
  }

  /// Create from Map for local caching
  factory TestQuestion.fromMap(Map<String, dynamic> data) {
    final typeStr = data['type'] as String? ?? 'multipleChoice';
    final type = typeStr == 'fillInBlank' 
        ? QuestionType.fillInBlank 
        : typeStr == 'errorCorrection'
        ? QuestionType.errorCorrection
        : QuestionType.multipleChoice;
    
    return TestQuestion(
      id: data['id'] ?? '',
      question: data['question'] ?? '',
      type: type,
      options: data['options'] != null 
          ? List<String>.from(data['options']) 
          : null,
      correctAnswer: data['correctAnswer'],
      correctAnswerText: data['correctAnswerText'],
      hint: data['hint'],
      incorrectSentence: data['incorrectSentence'],
      errorWord: data['errorWord'],
      correctedWord: data['correctedWord'],
      errorPosition: data['errorPosition'],
      explanation: data['explanation'] ?? '',
      category: data['category'] ?? '',
      level: data['level'] ?? 'beginner',
    );
  }
}
