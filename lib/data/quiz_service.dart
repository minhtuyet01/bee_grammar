import '../models/quiz.dart';
import '../models/quiz_answer.dart';
import '../models/quiz_attempt.dart';

/// Abstract interface for quiz service
/// This allows for different implementations (Firebase, SQLite, Mock)
abstract class QuizService {
  /// Get all quizzes for a specific lesson
  Future<List<Quiz>> getQuizzesForLesson(String lessonId);

  /// Start a new quiz attempt for a user
  Future<QuizAttempt> startQuizAttempt(String userId, String lessonId);

  /// Submit an answer for a specific question in an attempt
  Future<QuizAnswer> submitAnswer({
    required String attemptId,
    required String quizId,
    required List<String> selectedAnswerIds,
  });

  /// Complete and grade a quiz attempt (AUTO-GRADING CORE)
  Future<QuizResult> gradeQuizAttempt(String attemptId);

  /// Get quiz history for a user
  Future<List<QuizAttempt>> getUserQuizHistory(String userId, {String? lessonId});

  /// Get detailed result for a specific attempt
  Future<QuizResult> getQuizResult(String attemptId);

  /// Get a specific quiz attempt
  Future<QuizAttempt?> getQuizAttempt(String attemptId);

  /// Get all answers for a specific attempt
  Future<List<QuizAnswer>> getAnswersForAttempt(String attemptId);

  /// Update an existing quiz attempt
  Future<void> updateQuizAttempt(QuizAttempt attempt);

  /// Abandon an in-progress attempt
  Future<void> abandonAttempt(String attemptId);
}
