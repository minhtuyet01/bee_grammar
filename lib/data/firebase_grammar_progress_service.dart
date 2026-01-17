import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_grammar_progress.dart';
import '../models/grammar_test.dart';

/// Service for managing user's grammar learning progress in Firebase
class FirebaseGrammarProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== Get Progress ====================

  /// Get user's progress for a specific unit
  Future<UserGrammarProgress?> getUserProgress(
    String userId,
    String unitId,
  ) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .doc(unitId)
          .get();

      if (!doc.exists) {
        // Return empty progress if not found
        return UserGrammarProgress(
          userId: userId,
          unitId: unitId,
          lastAccessed: DateTime.now(),
        );
      }

      return UserGrammarProgress.fromJson({
        ...doc.data()!,
        'userId': userId,
        'unitId': unitId,
      });
    } catch (e) {
      print('Error getting user progress: $e');
      return null;
    }
  }

  /// Get all grammar progress for a user
  Future<List<UserGrammarProgress>> getAllUserProgress(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .get();

      return snapshot.docs
          .map((doc) => UserGrammarProgress.fromJson({
                ...doc.data(),
                'userId': userId,
                'unitId': doc.id,
              }))
          .toList();
    } catch (e) {
      print('Error getting all user progress: $e');
      return [];
    }
  }

  /// Stream user's progress for real-time updates
  Stream<UserGrammarProgress?> streamUserProgress(
    String userId,
    String unitId,
  ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('grammar_progress')
        .doc(unitId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        return UserGrammarProgress(
          userId: userId,
          unitId: unitId,
          lastAccessed: DateTime.now(),
        );
      }
      return UserGrammarProgress.fromJson({
        ...doc.data()!,
        'userId': userId,
        'unitId': unitId,
      });
    });
  }

  // ==================== Update Progress ====================

  /// Mark a topic as completed
  Future<bool> markTopicCompleted(
    String userId,
    String unitId,
    String topicId,
    int xpReward,
  ) async {
    try {
      final progress = await getUserProgress(userId, unitId);
      if (progress == null) return false;

      final updated = progress.markTopicCompleted(topicId);
      final updatedWithXp = updated.copyWith(
        totalXpEarned: updated.totalXpEarned + xpReward,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .doc(unitId)
          .set(updatedWithXp.toJson(), SetOptions(merge: true));

      // Also update user's total XP
      await _updateUserTotalXp(userId, xpReward);

      return true;
    } catch (e) {
      print('Error marking topic completed: $e');
      return false;
    }
  }

  /// Save exercise score
  Future<bool> saveExerciseScore(
    String userId,
    String unitId,
    String exerciseId,
    int score,
    int xpReward,
  ) async {
    try {
      final progress = await getUserProgress(userId, unitId);
      if (progress == null) return false;

      final updated = progress.saveExerciseScore(exerciseId, score, xpReward);

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .doc(unitId)
          .set(updated.toJson(), SetOptions(merge: true));

      // Update user's total XP
      await _updateUserTotalXp(userId, xpReward);

      return true;
    } catch (e) {
      print('Error saving exercise score: $e');
      return false;
    }
  }

  /// Save test result
  Future<bool> saveTestResult(
    String userId,
    String unitId,
    String testId,
    TestResult result,
    int xpReward,
  ) async {
    try {
      final progress = await getUserProgress(userId, unitId);
      if (progress == null) return false;

      final updated = progress.saveTestResult(testId, result, xpReward);

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .doc(unitId)
          .set(updated.toJson(), SetOptions(merge: true));

      // Update user's total XP if test passed
      if (result.passed) {
        await _updateUserTotalXp(userId, xpReward);
      }

      return true;
    } catch (e) {
      print('Error saving test result: $e');
      return false;
    }
  }

  // ==================== Statistics ====================

  /// Get user's overall grammar statistics
  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    try {
      final allProgress = await getAllUserProgress(userId);

      int totalTopicsCompleted = 0;
      int totalExercisesCompleted = 0;
      int totalTestsPassed = 0;
      int totalXpEarned = 0;
      double averageScore = 0.0;

      for (final progress in allProgress) {
        totalTopicsCompleted += progress.completedTopics.values
            .where((completed) => completed)
            .length;
        totalExercisesCompleted += progress.exerciseScores.length;
        totalTestsPassed += progress.testResults.values
            .where((result) => result.passed)
            .length;
        totalXpEarned += progress.totalXpEarned;
      }

      // Calculate average score across all exercises
      final allScores = allProgress
          .expand((p) => p.exerciseScores.values)
          .toList();
      if (allScores.isNotEmpty) {
        averageScore = allScores.reduce((a, b) => a + b) / allScores.length;
      }

      return {
        'totalTopicsCompleted': totalTopicsCompleted,
        'totalExercisesCompleted': totalExercisesCompleted,
        'totalTestsPassed': totalTestsPassed,
        'totalXpEarned': totalXpEarned,
        'averageScore': averageScore.round(),
      };
    } catch (e) {
      print('Error getting user statistics: $e');
      return {};
    }
  }

  /// Get weak areas (topics with low scores)
  Future<List<Map<String, dynamic>>> getWeakAreas(String userId) async {
    try {
      final allProgress = await getAllUserProgress(userId);
      final weakAreas = <Map<String, dynamic>>[];

      for (final progress in allProgress) {
        // Find exercises with score < 70%
        progress.exerciseScores.forEach((exerciseId, score) {
          if (score < 70) {
            weakAreas.add({
              'unitId': progress.unitId,
              'exerciseId': exerciseId,
              'score': score,
            });
          }
        });
      }

      // Sort by score (lowest first)
      weakAreas.sort((a, b) => (a['score'] as int).compareTo(b['score'] as int));

      return weakAreas.take(10).toList(); // Return top 10 weak areas
    } catch (e) {
      print('Error getting weak areas: $e');
      return [];
    }
  }

  // ==================== Helper Methods ====================

  /// Update user's total XP in main user document
  Future<void> _updateUserTotalXp(String userId, int xpToAdd) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'xp': FieldValue.increment(xpToAdd),
      });
    } catch (e) {
      print('Error updating user total XP: $e');
    }
  }

  /// Initialize progress for a new unit
  Future<bool> initializeUnitProgress(String userId, String unitId) async {
    try {
      final progress = UserGrammarProgress(
        userId: userId,
        unitId: unitId,
        lastAccessed: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .doc(unitId)
          .set(progress.toJson());

      return true;
    } catch (e) {
      print('Error initializing unit progress: $e');
      return false;
    }
  }

  /// Reset progress for a unit (for retaking)
  Future<bool> resetUnitProgress(String userId, String unitId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('grammar_progress')
          .doc(unitId)
          .delete();

      return true;
    } catch (e) {
      print('Error resetting unit progress: $e');
      return false;
    }
  }
}
