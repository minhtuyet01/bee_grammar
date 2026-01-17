import 'package:uuid/uuid.dart';
import '../models/quiz.dart';
import '../models/user.dart';
import '../data/in_memory_quiz_service.dart';

/// Demo data and usage example for the BeeGrammar Quiz System
/// This demonstrates the complete flow of the auto-grading system

class QuizSystemDemo {
  static const _uuid = Uuid();

  /// Create sample quiz data for demonstration
  static List<Quiz> createSampleQuizzes(String lessonId) {
    final now = DateTime.now();

    return [
      // Quiz 1: Simple Present Tense - Easy
      Quiz(
        id: _uuid.v4(),
        lessonId: lessonId,
        questionText: 'She _____ to school every day.',
        type: QuizType.multipleChoice,
        options: [
          QuizOption(id: 'q1_opt1', text: 'go', orderIndex: 0),
          QuizOption(id: 'q1_opt2', text: 'goes', orderIndex: 1),
          QuizOption(id: 'q1_opt3', text: 'going', orderIndex: 2),
          QuizOption(id: 'q1_opt4', text: 'gone', orderIndex: 3),
        ],
        correctAnswerIds: ['q1_opt2'],
        explanation: 'Với chủ ngữ số ít ngôi thứ 3 (she), động từ thêm "s" hoặc "es"',
        points: 1,
        orderIndex: 0,
        difficulty: DifficultyLevel.easy,
        createdAt: now,
        updatedAt: now,
      ),

      // Quiz 2: Present Continuous - Medium
      Quiz(
        id: _uuid.v4(),
        lessonId: lessonId,
        questionText: 'They _____ football right now.',
        type: QuizType.multipleChoice,
        options: [
          QuizOption(id: 'q2_opt1', text: 'play', orderIndex: 0),
          QuizOption(id: 'q2_opt2', text: 'plays', orderIndex: 1),
          QuizOption(id: 'q2_opt3', text: 'are playing', orderIndex: 2),
          QuizOption(id: 'q2_opt4', text: 'played', orderIndex: 3),
        ],
        correctAnswerIds: ['q2_opt3'],
        explanation: 'Present Continuous (am/is/are + V-ing) diễn tả hành động đang xảy ra',
        points: 1,
        orderIndex: 1,
        difficulty: DifficultyLevel.medium,
        createdAt: now,
        updatedAt: now,
      ),

      // Quiz 3: True/False - Easy
      Quiz(
        id: _uuid.v4(),
        lessonId: lessonId,
        questionText: 'The sentence "He don\'t like coffee" is grammatically correct.',
        type: QuizType.trueFalse,
        options: [
          QuizOption(id: 'q3_opt1', text: 'True', orderIndex: 0),
          QuizOption(id: 'q3_opt2', text: 'False', orderIndex: 1),
        ],
        correctAnswerIds: ['q3_opt2'],
        explanation: 'Sai! Phải là "He doesn\'t like coffee" (ngôi thứ 3 số ít dùng doesn\'t)',
        points: 1,
        orderIndex: 2,
        difficulty: DifficultyLevel.easy,
        createdAt: now,
        updatedAt: now,
      ),

      // Quiz 4: Multiple Answers - Hard
      Quiz(
        id: _uuid.v4(),
        lessonId: lessonId,
        questionText: 'Which of the following are correct uses of Present Simple? (Select all that apply)',
        type: QuizType.multipleAnswer,
        options: [
          QuizOption(id: 'q4_opt1', text: 'I goes to work', orderIndex: 0),
          QuizOption(id: 'q4_opt2', text: 'She works hard', orderIndex: 1),
          QuizOption(id: 'q4_opt3', text: 'They plays tennis', orderIndex: 2),
          QuizOption(id: 'q4_opt4', text: 'We study English', orderIndex: 3),
        ],
        correctAnswerIds: ['q4_opt2', 'q4_opt4'],
        explanation: 'Đúng: "She works" (ngôi 3 số ít + s) và "We study" (số nhiều không thêm s)',
        points: 2,
        orderIndex: 3,
        difficulty: DifficultyLevel.hard,
        createdAt: now,
        updatedAt: now,
      ),

      // Quiz 5: Fill in the blank - Medium
      Quiz(
        id: _uuid.v4(),
        lessonId: lessonId,
        questionText: 'Complete: I _____ (not/like) spicy food.',
        type: QuizType.fillInBlank,
        options: [
          QuizOption(id: 'q5_opt1', text: 'don\'t like', orderIndex: 0),
          QuizOption(id: 'q5_opt2', text: 'doesn\'t like', orderIndex: 1),
          QuizOption(id: 'q5_opt3', text: 'am not like', orderIndex: 2),
          QuizOption(id: 'q5_opt4', text: 'not like', orderIndex: 3),
        ],
        correctAnswerIds: ['q5_opt1'],
        explanation: 'Với chủ ngữ "I", dùng "don\'t" (do not) để phủ định',
        points: 1,
        orderIndex: 4,
        difficulty: DifficultyLevel.medium,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  /// Demonstrate the complete quiz flow
  static Future<void> runDemo() async {
    print('='.repeat(60));
    print('BeeGrammar Quiz System - Auto-Grading Demo');
    print('='.repeat(60));
    print('');

    // Create service
    final quizService = InMemoryQuizService(
      onProgressUpdate: (progress) {
        print('📊 Progress Updated: ${progress.status.displayName} - Best Score: ${progress.bestScore.toStringAsFixed(1)}%');
      },
    );

    // Create sample data
    const lessonId = 'lesson_present_simple';
    const userId = 'user_demo_001';

    final quizzes = createSampleQuizzes(lessonId);
    quizService.addQuizzes(quizzes);

    print('✅ Created ${quizzes.length} sample quizzes for lesson: $lessonId');
    print('');

    // Step 1: Start quiz attempt
    print('📝 Step 1: Starting quiz attempt...');
    final attempt = await quizService.startQuizAttempt(userId, lessonId);
    print('   Attempt ID: ${attempt.id}');
    print('   Total Questions: ${attempt.totalQuestions}');
    print('   Max Points: ${attempt.maxPoints}');
    print('');

    // Step 2: Submit answers (simulating user responses)
    print('📝 Step 2: Submitting answers...');
    
    // Answer 1: Correct
    await quizService.submitAnswer(
      attemptId: attempt.id,
      quizId: quizzes[0].id,
      selectedAnswerIds: ['q1_opt2'], // Correct: "goes"
    );
    print('   ✓ Question 1: Answered "goes" (Correct)');

    // Answer 2: Correct
    await quizService.submitAnswer(
      attemptId: attempt.id,
      quizId: quizzes[1].id,
      selectedAnswerIds: ['q2_opt3'], // Correct: "are playing"
    );
    print('   ✓ Question 2: Answered "are playing" (Correct)');

    // Answer 3: Incorrect
    await quizService.submitAnswer(
      attemptId: attempt.id,
      quizId: quizzes[2].id,
      selectedAnswerIds: ['q3_opt1'], // Wrong: "True"
    );
    print('   ✗ Question 3: Answered "True" (Incorrect)');

    // Answer 4: Partially correct (only selected one of two correct answers)
    await quizService.submitAnswer(
      attemptId: attempt.id,
      quizId: quizzes[3].id,
      selectedAnswerIds: ['q4_opt2'], // Partial: only "She works hard"
    );
    print('   ✗ Question 4: Selected only 1 of 2 correct answers (Incorrect)');

    // Answer 5: Correct
    await quizService.submitAnswer(
      attemptId: attempt.id,
      quizId: quizzes[4].id,
      selectedAnswerIds: ['q5_opt1'], // Correct: "don't like"
    );
    print('   ✓ Question 5: Answered "don\'t like" (Correct)');
    print('');

    // Step 3: Grade the quiz (AUTO-GRADING)
    print('🎯 Step 3: Grading quiz attempt (AUTO-GRADING)...');
    final result = await quizService.gradeQuizAttempt(attempt.id);
    print('');

    // Step 4: Display results
    print('='.repeat(60));
    print('📊 QUIZ RESULTS');
    print('='.repeat(60));
    print('');
    print('Overall Performance:');
    print('  • Total Questions: ${result.totalQuestions}');
    print('  • Correct Answers: ${result.correctAnswers}');
    print('  • Incorrect Answers: ${result.incorrectAnswers}');
    print('  • Score: ${result.attempt.totalPoints}/${result.attempt.maxPoints} points');
    print('  • Percentage: ${result.percentage.toStringAsFixed(1)}%');
    print('  • Grade: ${result.grade}');
    print('  • Status: ${result.isPassed ? "PASSED ✅" : "FAILED ❌"}');
    print('  • Duration: ${result.attempt.formattedDuration}');
    print('');

    print('Detailed Review:');
    print('-'.repeat(60));
    for (int i = 0; i < result.answers.length; i++) {
      final detail = result.answers[i];
      final icon = detail.isCorrect ? '✅' : '❌';
      
      print('');
      print('Question ${i + 1}: $icon ${detail.isCorrect ? "CORRECT" : "INCORRECT"}');
      print('  Q: ${detail.question.questionText}');
      print('  Your answer: ${detail.userAnswerTexts.join(", ")}');
      if (!detail.isCorrect) {
        print('  Correct answer: ${detail.correctAnswerTexts.join(", ")}');
      }
      if (detail.explanation != null) {
        print('  💡 ${detail.explanation}');
      }
      print('  Points: ${detail.userAnswer.pointsEarned}/${detail.question.points}');
    }
    print('');
    print('='.repeat(60));
    print('');

    // Step 5: Show statistics
    print('📈 Statistics by Difficulty:');
    final byDifficulty = result.statistics['byDifficulty'] as Map<String, dynamic>;
    for (final entry in byDifficulty.entries) {
      final stats = entry.value as Map<String, int>;
      final difficulty = entry.key;
      final correct = stats['correct']!;
      final total = stats['total']!;
      final percent = (correct / total * 100).toStringAsFixed(0);
      print('  • $difficulty: $correct/$total ($percent%)');
    }
    print('');

    // Step 6: Show learning progress
    final progress = await quizService.getLessonProgress(userId, lessonId);
    if (progress != null) {
      print('📚 Learning Progress:');
      print('  • Status: ${progress.status.displayName}');
      print('  • Attempts: ${progress.attemptCount}');
      print('  • Best Score: ${progress.bestScore.toStringAsFixed(1)}%');
      print('  • Last Attempt: ${progress.lastAttemptAt}');
    }
    print('');

    print('='.repeat(60));
    print('✨ Demo completed successfully!');
    print('='.repeat(60));
  }
}

// Extension for string repeat
extension StringRepeat on String {
  String repeat(int count) => List.filled(count, this).join();
}
