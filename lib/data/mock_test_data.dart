import 'package:cloud_firestore/cloud_firestore.dart';

/// Question type enum
enum QuestionType {
  multipleChoice,
  fillInBlank,
}

class TestQuestion {
  final String id;
  final String question;
  final QuestionType type;
  
  // For multiple choice
  final List<String>? options;
  final int? correctAnswer; // Index of correct option (0, 1, 2, 3)
  
  // For fill in blank
  final String? correctAnswerText; // Single word answer
  final String? hint; // Hint for fill in blank
  
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
    required this.explanation,
    required this.category,
    required this.level,
  });

  /// Create TestQuestion from Firestore document
  factory TestQuestion.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Determine question type
    final typeStr = data['type'] as String? ?? 'multipleChoice';
    final type = typeStr == 'fillInBlank' 
        ? QuestionType.fillInBlank 
        : QuestionType.multipleChoice;
    
    return TestQuestion(
      id: data['id'] ?? doc.id,
      question: data['question'] ?? '',
      type: type,
      options: data['options'] != null ? List<String>.from(data['options']) : null,
      correctAnswer: data['correctAnswer'] as int?,
      correctAnswerText: data['correctAnswerText'] as String?,
      hint: data['hint'] as String?,
      explanation: data['explanation'] ?? '',
      category: data['category'] ?? '',
      level: data['level'] ?? '',
    );
  }

  /// Convert TestQuestion to Firestore map
  Map<String, dynamic> toFirestore() {
    final map = <String, dynamic>{
      'id': id,
      'question': question,
      'type': type == QuestionType.fillInBlank ? 'fillInBlank' : 'multipleChoice',
      'explanation': explanation,
      'category': category,
      'level': level,
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    
    // Add type-specific fields
    if (type == QuestionType.multipleChoice) {
      if (options != null) map['options'] = options!;
      if (correctAnswer != null) map['correctAnswer'] = correctAnswer!;
    } else {
      if (correctAnswerText != null) map['correctAnswerText'] = correctAnswerText!;
      if (hint != null) map['hint'] = hint!;
    }
    
    return map;
  }
}

