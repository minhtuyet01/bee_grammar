import 'package:flutter_test/flutter_test.dart';
import 'package:bee_grammar/models/quiz.dart';
import 'package:bee_grammar/models/quiz_attempt.dart';
import 'package:bee_grammar/data/in_memory_quiz_service.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Quiz Auto-Grading System Tests', () {
    late InMemoryQuizService quizService;
    const uuid = Uuid();
    const lessonId = 'test_lesson_001';
    const userId = 'test_user_001';

    setUp(() {
      quizService = InMemoryQuizService();
    });

    test('Should create quiz attempt with correct initial values', () async {
      // Arrange: Create sample quizzes
      final quizzes = _createSampleQuizzes(lessonId);
      quizService.addQuizzes(quizzes);

      // Act: Start attempt
      final attempt = await quizService.startQuizAttempt(userId, lessonId);

      // Assert
      expect(attempt.userId, userId);
      expect(attempt.lessonId, lessonId);
      expect(attempt.status, AttemptStatus.inProgress);
      expect(attempt.totalQuestions, quizzes.length);
      expect(attempt.maxPoints, quizzes.fold(0, (sum, q) => sum + q.points));
      expect(attempt.correctAnswers, 0);
      expect(attempt.totalPoints, 0);
    });

    test('Should correctly validate single correct answer', () async {
      // Arrange
      final quiz = Quiz(
        id: uuid.v4(),
        lessonId: lessonId,
        questionText: 'Test question',
        type: QuizType.multipleChoice,
        options: [
          QuizOption(id: 'opt1', text: 'Wrong', orderIndex: 0),
          QuizOption(id: 'opt2', text: 'Correct', orderIndex: 1),
        ],
        correctAnswerIds: ['opt2'],
        points: 1,
        orderIndex: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act & Assert
      expect(quiz.isCorrect(['opt2']), true);
      expect(quiz.isCorrect(['opt1']), false);
      expect(quiz.isCorrect(['opt1', 'opt2']), false); // Too many answers
    });

    test('Should correctly validate multiple correct answers', () async {
      // Arrange
      final quiz = Quiz(
        id: uuid.v4(),
        lessonId: lessonId,
        questionText: 'Test question',
        type: QuizType.multipleAnswer,
        options: [
          QuizOption(id: 'opt1', text: 'Correct 1', orderIndex: 0),
          QuizOption(id: 'opt2', text: 'Wrong', orderIndex: 1),
          QuizOption(id: 'opt3', text: 'Correct 2', orderIndex: 2),
        ],
        correctAnswerIds: ['opt1', 'opt3'],
        points: 2,
        orderIndex: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act & Assert
      expect(quiz.isCorrect(['opt1', 'opt3']), true);
      expect(quiz.isCorrect(['opt3', 'opt1']), true); // Order doesn't matter
      expect(quiz.isCorrect(['opt1']), false); // Incomplete
      expect(quiz.isCorrect(['opt1', 'opt2', 'opt3']), false); // Extra wrong answer
    });

    test('Should submit answer and calculate points correctly', () async {
      // Arrange
      final quizzes = _createSampleQuizzes(lessonId);
      quizService.addQuizzes(quizzes);
      final attempt = await quizService.startQuizAttempt(userId, lessonId);

      // Act: Submit correct answer
      final answer = await quizService.submitAnswer(
        attemptId: attempt.id,
        quizId: quizzes[0].id,
        selectedAnswerIds: quizzes[0].correctAnswerIds,
      );

      // Assert
      expect(answer.isCorrect, true);
      expect(answer.pointsEarned, quizzes[0].points);
      expect(answer.selectedAnswerIds, quizzes[0].correctAnswerIds);
    });

    test('Should grade quiz attempt correctly - all correct', () async {
      // Arrange
      final quizzes = _createSampleQuizzes(lessonId);
      quizService.addQuizzes(quizzes);
      final attempt = await quizService.startQuizAttempt(userId, lessonId);

      // Submit all correct answers
      for (final quiz in quizzes) {
        await quizService.submitAnswer(
          attemptId: attempt.id,
          quizId: quiz.id,
          selectedAnswerIds: quiz.correctAnswerIds,
        );
      }

      // Act: Grade the attempt
      final result = await quizService.gradeQuizAttempt(attempt.id);

      // Assert
      expect(result.attempt.status, AttemptStatus.completed);
      expect(result.attempt.correctAnswers, quizzes.length);
      expect(result.attempt.totalPoints, result.attempt.maxPoints);
      expect(result.percentage, 100.0);
      expect(result.isPassed, true);
      expect(result.grade, 'Xuất sắc');
    });

    test('Should grade quiz attempt correctly - mixed results', () async {
      // Arrange
      final quizzes = _createSampleQuizzes(lessonId);
      quizService.addQuizzes(quizzes);
      final attempt = await quizService.startQuizAttempt(userId, lessonId);

      // Submit mixed answers (2 correct, 1 wrong)
      await quizService.submitAnswer(
        attemptId: attempt.id,
        quizId: quizzes[0].id,
        selectedAnswerIds: quizzes[0].correctAnswerIds, // Correct
      );

      await quizService.submitAnswer(
        attemptId: attempt.id,
        quizId: quizzes[1].id,
        selectedAnswerIds: ['wrong_answer'], // Wrong
      );

      await quizService.submitAnswer(
        attemptId: attempt.id,
        quizId: quizzes[2].id,
        selectedAnswerIds: quizzes[2].correctAnswerIds, // Correct
      );

      // Act: Grade the attempt
      final result = await quizService.gradeQuizAttempt(attempt.id);

      // Assert
      expect(result.attempt.status, AttemptStatus.completed);
      expect(result.attempt.correctAnswers, 2);
      expect(result.totalQuestions, 3);
      expect(result.correctAnswers, 2);
      expect(result.incorrectAnswers, 1);
    });

    test('Should calculate percentage correctly', () async {
      // Arrange
      final attempt = QuizAttempt(
        id: uuid.v4(),
        userId: userId,
        lessonId: lessonId,
        startedAt: DateTime.now(),
        status: AttemptStatus.completed,
        totalQuestions: 10,
        correctAnswers: 8,
        totalPoints: 8,
        maxPoints: 10,
      );

      // Assert
      expect(attempt.percentage, 80.0);
      expect(attempt.grade, 'Giỏi');
      expect(attempt.isPassed, true);
    });

    test('Should update learning progress after grading', () async {
      // Arrange
      final quizzes = _createSampleQuizzes(lessonId);
      quizService.addQuizzes(quizzes);
      final attempt = await quizService.startQuizAttempt(userId, lessonId);

      // Submit all correct answers
      for (final quiz in quizzes) {
        await quizService.submitAnswer(
          attemptId: attempt.id,
          quizId: quiz.id,
          selectedAnswerIds: quiz.correctAnswerIds,
        );
      }

      // Act: Grade the attempt
      await quizService.gradeQuizAttempt(attempt.id);

      // Get progress
      final progress = await quizService.getLessonProgress(userId, lessonId);

      // Assert
      expect(progress, isNotNull);
      expect(progress!.userId, userId);
      expect(progress.lessonId, lessonId);
      expect(progress.bestScore, 100.0);
      expect(progress.attemptCount, 1);
    });

    test('Should retrieve quiz history correctly', () async {
      // Arrange
      final quizzes = _createSampleQuizzes(lessonId);
      quizService.addQuizzes(quizzes);

      // Create multiple attempts
      final attempt1 = await quizService.startQuizAttempt(userId, lessonId);
      for (final quiz in quizzes) {
        await quizService.submitAnswer(
          attemptId: attempt1.id,
          quizId: quiz.id,
          selectedAnswerIds: quiz.correctAnswerIds,
        );
      }
      await quizService.gradeQuizAttempt(attempt1.id);

      // Small delay to ensure different timestamps
      await Future.delayed(const Duration(milliseconds: 10));

      final attempt2 = await quizService.startQuizAttempt(userId, lessonId);
      for (final quiz in quizzes) {
        await quizService.submitAnswer(
          attemptId: attempt2.id,
          quizId: quiz.id,
          selectedAnswerIds: quiz.correctAnswerIds,
        );
      }
      await quizService.gradeQuizAttempt(attempt2.id);

      // Act: Get history
      final history = await quizService.getUserQuizHistory(userId);

      // Assert
      expect(history.length, 2);
      expect(history[0].startedAt.isAfter(history[1].startedAt), true); // Sorted by date desc
    });
  });
}

