import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_question_service.dart';
import 'lesson_progress_service.dart';
import 'firebase_user_progress_service.dart';
import 'practice_question_data.dart';
import '../models/test_question.dart';

class PracticeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _progressService = LessonProgressService();
  final _questionService = FirebaseQuestionService();

  /// Get daily challenge questions (10 random)
  Future<List<dynamic>> getDailyChallengeQuestions() async {
    print('📚 Loading daily challenge questions');
    final result = await PracticeQuestionData.getRandom(10);
    print('✅ Loaded ${result.length} daily challenge questions');
    return result;
  }

  /// Get topic practice questions
  Future<List<dynamic>> getTopicPracticeQuestions({
    required String topicId,
    required String difficulty,
    required int count,
  }) async {
    print('📚 Loading practice questions for topic: $topicId, difficulty: $difficulty, count: $count');
    
    // Map difficulty to level
    String level;
    switch (difficulty) {
      case 'easy':
        level = 'beginner';
        break;
      case 'medium':
        level = 'intermediate';
        break;
      case 'hard':
        level = 'advanced';
        break;
      default:
        level = 'intermediate';
    }
    
    // Fetch from Firebase with cache
    final questions = await PracticeQuestionData.getRandomByCategoryAndLevel(
      topicId,
      level,
      count,
    );
    
    print('✅ Loaded ${questions.length} questions');
    return questions;
  }

  /// Get mixed review questions from learned topics
  Future<List<dynamic>> getMixedReviewQuestions({
    required String userId,
    required int count,
  }) async {
    // Get user's learned topics (topics with progress > 0)
    final learnedTopics = await _getLearnedTopics(userId);
    
    if (learnedTopics.isEmpty) {
      // If no learned topics, return random questions from all categories
      final allQuestions = await _questionService.getAllQuestions();
      allQuestions.shuffle();
      return allQuestions.take(count).toList();
    }

    // Get questions from learned topics
    List<dynamic> allQuestions = [];
    for (final topicId in learnedTopics) {
      final topicQuestions = await _questionService.getByCategory(topicId);
      allQuestions.addAll(topicQuestions);
    }
    
    allQuestions.shuffle();
    return allQuestions.take(count).toList();
  }

  /// Get weak points practice questions
  Future<List<dynamic>> getWeakPointsQuestions({
    required String userId,
    required int count,
  }) async {
    // Analyze weak topics
    final weakTopics = await analyzeWeakTopics(userId);
    
    if (weakTopics.isEmpty) {
      // If no weak topics, return random questions
      final allQuestions = await _questionService.getAllQuestions();
      allQuestions.shuffle();
      return allQuestions.take(count).toList();
    }

    // Get questions from weak topics
    List<dynamic> allQuestions = [];
    for (final topicId in weakTopics) {
      final topicQuestions = await _questionService.getByCategory(topicId);
      allQuestions.addAll(topicQuestions);
    }
    
    allQuestions.shuffle();
    return allQuestions.take(count).toList();
  }

  /// Calculate practice score
  Map<String, dynamic> calculateScore({
    required List<dynamic> questions,
    required List<dynamic> userAnswers,  // Changed from List<int?>
  }) {
    int correct = 0;
    List<Map<String, dynamic>> answerDetails = [];

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final userAnswer = userAnswers[i];
      
      bool isCorrect = false;
      dynamic correctAnswer;

      // Check answer based on question type
      if (question.type == QuestionType.multipleChoice) {
        correctAnswer = question.correctAnswer ?? 0;
        isCorrect = userAnswer == correctAnswer;
      } else if (question.type == QuestionType.fillInBlank) {
        correctAnswer = question.correctAnswerText ?? '';
        final userText = (userAnswer as String?)?.toLowerCase().trim() ?? '';
        final correctText = correctAnswer.toLowerCase().trim();
        isCorrect = userText == correctText;
      } else if (question.type == QuestionType.errorCorrection) {
        if (userAnswer is Map) {
          final userPosition = userAnswer['position'];
          final userCorrection = (userAnswer['correction'] as String?)?.toLowerCase().trim() ?? '';
          final correctPosition = question.errorPosition;
          final correctWord = (question.correctedWord ?? '').toLowerCase().trim();
          isCorrect = userPosition == correctPosition && userCorrection == correctWord;
          correctAnswer = {'position': correctPosition, 'word': question.correctedWord};
        } else {
          isCorrect = false;
          correctAnswer = {'position': question.errorPosition, 'word': question.correctedWord};
        }
      }

      if (isCorrect) correct++;

      answerDetails.add({
        'questionId': question.id ?? '',
        'topicId': question.category ?? '',
        'selectedAnswer': userAnswer,
        'correctAnswer': correctAnswer,
        'isCorrect': isCorrect,
      });
    }

    final percentage = ((correct / questions.length) * 100).round();

    return {
      'totalQuestions': questions.length,
      'correctAnswers': correct,
      'wrongAnswers': questions.length - correct,
      'score': percentage,
      'answerDetails': answerDetails,
    };
  }

  /// Save practice session to Firebase
  Future<void> savePracticeSession({
    required String userId,
    required String practiceType,
    required String practiceTitle,
    String? topicId,
    String? difficulty,
    required int totalQuestions,
    required int correctAnswers,
    required int score,
    required int timeSpent,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final timestamp = DateTime.now();
      final docId = 'practice_${timestamp.millisecondsSinceEpoch}';

      await _firestore.collection('practice_sessions').doc(docId).set({
        'userId': userId,
        'practiceType': practiceType,
        'practiceTitle': practiceTitle,
        'topicId': topicId,
        'difficulty': difficulty,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'score': score,
        'timeSpent': timeSpent,
        'completedAt': timestamp,
        'answers': answers,
      });

      // Update practice stats
      await _updatePracticeStats(userId, practiceType, answers);
      
      // Update streak
      final progressService = FirebaseUserProgressService();
      await progressService.checkAndUpdateStreak(userId);

      print('✅ Practice session saved: $docId');
    } catch (e) {
      print('Error saving practice session: $e');
      rethrow;
    }
  }

  /// Check if daily challenge completed today
  Future<bool> isDailyChallengeCompletedToday(String userId) async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);

      final snapshot = await _firestore
          .collection('practice_sessions')
          .where('userId', isEqualTo: userId)
          .where('practiceType', isEqualTo: 'daily')
          .where('completedAt', isGreaterThanOrEqualTo: startOfDay)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking daily challenge: $e');
      return false;
    }
  }

  /// Get learned topics (topics with progress > 0)
  Future<List<String>> _getLearnedTopics(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('lesson_progress')
          .where('userId', isEqualTo: userId)
          .where('progress', isGreaterThan: 0)
          .get();

      final topics = <String>{};
      for (final doc in snapshot.docs) {
        final categoryId = doc.data()['categoryId'] as String?;
        if (categoryId != null) {
          topics.add(categoryId);
        }
      }

      return topics.toList();
    } catch (e) {
      print('Error getting learned topics: $e');
      return [];
    }
  }

  /// Analyze weak topics (accuracy < 60%)
  Future<List<String>> analyzeWeakTopics(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('practice_sessions')
          .where('userId', isEqualTo: userId)
          .orderBy('completedAt', descending: true)
          .limit(50)
          .get();

      // Calculate accuracy per topic
      final Map<String, List<bool>> topicResults = {};

      for (final doc in snapshot.docs) {
        final answers = doc.data()['answers'] as List<dynamic>;
        for (final answer in answers) {
          final topicId = answer['topicId'] as String;
          final isCorrect = answer['isCorrect'] as bool;

          if (!topicResults.containsKey(topicId)) {
            topicResults[topicId] = [];
          }
          topicResults[topicId]!.add(isCorrect);
        }
      }

      // Find topics with accuracy < 60%
      final weakTopics = <String>[];
      topicResults.forEach((topicId, results) {
        final correct = results.where((r) => r).length;
        final accuracy = correct / results.length;
        if (accuracy < 0.6) {
          weakTopics.add(topicId);
        }
      });

      return weakTopics;
    } catch (e) {
      print('Error analyzing weak topics: $e');
      return [];
    }
  }

  /// Update practice statistics
  Future<void> _updatePracticeStats(
    String userId,
    String practiceType,
    List<Map<String, dynamic>> answers,
  ) async {
    try {
      final docRef = _firestore.collection('user_practice_stats').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) {
        // Create new stats
        await docRef.set({
          'userId': userId,
          'totalSessions': 1,
          'dailyChallengeStreak': practiceType == 'daily' ? 1 : 0,
          'lastDailyChallengeDate': practiceType == 'daily'
              ? DateTime.now().toIso8601String().split('T')[0]
              : null,
          'topicAccuracy': {},
          'weakTopics': [],
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Update existing stats
        final data = doc.data()!;
        final totalSessions = (data['totalSessions'] ?? 0) + 1;

        // Update daily challenge streak
        int streak = data['dailyChallengeStreak'] ?? 0;
        if (practiceType == 'daily') {
          final lastDate = data['lastDailyChallengeDate'] as String?;
          final today = DateTime.now().toIso8601String().split('T')[0];
          
          if (lastDate == null) {
            streak = 1;
          } else {
            final last = DateTime.parse(lastDate);
            final now = DateTime.now();
            final diff = now.difference(last).inDays;
            
            if (diff == 1) {
              streak++;
            } else if (diff > 1) {
              streak = 1;
            }
          }
        }

        await docRef.update({
          'totalSessions': totalSessions,
          'dailyChallengeStreak': streak,
          'lastDailyChallengeDate': practiceType == 'daily'
              ? DateTime.now().toIso8601String().split('T')[0]
              : data['lastDailyChallengeDate'],
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating practice stats: $e');
    }
  }

  /// Get practice statistics
  Future<Map<String, dynamic>> getPracticeStats(String userId) async {
    try {
      final doc = await _firestore
          .collection('user_practice_stats')
          .doc(userId)
          .get();

      if (!doc.exists) {
        return {
          'totalSessions': 0,
          'dailyChallengeStreak': 0,
          'weakTopics': [],
        };
      }

      return doc.data()!;
    } catch (e) {
      print('Error getting practice stats: $e');
      return {
        'totalSessions': 0,
        'dailyChallengeStreak': 0,
        'weakTopics': [],
      };
    }
  }
}