class MockTestData {
  static List<TestQuestion> getAllQuestions() {
    return [
      // Present Simple
      TestQuestion(
        id: 'q1',
        question: 'She ___ to school every day.',
        options: ['go', 'goes', 'going', 'gone'],
        correctAnswer: 1,
        explanation: 'Present Simple với chủ ngữ số ít (she) thêm "s"',
        category: 'cat_1',
        level: 'beginner',
      ),
      TestQuestion(
        id: 'q2',
        question: 'They ___ English at the moment.',
        options: ['study', 'studies', 'are studying', 'studied'],
        correctAnswer: 2,
        explanation: 'Present Continuous với "at the moment"',
        category: 'cat_1',
        level: 'beginner',
      ),
      TestQuestion(
        id: 'q3',
        question: 'I ___ my homework already.',
        options: ['do', 'did', 'have done', 'am doing'],
        correctAnswer: 2,
        explanation: 'Present Perfect với "already"',
        category: 'cat_1',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q4',
        question: 'He ___ in this company for 5 years.',
        options: ['works', 'worked', 'has worked', 'is working'],
        correctAnswer: 2,
        explanation: 'Present Perfect với "for + khoảng thời gian"',
        category: 'cat_1',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q5',
        question: 'We ___ to the cinema yesterday.',
        options: ['go', 'went', 'have gone', 'are going'],
        correctAnswer: 1,
        explanation: 'Past Simple với "yesterday"',
        category: 'cat_1',
        level: 'beginner',
      ),

      // Conditional Sentences
      TestQuestion(
        id: 'q6',
        question: 'If it ___ tomorrow, we will stay home.',
        options: ['rain', 'rains', 'will rain', 'rained'],
        correctAnswer: 1,
        explanation: 'Câu điều kiện loại 1: If + Present Simple, will + V',
        category: 'cat_2',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q7',
        question: 'If I ___ rich, I would buy a big house.',
        options: ['am', 'was', 'were', 'will be'],
        correctAnswer: 2,
        explanation: 'Câu điều kiện loại 2: If + Past Simple (were), would + V',
        category: 'cat_2',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q8',
        question: 'If she had studied harder, she ___ the exam.',
        options: ['passes', 'passed', 'would pass', 'would have passed'],
        correctAnswer: 3,
        explanation: 'Câu điều kiện loại 3: If + Past Perfect, would have + V3',
        category: 'cat_2',
        level: 'advanced',
      ),

      // Passive Voice
      TestQuestion(
        id: 'q9',
        question: 'The letter ___ by John yesterday.',
        options: ['writes', 'wrote', 'was written', 'is written'],
        correctAnswer: 2,
        explanation: 'Câu bị động thì quá khứ: was/were + V3',
        category: 'cat_3',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q10',
        question: 'English ___ all over the world.',
        options: ['speaks', 'is spoken', 'was spoken', 'has spoken'],
        correctAnswer: 1,
        explanation: 'Câu bị động thì hiện tại: is/are + V3',
        category: 'cat_3',
        level: 'beginner',
      ),

      // Relative Clauses
      TestQuestion(
        id: 'q11',
        question: 'The man ___ is talking to Mary is my teacher.',
        options: ['who', 'which', 'where', 'when'],
        correctAnswer: 0,
        explanation: 'Dùng "who" cho người làm chủ ngữ',
        category: 'cat_4',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q12',
        question: 'The book ___ I bought yesterday is interesting.',
        options: ['who', 'which', 'where', 'whose'],
        correctAnswer: 1,
        explanation: 'Dùng "which" cho vật làm tân ngữ',
        category: 'cat_4',
        level: 'intermediate',
      ),

      // Reported Speech
      TestQuestion(
        id: 'q13',
        question: 'She said, "I am happy." → She said that she ___ happy.',
        options: ['is', 'was', 'has been', 'will be'],
        correctAnswer: 1,
        explanation: 'Câu gián tiếp: am/is → was',
        category: 'cat_5',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q14',
        question: 'He asked me, "Where do you live?" → He asked me where ___.',
        options: ['do I live', 'I live', 'did I live', 'I lived'],
        correctAnswer: 3,
        explanation: 'Câu hỏi gián tiếp: do/does → did, đảo ngữ về bình thường',
        category: 'cat_5',
        level: 'advanced',
      ),

      // More questions for variety
      TestQuestion(
        id: 'q15',
        question: 'I ___ TV when she called.',
        options: ['watch', 'watched', 'was watching', 'have watched'],
        correctAnswer: 2,
        explanation: 'Past Continuous khi hành động khác xen vào',
        category: 'cat_1',
        level: 'beginner',
      ),
      TestQuestion(
        id: 'q16',
        question: 'By next year, I ___ here for 10 years.',
        options: ['work', 'worked', 'will work', 'will have worked'],
        correctAnswer: 3,
        explanation: 'Future Perfect với "by + thời điểm tương lai"',
        category: 'cat_1',
        level: 'advanced',
      ),
      TestQuestion(
        id: 'q17',
        question: 'Unless you ___ hard, you will fail.',
        options: ['study', 'studied', 'will study', 'studies'],
        correctAnswer: 0,
        explanation: 'Unless = If not, dùng Present Simple',
        category: 'cat_2',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q18',
        question: 'The house ___ built in 1990.',
        options: ['is', 'was', 'has been', 'had been'],
        correctAnswer: 1,
        explanation: 'Câu bị động với thời điểm cụ thể trong quá khứ',
        category: 'cat_3',
        level: 'beginner',
      ),
      TestQuestion(
        id: 'q19',
        question: 'This is the city ___ I was born.',
        options: ['which', 'where', 'when', 'who'],
        correctAnswer: 1,
        explanation: 'Dùng "where" cho nơi chốn',
        category: 'cat_4',
        level: 'intermediate',
      ),
      TestQuestion(
        id: 'q20',
        question: 'Tom said, "I will come tomorrow." → Tom said he ___ the next day.',
        options: ['will come', 'would come', 'comes', 'came'],
        correctAnswer: 1,
        explanation: 'Câu gián tiếp: will → would, tomorrow → the next day',
        category: 'cat_5',
        level: 'intermediate',
      ),
    ];
  }

  static List<TestQuestion> getQuestionsByCategory(String categoryId, int count) {
    final allQuestions = getAllQuestions();
    final filtered = allQuestions.where((q) => q.category == categoryId).toList();
    filtered.shuffle();
    return filtered.take(count).toList();
  }

  static List<TestQuestion> getQuestionsByLevel(String level, int count) {
    final allQuestions = getAllQuestions();
    final filtered = allQuestions.where((q) => q.level == level).toList();
    filtered.shuffle();
    return filtered.take(count).toList();
  }

  static List<TestQuestion> getRandomQuestions(int count) {
    final allQuestions = getAllQuestions();
    allQuestions.shuffle();
    return allQuestions.take(count).toList();
  }

  static List<TestQuestion> getMockExamQuestions() {
    final allQuestions = getAllQuestions();
    allQuestions.shuffle();
    return allQuestions.take(20).toList();
  }
}
