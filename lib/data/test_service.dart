import 'package:cloud_firestore/cloud_firestore.dart';
import 'mock_test_data.dart';
import 'firebase_user_progress_service.dart';
import 'mock_exam_data.dart';
import 'firebase_question_service.dart';

class TestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _questionService = FirebaseQuestionService();

  /// Get Unit Test questions by category (9 MC + 6 Fill-in-blank)
  Future<List<TestQuestion>> getUnitTestQuestions(String categoryId) async {
    final allQuestions = await _questionService.getByCategory(categoryId);
    
    // Separate by type
    final mcQuestions = allQuestions
        .where((q) => q.type == QuestionType.multipleChoice)
        .toList()..shuffle();
    final fibQuestions = allQuestions
        .where((q) => q.type == QuestionType.fillInBlank)
        .toList()..shuffle();
    
    // Take 9 MC + 6 FIB
    final selected = <TestQuestion>[];
    selected.addAll(mcQuestions.take(9));
    selected.addAll(fibQuestions.take(6));
    selected.shuffle(); // Mix them up
    
    return selected;
  }

  /// Get Level Test questions by difficulty
  Future<List<TestQuestion>> getLevelTestQuestions(String level) async {
    final questions = await _questionService.getByLevel(level);
    questions.shuffle();
    return questions.take(30).toList(); // Increased to 30 questions
  }

  /// Get mock exam questions by exam ID
  Future<List<TestQuestion>> getMockExamQuestions(String mockExamId) async {
    final exam = MockExamData.getById(mockExamId);
    if (exam == null) return [];

    // Get questions from specified topics
    final questions = await _questionService.getByCategories(exam.topics);
    questions.shuffle();
    return questions.take(exam.totalQuestions).toList();
  }

  /// Get random test questions (simplified)
  Future<List<TestQuestion>> getRandomTestQuestions() async {
    final allQuestions = await _questionService.getAllQuestions();
    allQuestions.shuffle();
    return allQuestions.take(20).toList(); // Increased to 20 questions
  }

  /// Get question count by category
  Future<int> getQuestionCountByCategory(String categoryId) async {
    return await _questionService.getCountByCategory(categoryId);
  }

  /// Get question count by level
  Future<int> getQuestionCountByLevel(String level) async {
    return await _questionService.getCountByLevel(level);
  }

  /// Calculate test score (supports both MC and fill-in-blank)
  Map<String, dynamic> calculateScore({
    required List<TestQuestion> questions,
    required List<int?> userAnswers,
    required List<String?> userTextAnswers,
  }) {
    int correct = 0;
    List<Map<String, dynamic>> answerDetails = [];

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      bool isCorrect = false;
      dynamic userAnswer;
      dynamic correctAnswer;

      if (question.type == QuestionType.multipleChoice) {
        // Multiple choice grading
        userAnswer = userAnswers[i];
        correctAnswer = question.correctAnswer;
        isCorrect = userAnswer == correctAnswer;
      } else {
        // Fill in blank grading
        userAnswer = userTextAnswers[i]?.trim().toLowerCase() ?? '';
        correctAnswer = question.correctAnswerText?.trim().toLowerCase() ?? '';
        isCorrect = userAnswer == correctAnswer;
      }

      if (isCorrect) correct++;

      answerDetails.add({
        'questionId': question.id,
        'userAnswer': userAnswer,
        'correctAnswer': correctAnswer,
        'isCorrect': isCorrect,
        'questionType': question.type == QuestionType.multipleChoice ? 'multipleChoice' : 'fillInBlank',
      });
    }

    final percentage = (correct / questions.length * 100).round();

    return {
      'correct': correct,
      'total': questions.length,
      'percentage': percentage,
      'answerDetails': answerDetails,
    };
  }

  /// Save test result to Firebase
  Future<void> saveTestResult({
    required String userId,
    required String testType,
    String? category,
    String? level,
    required int totalQuestions,
    required int correctAnswers,
    required int score,
    required int timeSpent,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final timestamp = DateTime.now();
      final docId = '${testType}_${timestamp.millisecondsSinceEpoch}';

      await _firestore.collection('tests').doc(docId).set({
        'userId': userId,
        'testType': testType,
        'category': category,
        'level': level,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'score': score,
        'timeSpent': timeSpent,
        'completedAt': timestamp,
        'answers': answers,
      });
      
      // Update streak
      final progressService = FirebaseUserProgressService();
      await progressService.checkAndUpdateStreak(userId);

      print('✅ Test result saved: $docId');
    } catch (e) {
      print('Error saving test result: $e');
      rethrow;
    }
  }

  /// Get test history for user
  Future<List<Map<String, dynamic>>> getTestHistory(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('tests')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(50)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();
    } catch (e) {
      print('Error getting test history: $e');
      return [];
    }
  }

  /// Stream test history
  Stream<List<Map<String, dynamic>>> streamTestHistory(String userId) {
    return _firestore
        .collection('tests')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();
    });
  }

  /// Get test statistics
  Future<Map<String, dynamic>> getTestStatistics(String userId) async {
    try {
      final tests = await getTestHistory(userId);

      if (tests.isEmpty) {
        return {
          'totalTests': 0,
          'averageScore': 0,
          'passRate': 0,
          'totalTimeSpent': 0,
        };
      }

      final totalTests = tests.length;
      final totalScore = tests.fold<int>(0, (sum, test) => sum + (test['score'] as int));
      final passedTests = tests.where((test) => (test['score'] as int) >= 60).length;
      final totalTime = tests.fold<int>(0, (sum, test) => sum + (test['timeSpent'] as int));

      return {
        'totalTests': totalTests,
        'averageScore': (totalScore / totalTests).round(),
        'passRate': ((passedTests / totalTests) * 100).round(),
        'totalTimeSpent': totalTime,
      };
    } catch (e) {
      print('Error getting test statistics: $e');
      return {
        'totalTests': 0,
        'averageScore': 0,
        'passRate': 0,
        'totalTimeSpent': 0,
      };
    }
  }

  /// Save mock exam result with attempt tracking
  Future<void> saveMockExamResult({
    required String userId,
    required String mockExamId,
    required int totalQuestions,
    required int correctAnswers,
    required int score,
    required int timeSpent,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      // Get current attempt number
      final history = await getMockExamHistory(userId, mockExamId);
      final attemptNumber = history.length + 1;

      final timestamp = DateTime.now();
      final docId = '${mockExamId}_${userId}_$attemptNumber';

      await _firestore.collection('mock_exam_results').doc(docId).set({
        'userId': userId,
        'mockExamId': mockExamId,
        'attemptNumber': attemptNumber,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'score': score,
        'timeSpent': timeSpent,
        'completedAt': timestamp,
        'answers': answers,
      });

      // Update streak
      final progressService = FirebaseUserProgressService();
      await progressService.checkAndUpdateStreak(userId);

      print('✅ Mock exam result saved: $docId (Attempt #$attemptNumber)');
    } catch (e) {
      print('Error saving mock exam result: $e');
      rethrow;
    }
  }

  /// Get mock exam history for a specific exam
  Future<List<Map<String, dynamic>>> getMockExamHistory(
    String userId,
    String mockExamId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('mock_exam_results')
          .where('userId', isEqualTo: userId)
          .where('mockExamId', isEqualTo: mockExamId)
          .orderBy('attemptNumber', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
          'completedAt': (data['completedAt'] as Timestamp).toDate(),
        };
      }).toList();
    } catch (e) {
      print('Error getting mock exam history: $e');
      return [];
    }
  }

  /// Save random test result (simplified, no attempt tracking)
  Future<void> saveRandomTestResult({
    required String userId,
    required int totalQuestions,
    required int correctAnswers,
    required int score,
    required int timeSpent,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final timestamp = DateTime.now();
      final docId = 'random_${timestamp.millisecondsSinceEpoch}';

      await _firestore.collection('random_test_results').doc(docId).set({
        'userId': userId,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'score': score,
        'timeSpent': timeSpent,
        'completedAt': timestamp,
        'answers': answers,
      });

      // Update streak
      final progressService = FirebaseUserProgressService();
      await progressService.checkAndUpdateStreak(userId);

      print('✅ Random test result saved: $docId');
    } catch (e) {
      print('Error saving random test result: $e');
      rethrow;
    }
  }
}
