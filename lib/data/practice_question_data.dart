import '../models/test_question.dart';
import 'firebase_question_service.dart';

/// Practice Question Data - Provides questions for practice sessions
/// Now fetches from Firebase with caching instead of local QuestionBank
class PracticeQuestionData {
  static final _firebaseService = FirebaseQuestionService();

  /// Get all questions (from Firebase with cache)
  static Future<List<TestQuestion>> getAllQuestions() async {
    return await _firebaseService.getAllQuestions();
  }

  /// Get questions by category
  static Future<List<TestQuestion>> getByCategory(String category) async {
    return await _firebaseService.getQuestions(category: category);
  }

  /// Get questions by level
  static Future<List<TestQuestion>> getByLevel(String level) async {
    return await _firebaseService.getQuestions(level: level);
  }

  /// Get questions by category and level
  static Future<List<TestQuestion>> getByCategoryAndLevel(
    String category,
    String level,
  ) async {
    return await _firebaseService.getQuestions(
      category: category,
      level: level,
    );
  }

  /// Get random questions
  static Future<List<TestQuestion>> getRandom(int count) async {
    final allQuestions = await getAllQuestions();
    allQuestions.shuffle();
    return allQuestions.take(count).toList();
  }

  /// Get random questions by category
  static Future<List<TestQuestion>> getRandomByCategory(
    String category,
    int count,
  ) async {
    final questions = await getByCategory(category);
    questions.shuffle();
    return questions.take(count).toList();
  }

  /// Get random questions by level
  static Future<List<TestQuestion>> getRandomByLevel(
    String level,
    int count,
  ) async {
    final questions = await getByLevel(level);
    questions.shuffle();
    return questions.take(count).toList();
  }

  /// Get random questions by category and level
  static Future<List<TestQuestion>> getRandomByCategoryAndLevel(
    String category,
    String level,
    int count,
  ) async {
    final questions = await getByCategoryAndLevel(category, level);
    questions.shuffle();
    return questions.take(count).toList();
  }

  /// Force refresh from Firebase (bypass cache)
  static Future<void> forceRefresh() async {
    await _firebaseService.forceRefresh();
  }

  /// Clear cache
  static Future<void> clearCache() async {
    await _firebaseService.clearCache();
  }
}