// Helper function to create sample quizzes
List<Quiz> _createSampleQuizzes(String lessonId) {
  const uuid = Uuid();
  final now = DateTime.now();

  return [
    Quiz(
      id: uuid.v4(),
      lessonId: lessonId,
      questionText: 'Question 1',
      type: QuizType.multipleChoice,
      options: [
        QuizOption(id: 'q1_opt1', text: 'Option 1', orderIndex: 0),
        QuizOption(id: 'q1_opt2', text: 'Option 2', orderIndex: 1),
      ],
      correctAnswerIds: ['q1_opt1'],
      points: 1,
      orderIndex: 0,
      createdAt: now,
      updatedAt: now,
    ),
    Quiz(
      id: uuid.v4(),
      lessonId: lessonId,
      questionText: 'Question 2',
      type: QuizType.multipleChoice,
      options: [
        QuizOption(id: 'q2_opt1', text: 'Option 1', orderIndex: 0),
        QuizOption(id: 'q2_opt2', text: 'Option 2', orderIndex: 1),
      ],
      correctAnswerIds: ['q2_opt2'],
      points: 1,
      orderIndex: 1,
      createdAt: now,
      updatedAt: now,
    ),
    Quiz(
      id: uuid.v4(),
      lessonId: lessonId,
      questionText: 'Question 3',
      type: QuizType.multipleAnswer,
      options: [
        QuizOption(id: 'q3_opt1', text: 'Option 1', orderIndex: 0),
        QuizOption(id: 'q3_opt2', text: 'Option 2', orderIndex: 1),
        QuizOption(id: 'q3_opt3', text: 'Option 3', orderIndex: 2),
      ],
      correctAnswerIds: ['q3_opt1', 'q3_opt3'],
      points: 2,
      orderIndex: 2,
      createdAt: now,
      updatedAt: now,
    ),
  ];
}
