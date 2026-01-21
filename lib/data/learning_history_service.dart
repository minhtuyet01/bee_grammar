import 'package:cloud_firestore/cloud_firestore.dart';

class LearningHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all unique categories from user's learning history
  Future<List<Map<String, String>>> getUserCategories(String userId) async {
    try {
      // Query all collections
      final lessons = await _firestore
          .collection('learning_history')
          .where('userId', isEqualTo: userId)
          .get();

      final practice = await _firestore
          .collection('practice_sessions')
          .where('userId', isEqualTo: userId)
          .get();

      final tests = await _firestore
          .collection('test_results')
          .where('userId', isEqualTo: userId)
          .get();

      // Extract unique categories from all sources
      final Map<String, String> categoriesMap = {};
      
      // From lessons
      for (final doc in lessons.docs) {
        final data = doc.data();
        final categoryId = data['categoryId'] as String?;
        final categoryTitle = data['categoryTitle'] as String?;
        
        if (categoryId != null && categoryTitle != null) {
          categoriesMap[categoryId] = categoryTitle;
        }
      }

      // From practice sessions
      for (final doc in practice.docs) {
        final data = doc.data();
        final categoryId = data['categoryId'] as String?;
        final categoryTitle = data['categoryTitle'] as String?;
        
        if (categoryId != null && categoryTitle != null) {
          categoriesMap[categoryId] = categoryTitle;
        }
      }

      // From tests
      for (final doc in tests.docs) {
        final data = doc.data();
        final categoryId = data['categoryId'] as String?;
        final categoryTitle = data['categoryTitle'] as String?;
        
        if (categoryId != null && categoryTitle != null) {
          categoriesMap[categoryId] = categoryTitle;
        }
      }

      // Convert to list
      return categoriesMap.entries
          .map((e) => {'id': e.key, 'title': e.value})
          .toList();
    } catch (e) {
      print('Error getting user categories: $e');
      return [];
    }
  }

  /// Save lesson completion to learning history
  Future<void> saveLessonCompletion({
    required String userId,
    required String lessonId,
    required String lessonTitle,
    required String categoryId,
    required String categoryTitle,
    required int score,
    required int correctAnswers,
    required int totalQuestions,
    required int timeSpent,
  }) async {
    try {
      final timestamp = DateTime.now();
      final docId = '${userId}_${lessonId}_${timestamp.millisecondsSinceEpoch}';

      await _firestore.collection('learning_history').doc(docId).set({
        'userId': userId,
        'lessonId': lessonId,
        'lessonTitle': lessonTitle,
        'categoryId': categoryId,
        'categoryTitle': categoryTitle,
        'completedAt': timestamp,
        'score': score,
        'correctAnswers': correctAnswers,
        'totalQuestions': totalQuestions,
        'timeSpent': timeSpent,
      });

      // Update statistics
      await updateStatistics(
        userId: userId,
        categoryId: categoryId,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
        timeSpent: timeSpent,
      );
    } catch (e) {
      print('Error saving lesson completion: $e');
      rethrow;
    }
  }

  /// Get learning history for a user
  Future<List<Map<String, dynamic>>> getLearningHistory({
    required String userId,
    String? categoryId,
    int limit = 50,
  }) async {
    try {
      Query query = _firestore
          .collection('learning_history')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(limit);

      if (categoryId != null) {
        query = query.where('categoryId', isEqualTo: categoryId);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error getting learning history: $e');
      return [];
    }
  }

  /// Stream learning history for real-time updates
  Stream<List<Map<String, dynamic>>> streamLearningHistory({
    required String userId,
    String? categoryId,
    int limit = 50,
  }) async* {
    // Stream from learning_history (lessons)
    final lessonsStream = _firestore
        .collection('learning_history')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .snapshots();

    // Stream from practice_sessions
    final practiceStream = _firestore
        .collection('practice_sessions')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .snapshots();

    // Stream from test_results (unit/level tests)
    final testStream = _firestore
        .collection('test_results')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .snapshots();

    // Stream from mock_exam_results
    final mockExamStream = _firestore
        .collection('mock_exam_results')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .snapshots();

    // Stream from random_test_results
    final randomTestStream = _firestore
        .collection('random_test_results')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .snapshots();

    // Combine all streams
    await for (final _ in lessonsStream) {
      final lessons = await _firestore
          .collection('learning_history')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(limit)
          .get();

      final practice = await _firestore
          .collection('practice_sessions')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(limit)
          .get();

      final tests = await _firestore
          .collection('test_results')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(limit)
          .get();

      final mockExams = await _firestore
          .collection('mock_exam_results')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(limit)
          .get();

      final randomTests = await _firestore
          .collection('random_test_results')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(limit)
          .get();

      // Merge all results
      final List<Map<String, dynamic>> allHistory = [];

      // Add lessons
      for (final doc in lessons.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        data['type'] = 'lesson';
        allHistory.add(data);
      }

      // Add practice sessions
      for (final doc in practice.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        data['type'] = 'practice';
        allHistory.add(data);
      }

      // Add tests
      for (final doc in tests.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        data['type'] = 'test';
        allHistory.add(data);
      }

      // Add mock exams
      for (final doc in mockExams.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        data['type'] = 'mock_exam';
        allHistory.add(data);
      }

      // Add random tests
      for (final doc in randomTests.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        data['type'] = 'random_test';
        allHistory.add(data);
      }

      // Sort by completedAt
      allHistory.sort((a, b) {
        final aTime = (a['completedAt'] as Timestamp?)?.toDate() ?? DateTime(1970);
        final bTime = (b['completedAt'] as Timestamp?)?.toDate() ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });

      // Apply category filter if needed
      var filteredHistory = allHistory;
      if (categoryId != null) {
        filteredHistory = allHistory.where((item) {
          return item['categoryId'] == categoryId;
        }).toList();
      }

      // Limit results
      if (filteredHistory.length > limit) {
        filteredHistory = filteredHistory.sublist(0, limit);
      }

      yield filteredHistory;
    }
  }

  /// Update user statistics
  Future<void> updateStatistics({
    required String userId,
    required String categoryId,
    required int correctAnswers,
    required int totalQuestions,
    required int timeSpent,
  }) async {
    try {
      final docRef = _firestore.collection('user_statistics').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) {
        // Create new statistics document
        await docRef.set({
          'totalLessonsCompleted': 1,
          'totalExercisesCompleted': totalQuestions,
          'totalCorrectAnswers': correctAnswers,
          'totalQuestions': totalQuestions,
          'averageScore': (correctAnswers / totalQuestions * 100).round(),
          'totalTimeSpent': timeSpent,
          'lastUpdated': DateTime.now(),
          'categoriesProgress': {
            categoryId: {'completed': 1}
          },
        });
      } else {
        // Update existing statistics
        final data = doc.data()!;
        final totalCorrect = (data['totalCorrectAnswers'] ?? 0) + correctAnswers;
        final totalQ = (data['totalQuestions'] ?? 0) + totalQuestions;
        final avgScore = (totalCorrect / totalQ * 100).round();

        final categoriesProgress = Map<String, dynamic>.from(data['categoriesProgress'] ?? {});
        final categoryData = Map<String, dynamic>.from(categoriesProgress[categoryId] ?? {});
        categoryData['completed'] = (categoryData['completed'] ?? 0) + 1;
        categoriesProgress[categoryId] = categoryData;

        await docRef.update({
          'totalLessonsCompleted': FieldValue.increment(1),
          'totalExercisesCompleted': FieldValue.increment(totalQuestions),
          'totalCorrectAnswers': FieldValue.increment(correctAnswers),
          'totalQuestions': FieldValue.increment(totalQuestions),
          'averageScore': avgScore,
          'totalTimeSpent': FieldValue.increment(timeSpent),
          'lastUpdated': DateTime.now(),
          'categoriesProgress': categoriesProgress,
        });
      }
    } catch (e) {
      print('Error updating statistics: $e');
      rethrow;
    }
  }

  /// Get user statistics
  Future<Map<String, dynamic>> getStatistics(String userId) async {
    try {
      final doc = await _firestore.collection('user_statistics').doc(userId).get();
      if (doc.exists) {
        return doc.data()!;
      }
      return {
        'totalLessonsCompleted': 0,
        'totalExercisesCompleted': 0,
        'totalCorrectAnswers': 0,
        'totalQuestions': 0,
        'averageScore': 0,
        'totalTimeSpent': 0,
        'categoriesProgress': {},
      };
    } catch (e) {
      print('Error getting statistics: $e');
      return {};
    }
  }

  /// Stream user statistics for real-time updates
  Stream<Map<String, dynamic>> streamStatistics(String userId) {
    return _firestore.collection('user_statistics').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return doc.data()!;
      }
      return {
        'totalLessonsCompleted': 0,
        'totalExercisesCompleted': 0,
        'totalCorrectAnswers': 0,
        'totalQuestions': 0,
        'averageScore': 0,
        'totalTimeSpent': 0,
        'categoriesProgress': {},
      };
    });
  }
}
