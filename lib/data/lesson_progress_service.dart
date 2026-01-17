import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_user_progress_service.dart';

class LessonProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Update theory reading progress
  Future<void> updateTheoryProgress({
    required String userId,
    required String lessonId,
    required int timeSpent,
    required bool scrolled,
  }) async {
    try {
      final docRef = _firestore.collection('lesson_progress').doc('${userId}_$lessonId');
      final doc = await docRef.get();

      final theoryRead = timeSpent >= 30 && scrolled;

      if (!doc.exists) {
        await docRef.set({
          'userId': userId,
          'lessonId': lessonId,
          'theoryRead': theoryRead,
          'theoryTimeSpent': timeSpent,
          'theoryScrolled': scrolled,
          'examplesViewed': false,
          'exercisesCompleted': false,
          'lastUpdated': DateTime.now(),
          'progressPercentage': theoryRead ? 40 : 0,
        });
      } else {
        final data = doc.data()!;
        final examplesViewed = data['examplesViewed'] ?? false;
        final exercisesCompleted = data['exercisesCompleted'] ?? false;
        final progress = _calculateProgress(theoryRead, examplesViewed, exercisesCompleted);

        await docRef.update({
          'theoryRead': theoryRead,
          'theoryTimeSpent': timeSpent,
          'theoryScrolled': scrolled,
          'lastUpdated': DateTime.now(),
          'progressPercentage': progress,
        });
      }
    } catch (e) {
      print('Error updating theory progress: $e');
    }
  }

  /// Update examples viewing progress
  Future<void> updateExamplesProgress({
    required String userId,
    required String lessonId,
  }) async {
    try {
      final docRef = _firestore.collection('lesson_progress').doc('${userId}_$lessonId');
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({
          'userId': userId,
          'lessonId': lessonId,
          'theoryRead': false,
          'theoryTimeSpent': 0,
          'theoryScrolled': false,
          'examplesViewed': true,
          'exercisesCompleted': false,
          'lastUpdated': DateTime.now(),
          'progressPercentage': 20,
        });
      } else {
        final data = doc.data()!;
        final theoryRead = data['theoryRead'] ?? false;
        final exercisesCompleted = data['exercisesCompleted'] ?? false;
        final progress = _calculateProgress(theoryRead, true, exercisesCompleted);

        await docRef.update({
          'examplesViewed': true,
          'lastUpdated': DateTime.now(),
          'progressPercentage': progress,
        });
      }
    } catch (e) {
      print('Error updating examples progress: $e');
    }
  }

  /// Update exercises completion progress
  Future<void> updateExercisesProgress({
    required String userId,
    required String lessonId,
  }) async {
    try {
      final docRef = _firestore.collection('lesson_progress').doc('${userId}_$lessonId');
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({
          'userId': userId,
          'lessonId': lessonId,
          'theoryRead': false,
          'theoryTimeSpent': 0,
          'theoryScrolled': false,
          'examplesViewed': false,
          'exercisesCompleted': true,
          'lastUpdated': DateTime.now(),
          'progressPercentage': 40,
        });
      } else {
        final data = doc.data()!;
        final theoryRead = data['theoryRead'] ?? false;
        final examplesViewed = data['examplesViewed'] ?? false;
        final progress = _calculateProgress(theoryRead, examplesViewed, true);

        await docRef.update({
          'exercisesCompleted': true,
          'lastUpdated': DateTime.now(),
          'progressPercentage': progress,
        });
      }
      
      // Update streak when exercises completed
      final progressService = FirebaseUserProgressService();
      await progressService.checkAndUpdateStreak(userId);
      
    } catch (e) {
      print('Error updating exercises progress: $e');
    }
  }

  /// Get lesson progress
  Future<Map<String, dynamic>> getLessonProgress({
    required String userId,
    required String lessonId,
  }) async {
    try {
      final doc = await _firestore
          .collection('lesson_progress')
          .doc('${userId}_$lessonId')
          .get();

      if (doc.exists) {
        return doc.data()!;
      }
      return {
        'theoryRead': false,
        'theoryTimeSpent': 0,
        'theoryScrolled': false,
        'examplesViewed': false,
        'exercisesCompleted': false,
        'progressPercentage': 0,
      };
    } catch (e) {
      print('Error getting lesson progress: $e');
      return {
        'theoryRead': false,
        'theoryTimeSpent': 0,
        'theoryScrolled': false,
        'examplesViewed': false,
        'exercisesCompleted': false,
        'progressPercentage': 0,
      };
    }
  }

  /// Stream lesson progress for real-time updates
  Stream<Map<String, dynamic>> streamLessonProgress({
    required String userId,
    required String lessonId,
  }) {
    return _firestore
        .collection('lesson_progress')
        .doc('${userId}_$lessonId')
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return doc.data()!;
      }
      return {
        'theoryRead': false,
        'theoryTimeSpent': 0,
        'theoryScrolled': false,
        'examplesViewed': false,
        'exercisesCompleted': false,
        'progressPercentage': 0,
      };
    });
  }

  /// Get progress for multiple lessons
  Future<Map<String, int>> getMultipleLessonsProgress({
    required String userId,
    required List<String> lessonIds,
  }) async {
    try {
      final Map<String, int> progressMap = {};
      
      for (final lessonId in lessonIds) {
        final doc = await _firestore
            .collection('lesson_progress')
            .doc('${userId}_$lessonId')
            .get();
        
        if (doc.exists) {
          progressMap[lessonId] = doc.data()!['progressPercentage'] ?? 0;
        } else {
          progressMap[lessonId] = 0;
        }
      }
      
      return progressMap;
    } catch (e) {
      print('Error getting multiple lessons progress: $e');
      return {};
    }
  }

  /// Calculate progress percentage
  int _calculateProgress(bool theoryRead, bool examplesViewed, bool exercisesCompleted) {
    int progress = 0;
    if (theoryRead) progress += 40;
    if (examplesViewed) progress += 20;
    if (exercisesCompleted) progress += 40;
    return progress;
  }

  /// Check if streak should be updated (30s + scroll + interaction)
  bool shouldUpdateStreak({
    required int timeSpent,
    required bool scrolled,
    required bool hasInteraction,
  }) {
    return timeSpent >= 30 && scrolled && hasInteraction;
  }
}
