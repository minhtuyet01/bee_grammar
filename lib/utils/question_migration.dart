import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/question_bank.dart';
import '../data/firebase_question_service.dart';

/// Migration script to upload questions from QuestionBank to Firebase
/// Run this once to migrate existing questions
class QuestionMigration {
  final _questionService = FirebaseQuestionService();
  final _auth = FirebaseAuth.instance;

  /// Upload all questions from QuestionBank to Firebase
  Future<void> migrateQuestions() async {
    print('🚀 Starting question migration...');
    
    // Check if user is authenticated
    if (_auth.currentUser == null) {
      print('❌ Error: User not authenticated');
      print('Please login as admin first');
      return;
    }

    try {
      final questions = QuestionBank.allQuestions;
      print('📊 Found ${questions.length} questions to upload');

      // Upload in batches of 500 (Firestore batch limit)
      const batchSize = 500;
      for (var i = 0; i < questions.length; i += batchSize) {
        final end = (i + batchSize < questions.length) 
            ? i + batchSize 
            : questions.length;
        final batch = questions.sublist(i, end);
        
        print('⬆️  Uploading batch ${i ~/ batchSize + 1} (${batch.length} questions)...');
        await _questionService.batchUploadQuestions(batch);
        print('✅ Batch uploaded successfully');
      }

      print('🎉 Migration completed! Uploaded ${questions.length} questions');
      print('📋 Summary:');
      print('   - Category 1 (12 Thì): ${questions.where((q) => q.category == 'cat_1').length} questions');
      print('   - Category 2 (Điều kiện): ${questions.where((q) => q.category == 'cat_2').length} questions');
      print('   - Category 3 (Bị động): ${questions.where((q) => q.category == 'cat_3').length} questions');
      print('   - Category 4 (Quan hệ): ${questions.where((q) => q.category == 'cat_4').length} questions');
      print('   - Category 5 (Gián tiếp): ${questions.where((q) => q.category == 'cat_5').length} questions');
      
    } catch (e) {
      print('❌ Error during migration: $e');
      rethrow;
    }
  }

  /// Verify uploaded questions
  Future<void> verifyMigration() async {
    print('🔍 Verifying migration...');
    
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('isActive', isEqualTo: true)
          .get();
      
      print('✅ Found ${snapshot.docs.length} active questions in Firebase');
      
      // Count by category
      final categories = ['cat_1', 'cat_2', 'cat_3', 'cat_4', 'cat_5'];
      for (final cat in categories) {
        final count = snapshot.docs.where((doc) => doc.data()['category'] == cat).length;
        print('   - $cat: $count questions');
      }
      
      // Count by level
      final levels = ['beginner', 'intermediate', 'advanced'];
      for (final level in levels) {
        final count = snapshot.docs.where((doc) => doc.data()['level'] == level).length;
        print('   - $level: $count questions');
      }
      
    } catch (e) {
      print('❌ Error during verification: $e');
      rethrow;
    }
  }

  /// Clear all questions (use with caution!)
  Future<void> clearAllQuestions() async {
    print('⚠️  WARNING: This will delete all questions from Firebase!');
    print('Are you sure? This action cannot be undone.');
    
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('questions')
          .get();
      
      print('🗑️  Deleting ${snapshot.docs.length} questions...');
      
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      
      await batch.commit();
      print('✅ All questions deleted');
      
    } catch (e) {
      print('❌ Error during deletion: $e');
      rethrow;
    }
  }
}

/// Example usage:
/// 
/// ```dart
/// // In your app, create a debug screen or button:
/// final migration = QuestionMigration();
/// 
/// // Upload questions
/// await migration.migrateQuestions();
/// 
/// // Verify
/// await migration.verifyMigration();
/// ```
