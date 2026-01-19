import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/grammar_lesson.dart';

/// Service for managing grammar content (Categories & Lessons) in Firebase
class FirebaseGrammarContentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== UPLOAD METHODS (Admin/Migration) ====================

  /// Upload all categories to Firebase
  Future<bool> uploadCategories(List<GrammarCategory> categories) async {
    try {
      final batch = _firestore.batch();
      
      for (final category in categories) {
        final docRef = _firestore
            .collection('grammar_categories')
            .doc(category.id);
        batch.set(docRef, category.toJson());
      }
      
      await batch.commit();
      print('✅ Uploaded ${categories.length} categories successfully');
      return true;
    } catch (e) {
      print('❌ Error uploading categories: $e');
      return false;
    }
  }

  /// Upload all lessons to Firebase
  Future<bool> uploadLessons(List<GrammarLesson> lessons) async {
    try {
      // Upload in batches of 500 (Firestore limit)
      const batchSize = 500;
      int uploadedCount = 0;

      for (int i = 0; i < lessons.length; i += batchSize) {
        final batch = _firestore.batch();
        final end = (i + batchSize < lessons.length) ? i + batchSize : lessons.length;
        final batchLessons = lessons.sublist(i, end);

        for (final lesson in batchLessons) {
          final docRef = _firestore
              .collection('grammar_lessons')
              .doc(lesson.id);
          batch.set(docRef, lesson.toJson());
        }

        await batch.commit();
        uploadedCount += batchLessons.length;
        print('✅ Uploaded $uploadedCount/${lessons.length} lessons');
      }

      print('✅ All lessons uploaded successfully');
      return true;
    } catch (e) {
      print('❌ Error uploading lessons: $e');
      return false;
    }
  }

  /// Upload a single category
  Future<bool> uploadCategory(GrammarCategory category) async {
    try {
      await _firestore
          .collection('grammar_categories')
          .doc(category.id)
          .set(category.toJson());
      print('✅ Uploaded category: ${category.title}');
      return true;
    } catch (e) {
      print('❌ Error uploading category: $e');
      return false;
    }
  }

  /// Upload a single lesson
  Future<bool> uploadLesson(GrammarLesson lesson) async {
    try {
      await _firestore
          .collection('grammar_lessons')
          .doc(lesson.id)
          .set(lesson.toJson());
      print('✅ Uploaded lesson: ${lesson.title}');
      return true;
    } catch (e) {
      print('❌ Error uploading lesson: $e');
      return false;
    }
  }

  // ==================== FETCH METHODS (App Usage) ====================

  /// Get all categories
  Future<List<GrammarCategory>> getCategories() async {
    try {
      final snapshot = await _firestore
          .collection('grammar_categories')
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => GrammarCategory.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('❌ Error fetching categories: $e');
      return [];
    }
  }

  /// Get a specific category
  Future<GrammarCategory?> getCategory(String categoryId) async {
    try {
      final doc = await _firestore
          .collection('grammar_categories')
          .doc(categoryId)
          .get();

      if (!doc.exists) return null;
      return GrammarCategory.fromJson(doc.data()!);
    } catch (e) {
      print('❌ Error fetching category: $e');
      return null;
    }
  }

  /// Get all lessons
  Future<List<GrammarLesson>> getAllLessons() async {
    try {
      final snapshot = await _firestore
          .collection('grammar_lessons')
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => GrammarLesson.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('❌ Error fetching lessons: $e');
      return [];
    }
  }

  /// Get lessons by category
  Future<List<GrammarLesson>> getLessonsByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('grammar_lessons')
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => GrammarLesson.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('❌ Error fetching lessons by category: $e');
      return [];
    }
  }

  /// Get a specific lesson
  Future<GrammarLesson?> getLesson(String lessonId) async {
    try {
      final doc = await _firestore
          .collection('grammar_lessons')
          .doc(lessonId)
          .get();

      if (!doc.exists) return null;
      return GrammarLesson.fromJson(doc.data()!);
    } catch (e) {
      print('❌ Error fetching lesson: $e');
      return null;
    }
  }

  // ==================== STREAM METHODS (Real-time Updates) ====================

  /// Stream all categories
  Stream<List<GrammarCategory>> streamCategories() {
    return _firestore
        .collection('grammar_categories')
        .orderBy('order')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GrammarCategory.fromJson(doc.data()))
            .toList());
  }

  /// Stream lessons by category
  Stream<List<GrammarLesson>> streamLessonsByCategory(String categoryId) {
    return _firestore
        .collection('grammar_lessons')
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('order')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GrammarLesson.fromJson(doc.data()))
            .toList());
  }

  // ==================== UPDATE/DELETE METHODS ====================

  /// Update a category
  Future<bool> updateCategory(GrammarCategory category) async {
    try {
      await _firestore
          .collection('grammar_categories')
          .doc(category.id)
          .update(category.toJson());
      print('✅ Updated category: ${category.title}');
      return true;
    } catch (e) {
      print('❌ Error updating category: $e');
      return false;
    }
  }

  /// Update a lesson
  Future<bool> updateLesson(GrammarLesson lesson) async {
    try {
      await _firestore
          .collection('grammar_lessons')
          .doc(lesson.id)
          .update(lesson.toJson());
      print('✅ Updated lesson: ${lesson.title}');
      return true;
    } catch (e) {
      print('❌ Error updating lesson: $e');
      return false;
    }
  }

  /// Delete a category
  Future<bool> deleteCategory(String categoryId) async {
    try {
      await _firestore
          .collection('grammar_categories')
          .doc(categoryId)
          .delete();
      print('✅ Deleted category: $categoryId');
      return true;
    } catch (e) {
      print('❌ Error deleting category: $e');
      return false;
    }
  }

  /// Delete a lesson
  Future<bool> deleteLesson(String lessonId) async {
    try {
      await _firestore
          .collection('grammar_lessons')
          .doc(lessonId)
          .delete();
      print('✅ Deleted lesson: $lessonId');
      return true;
    } catch (e) {
      print('❌ Error deleting lesson: $e');
      return false;
    }
  }

  // ==================== UTILITY METHODS ====================

  /// Check if data exists in Firebase
  Future<bool> hasData() async {
    try {
      final categoriesSnapshot = await _firestore
          .collection('grammar_categories')
          .limit(1)
          .get();
      
      return categoriesSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('❌ Error checking data: $e');
      return false;
    }
  }

  /// Clear all data (use with caution!)
  Future<bool> clearAllData() async {
    try {
      // Delete all categories
      final categoriesSnapshot = await _firestore
          .collection('grammar_categories')
          .get();
      
      final batch1 = _firestore.batch();
      for (final doc in categoriesSnapshot.docs) {
        batch1.delete(doc.reference);
      }
      await batch1.commit();

      // Delete all lessons
      final lessonsSnapshot = await _firestore
          .collection('grammar_lessons')
          .get();
      
      final batch2 = _firestore.batch();
      for (final doc in lessonsSnapshot.docs) {
        batch2.delete(doc.reference);
      }
      await batch2.commit();

      print('✅ Cleared all grammar content data');
      return true;
    } catch (e) {
      print('❌ Error clearing data: $e');
      return false;
    }
  }
}
