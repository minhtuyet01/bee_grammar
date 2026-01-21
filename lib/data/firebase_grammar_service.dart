import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/grammar_unit.dart';
import '../models/grammar_topic.dart';
import '../models/grammar_exercise.dart';
import '../models/grammar_test.dart';

/// Service for managing grammar content in Firebase
class FirebaseGrammarService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== Grammar Units ====================

  /// Get all grammar units for a specific CEFR level
  Future<List<GrammarUnit>> getGrammarUnits(String level) async {
    try {
      final snapshot = await _firestore
          .collection('grammar_units')
          .doc(level)
          .collection('units')
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => GrammarUnit.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Error getting grammar units: $e');
      return [];
    }
  }

  /// Get a specific grammar unit
  Future<GrammarUnit?> getGrammarUnit(String level, String unitId) async {
    try {
      final doc = await _firestore
          .collection('grammar_units')
          .doc(level)
          .collection('units')
          .doc(unitId)
          .get();

      if (!doc.exists) return null;
      return GrammarUnit.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      print('Error getting grammar unit: $e');
      return null;
    }
  }

  /// Stream grammar units for real-time updates
  Stream<List<GrammarUnit>> streamGrammarUnits(String level) {
    return _firestore
        .collection('grammar_units')
        .doc(level)
        .collection('units')
        .orderBy('order')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GrammarUnit.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // ==================== Grammar Topics ====================

  /// Get a specific grammar topic
  Future<GrammarTopic?> getGrammarTopic(String topicId) async {
    try {
      final doc = await _firestore
          .collection('grammar_topics')
          .doc(topicId)
          .get();

      if (!doc.exists) return null;
      return GrammarTopic.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      print('Error getting grammar topic: $e');
      return null;
    }
  }

  /// Get topics for a specific unit
  Future<List<GrammarTopic>> getTopicsForUnit(List<String> topicIds) async {
    if (topicIds.isEmpty) return [];

    try {
      final topics = <GrammarTopic>[];
      for (final topicId in topicIds) {
        final topic = await getGrammarTopic(topicId);
        if (topic != null) topics.add(topic);
      }
      return topics;
    } catch (e) {
      print('Error getting topics for unit: $e');
      return [];
    }
  }

  // ==================== Grammar Exercises ====================

  /// Get exercises for a specific topic
  Future<List<GrammarExercise>> getExercises(String topicId) async {
    try {
      final snapshot = await _firestore
          .collection('grammar_exercises')
          .where('topicId', isEqualTo: topicId)
          .orderBy('difficulty')
          .get();

      return snapshot.docs
          .map((doc) => GrammarExercise.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Error getting exercises: $e');
      return [];
    }
  }

  /// Get a specific exercise
  Future<GrammarExercise?> getExercise(String exerciseId) async {
    try {
      final doc = await _firestore
          .collection('grammar_exercises')
          .doc(exerciseId)
          .get();

      if (!doc.exists) return null;
      return GrammarExercise.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      print('Error getting exercise: $e');
      return null;
    }
  }

  /// Submit an exercise answer and check if correct
  Future<Map<String, dynamic>> submitExercise(
    String exerciseId,
    String userAnswer,
  ) async {
    try {
      final exercise = await getExercise(exerciseId);
      if (exercise == null) {
        return {
          'success': false,
          'error': 'Exercise not found',
        };
      }

      final isCorrect = exercise.checkAnswer(userAnswer);
      return {
        'success': true,
        'isCorrect': isCorrect,
        'correctAnswer': exercise.correctAnswer,
        'explanation': exercise.explanation,
        'xpReward': isCorrect ? exercise.xpReward : 0,
      };
    } catch (e) {
      print('Error submitting exercise: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // ==================== Grammar Tests ====================

  /// Get a specific test
  Future<GrammarTest?> getTest(String testId) async {
    try {
      final doc = await _firestore
          .collection('grammar_tests')
          .doc(testId)
          .get();

      if (!doc.exists) return null;
      return GrammarTest.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      print('Error getting test: $e');
      return null;
    }
  }

  /// Get all tests for a specific unit
  Future<List<GrammarTest>> getTestsForUnit(String unitId) async {
    try {
      final snapshot = await _firestore
          .collection('grammar_tests')
          .where('unitId', isEqualTo: unitId)
          .get();

      return snapshot.docs
          .map((doc) => GrammarTest.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Error getting tests for unit: $e');
      return [];
    }
  }

  /// Get all tests for a specific level
  Future<List<GrammarTest>> getTestsForLevel(String level) async {
    try {
      final snapshot = await _firestore
          .collection('grammar_tests')
          .where('level', isEqualTo: level)
          .get();

      return snapshot.docs
          .map((doc) => GrammarTest.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Error getting tests for level: $e');
      return [];
    }
  }

  /// Get questions for a test
  Future<List<GrammarExercise>> getTestQuestions(List<String> questionIds) async {
    if (questionIds.isEmpty) return [];

    try {
      final questions = <GrammarExercise>[];
      for (final questionId in questionIds) {
        final question = await getExercise(questionId);
        if (question != null) questions.add(question);
      }
      return questions;
    } catch (e) {
      print('Error getting test questions: $e');
      return [];
    }
  }

  /// Submit a test and calculate results
  Future<Map<String, dynamic>> submitTest(
    String testId,
    Map<String, String> userAnswers,
  ) async {
    try {
      final test = await getTest(testId);
      if (test == null) {
        return {
          'success': false,
          'error': 'Test not found',
        };
      }

      final questions = await getTestQuestions(test.questionIds);
      int correctCount = 0;

      for (final question in questions) {
        final userAnswer = userAnswers[question.id];
        if (userAnswer != null && question.checkAnswer(userAnswer)) {
          correctCount++;
        }
      }

      final score = ((correctCount / questions.length) * 100).round();
      final passed = score >= test.passingScore;

      return {
        'success': true,
        'score': score,
        'correctAnswers': correctCount,
        'totalQuestions': questions.length,
        'passed': passed,
        'xpReward': passed ? test.xpReward : 0,
      };
    } catch (e) {
      print('Error submitting test: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // ==================== Helper Methods ====================

  /// Create a new grammar unit (for admin/content creation)
  Future<bool> createGrammarUnit(String level, GrammarUnit unit) async {
    try {
      await _firestore
          .collection('grammar_units')
          .doc(level)
          .collection('units')
          .doc(unit.id)
          .set(unit.toJson());
      return true;
    } catch (e) {
      print('Error creating grammar unit: $e');
      return false;
    }
  }

  /// Create a new grammar topic (for admin/content creation)
  Future<bool> createGrammarTopic(GrammarTopic topic) async {
    try {
      await _firestore
          .collection('grammar_topics')
          .doc(topic.id)
          .set(topic.toJson());
      return true;
    } catch (e) {
      print('Error creating grammar topic: $e');
      return false;
    }
  }

  /// Create a new exercise (for admin/content creation)
  Future<bool> createExercise(GrammarExercise exercise) async {
    try {
      await _firestore
          .collection('grammar_exercises')
          .doc(exercise.id)
          .set(exercise.toJson());
      return true;
    } catch (e) {
      print('Error creating exercise: $e');
      return false;
    }
  }

  /// Create a new test (for admin/content creation)
  Future<bool> createTest(GrammarTest test) async {
    try {
      await _firestore
          .collection('grammar_tests')
          .doc(test.id)
          .set(test.toJson());
      return true;
    } catch (e) {
      print('Error creating test: $e');
      return false;
    }
  }

  /// Get all categories (grammar units across all levels)
  /// Fallback to hardcoded categories if Firebase fails
  Future<List<Map<String, String>>> getAllCategories() async {
    try {
      final levels = ['A1', 'A2', 'B1', 'B2', 'C1'];
      final Map<String, String> categoriesMap = {};

      for (final level in levels) {
        final units = await getGrammarUnits(level);
        for (final unit in units) {
          categoriesMap[unit.id] = unit.title;
        }
      }

      // If we got categories from Firebase, return them
      if (categoriesMap.isNotEmpty) {
        return categoriesMap.entries
            .map((e) => {'id': e.key, 'title': e.value})
            .toList();
      }

      // Fallback to hardcoded categories if Firebase fails
      print('⚠️ Using fallback categories');
      return _getFallbackCategories();
    } catch (e) {
      print('Error getting all categories: $e');
      return _getFallbackCategories();
    }
  }

  /// Fallback categories when Firebase is unavailable
  List<Map<String, String>> _getFallbackCategories() {
    return [
      {'id': 'cat_1', 'title': 'I. Các Thì Trong Tiếng Anh'},
      {'id': 'cat_2', 'title': 'II. Cấu Trúc Câu Trong Tiếng Anh'},
      {'id': 'cat_3', 'title': 'III. Các Từ Loại'},
      {'id': 'cat_4', 'title': 'IV. Các Dạng Câu Hỏi'},
      {'id': 'cat_5', 'title': 'V. Cấu Trúc Ngữ Pháp Tiếng Anh Cơ Bản'},
    ];
  }
}
