import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/test_question.dart';
import 'firebase_user_progress_service.dart';
import 'mock_exam_data.dart';
import 'firebase_question_service.dart';

class TestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _questionService = FirebaseQuestionService();
  
  // Cache for Firebase questions
  final Map<String, List<TestQuestion>> _unitTestCache = {};
  final Map<String, List<TestQuestion>> _levelTestCache = {};
  final Map<String, List<TestQuestion>> _mockExamCache = {};

  /// Get Unit Test questions by category from Firebase (15 random questions)
  Future<List<TestQuestion>> getUnitTestQuestions(String categoryId) async {
    print('🔍 [UNIT TEST] Fetching questions for category: $categoryId');
    
    // Check cache first
    if (_unitTestCache.containsKey(categoryId)) {
      print('✅ [UNIT TEST] Using cached questions: ${_unitTestCache[categoryId]!.length}');
      final cached = List<TestQuestion>.from(_unitTestCache[categoryId]!);
      cached.shuffle();
      return cached.take(15).toList();
    }
    
    print('☁️ [UNIT TEST] Fetching from Firebase test_questions collection...');
    // Fetch from Firebase
    final snapshot = await _firestore
        .collection('test_questions')
        .where('testType', isEqualTo: 'unit')
        .where('category', isEqualTo: categoryId)
        .get();
    
    print('📦 [UNIT TEST] Fetched ${snapshot.docs.length} questions from Firebase');
    
    final questions = snapshot.docs
        .map((doc) => TestQuestion.fromFirestore(doc))
        .toList();
    
    // Save to cache
    _unitTestCache[categoryId] = questions;
    
    // Shuffle and return 15 questions
    questions.shuffle();
    return questions.take(15).toList();
  }

  /// Get Level Test questions by difficulty from Firebase
  Future<List<TestQuestion>> getLevelTestQuestions(String level) async {
    // Check cache first
    if (_levelTestCache.containsKey(level)) {
      final cached = List<TestQuestion>.from(_levelTestCache[level]!);
      cached.shuffle();
      
      int questionCount = level == 'beginner' ? 30 : level == 'intermediate' ? 40 : 50;
      return cached.take(questionCount).toList();
    }
    
    // Fetch from Firebase
    final snapshot = await _firestore
        .collection('test_questions')
        .where('testType', isEqualTo: 'level')
        .where('level', isEqualTo: level)
        .get();
    
    final allQuestions = snapshot.docs
        .map((doc) => TestQuestion.fromFirestore(doc))
        .toList();
    
    // Save to cache
    _levelTestCache[level] = allQuestions;
    
    // Shuffle and return correct number of questions
    // Beginner: 30 from 60, Intermediate: 40 from 80, Advanced: 50 from 100
    allQuestions.shuffle();
    
    int questionCount;
    switch (level.toLowerCase()) {
      case 'beginner':
        questionCount = 30;
        break;
      case 'intermediate':
        questionCount = 40;
        break;
      case 'advanced':
        questionCount = 50;
        break;
      default:
        questionCount = 30;
    }
    
    return allQuestions.take(questionCount).toList();
  }

  /// Get mock exam questions by exam ID from Firebase (Random from pool)
  Future<List<TestQuestion>> getMockExamQuestions(String mockExamId) async {
    // Check cache first
    if (_mockExamCache.containsKey(mockExamId)) {
      final cached = List<TestQuestion>.from(_mockExamCache[mockExamId]!);
      cached.shuffle();
      
      final exam = MockExamData.getById(mockExamId);
      if (exam == null) return cached;
      return cached.take(exam.totalQuestions).toList();
    }
    
    // Fetch from Firebase
    final snapshot = await _firestore
        .collection('test_questions')
        .where('testType', isEqualTo: 'mock')
        .where('examId', isEqualTo: mockExamId)
        .get();
    
    final allQuestions = snapshot.docs
        .map((doc) => TestQuestion.fromFirestore(doc))
        .toList();
    
    // Save to cache
    _mockExamCache[mockExamId] = allQuestions;
    
    // Shuffle and return correct number based on exam
    allQuestions.shuffle();
    
    // Get exam metadata for question count
    final exam = MockExamData.getById(mockExamId);
    if (exam == null) return allQuestions;
    
    return allQuestions.take(exam.totalQuestions).toList();
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

      // Determine title and category for display
      String testTitle;
      String? categoryTitle;
      
      if (testType == 'unit' && category != null) {
        testTitle = 'Kiểm tra: $category';
        categoryTitle = category;
      } else if (testType == 'level' && level != null) {
        testTitle = 'Kiểm tra trình độ: $level';
        categoryTitle = level;
      } else {
        testTitle = 'Kiểm tra';
      }

      await _firestore.collection('test_results').doc(docId).set({
        'userId': userId,
        'testType': testType,
        'testTitle': testTitle,
        'category': category,
        'categoryTitle': categoryTitle,
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
        'testTitle': 'Đề thi thử $mockExamId',
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
        'testTitle': 'Đề ngẫu nhiên',
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

  /// Get best score for a specific level test
  Future<int?> getLevelTestBestScore(String userId, String level) async {
    try {
      final snapshot = await _firestore
          .collection('tests')
          .where('userId', isEqualTo: userId)
          .where('testType', isEqualTo: 'level')
          .where('level', isEqualTo: level)
          .orderBy('score', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return snapshot.docs.first.data()['score'] as int;
    } catch (e) {
      print('Error getting level test best score: $e');
      return null;
    }
  }

  /// Get all level test scores for a user
  Future<Map<String, int>> getAllLevelTestScores(String userId) async {
    try {
      final Map<String, int> scores = {};
      
      for (final level in ['beginner', 'intermediate', 'advanced']) {
        final score = await getLevelTestBestScore(userId, level);
        if (score != null) {
          scores[level] = score;
        }
      }
      
      return scores;
    } catch (e) {
      print('Error getting all level test scores: $e');
      return {};
    }
  }

  /// Check if a level is unlocked based on previous level score
  Future<Map<String, bool>> getLevelUnlockStatus(String userId) async {
    try {
      final scores = await getAllLevelTestScores(userId);
      
      return {
        'beginner': true, // Always unlocked
        'intermediate': (scores['beginner'] ?? 0) >= 70,
        'advanced': (scores['intermediate'] ?? 0) >= 75,
      };
    } catch (e) {
      print('Error getting level unlock status: $e');
      return {
        'beginner': true,
        'intermediate': false,
        'advanced': false,
      };
    }
  }
}
