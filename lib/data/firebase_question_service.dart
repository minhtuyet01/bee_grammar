import 'package:cloud_firestore/cloud_firestore.dart';
import 'mock_test_data.dart';

/// Firebase Question Service - Manages questions in Firestore
class FirebaseQuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Cache questions locally to reduce Firebase reads
  List<TestQuestion>? _cachedQuestions;
  DateTime? _lastFetch;
  static const _cacheDuration = Duration(minutes: 5);
  
  /// Get all active questions (with caching)
  Future<List<TestQuestion>> getAllQuestions() async {
    // Return cached data if still valid
    if (_cachedQuestions != null && 
        _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < _cacheDuration) {
      return _cachedQuestions!;
    }
    
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('isActive', isEqualTo: true)
          .get();
      
      _cachedQuestions = snapshot.docs
          .map((doc) => TestQuestion.fromFirestore(doc))
          .toList();
      _lastFetch = DateTime.now();
      
      return _cachedQuestions!;
    } catch (e) {
      print('Error fetching questions: $e');
      return [];
    }
  }
  
  /// Get questions by category
  Future<List<TestQuestion>> getByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', isEqualTo: categoryId)
          .where('isActive', isEqualTo: true)
          .get();
      
      return snapshot.docs
          .map((doc) => TestQuestion.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching questions by category: $e');
      return [];
    }
  }
  
  /// Get questions by level
  Future<List<TestQuestion>> getByLevel(String level) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('level', isEqualTo: level)
          .where('isActive', isEqualTo: true)
          .get();
      
      return snapshot.docs
          .map((doc) => TestQuestion.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching questions by level: $e');
      return [];
    }
  }
  
  /// Get questions by multiple categories
  Future<List<TestQuestion>> getByCategories(List<String> categoryIds) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', whereIn: categoryIds)
          .where('isActive', isEqualTo: true)
          .get();
      
      return snapshot.docs
          .map((doc) => TestQuestion.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching questions by categories: $e');
      return [];
    }
  }
  
  /// Get question count by category
  Future<int> getCountByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', isEqualTo: categoryId)
          .where('isActive', isEqualTo: true)
          .count()
          .get();
      
      return snapshot.count ?? 0;
    } catch (e) {
      print('Error counting questions by category: $e');
      return 0;
    }
  }
  
  /// Get question count by level
  Future<int> getCountByLevel(String level) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('level', isEqualTo: level)
          .where('isActive', isEqualTo: true)
          .count()
          .get();
      
      return snapshot.count ?? 0;
    } catch (e) {
      print('Error counting questions by level: $e');
      return 0;
    }
  }
  
  /// Clear cache (useful after adding/updating questions)
  void clearCache() {
    _cachedQuestions = null;
    _lastFetch = null;
  }
  
  // ============================================
  // ADMIN METHODS (for future admin panel)
  // ============================================
  
  /// Admin: Add new question
  Future<void> addQuestion(TestQuestion question) async {
    try {
      await _firestore.collection('questions').doc(question.id).set({
        'id': question.id,
        'question': question.question,
        'options': question.options,
        'correctAnswer': question.correctAnswer,
        'explanation': question.explanation,
        'category': question.category,
        'level': question.level,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isActive': true,
      });
      
      clearCache();
      print('✅ Question added: ${question.id}');
    } catch (e) {
      print('Error adding question: $e');
      rethrow;
    }
  }
  
  /// Admin: Update question
  Future<void> updateQuestion(TestQuestion question) async {
    try {
      await _firestore.collection('questions').doc(question.id).update({
        'question': question.question,
        'options': question.options,
        'correctAnswer': question.correctAnswer,
        'explanation': question.explanation,
        'category': question.category,
        'level': question.level,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      clearCache();
      print('✅ Question updated: ${question.id}');
    } catch (e) {
      print('Error updating question: $e');
      rethrow;
    }
  }
  
  /// Admin: Delete question (soft delete)
  Future<void> deleteQuestion(String questionId) async {
    try {
      await _firestore.collection('questions').doc(questionId).update({
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      clearCache();
      print('✅ Question deleted: $questionId');
    } catch (e) {
      print('Error deleting question: $e');
      rethrow;
    }
  }
  
  /// Admin: Batch upload questions
  Future<void> batchUploadQuestions(List<TestQuestion> questions) async {
    try {
      final batch = _firestore.batch();
      
      for (final question in questions) {
        final docRef = _firestore.collection('questions').doc(question.id);
        batch.set(docRef, {
          'id': question.id,
          'question': question.question,
          'options': question.options,
          'correctAnswer': question.correctAnswer,
          'explanation': question.explanation,
          'category': question.category,
          'level': question.level,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'isActive': true,
        });
      }
      
      await batch.commit();
      clearCache();
      print('✅ Batch uploaded ${questions.length} questions');
    } catch (e) {
      print('Error batch uploading questions: $e');
      rethrow;
    }
  }
}
