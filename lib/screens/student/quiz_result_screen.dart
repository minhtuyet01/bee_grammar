import 'package:flutter/material.dart';
import '../../data/service_locator.dart';
import '../../models/quiz_answer.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizResult result;

  const QuizResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final attempt = result.attempt;
    final stats = result.statistics;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Score card
            Card(
              color: attempt.isPassed
                  ? Colors.green[50]
                  : Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      attempt.isPassed
                          ? Icons.emoji_events
                          : Icons.refresh,
                      size: 64,
                      color: attempt.isPassed
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${attempt.percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: attempt.isPassed
                            ? Colors.green[900]
                            : Colors.orange[900],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      attempt.grade,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: attempt.isPassed
                            ? Colors.green[700]
                            : Colors.orange[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      attempt.isPassed
                          ? 'Chúc mừng! Bạn đã hoàn thành bài kiểm tra'
                          : 'Hãy cố gắng thêm lần sau!',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Statistics
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thống kê',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _StatRow(
                      icon: Icons.check_circle,
                      label: 'Câu đúng',
                      value: '${stats['correctAnswers']}/${stats['totalQuestions']}',
                      color: Colors.green,
                    ),
                    _StatRow(
                      icon: Icons.cancel,
                      label: 'Câu sai',
                      value: '${stats['incorrectAnswers']}',
                      color: Colors.red,
                    ),
                    _StatRow(
                      icon: Icons.star,
                      label: 'Điểm',
                      value: '${stats['totalPoints']}/${stats['maxPoints']}',
                      color: Colors.amber,
                    ),
                    _StatRow(
                      icon: Icons.timer,
                      label: 'Thời gian',
                      value: stats['formattedDuration'],
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Review answers
            Text(
              'Xem lại đáp án',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...result.answers.asMap().entries.map((entry) {
              final index = entry.key;
              final detail = entry.value;
              return _AnswerReviewCard(
                questionNumber: index + 1,
                detail: detail,
              );
            }),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Trang chủ'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Retry quiz
                      final authService = ServiceLocator().authService;
                      final quizService = ServiceLocator().quizService;
                      final user = await authService.getCurrentUser();
                      
                      if (user != null) {
                        final newAttempt = await quizService.startQuizAttempt(
                          user.id,
                          attempt.lessonId,
                        );
                        
                        if (context.mounted) {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      }
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Làm lại'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerReviewCard extends StatelessWidget {
  final int questionNumber;
  final QuizAnswerDetail detail;

  const _AnswerReviewCard({
    required this.questionNumber,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: detail.isCorrect ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Câu $questionNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  detail.isCorrect ? Icons.check_circle : Icons.cancel,
                  color: detail.isCorrect ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Question text
            Text(
              detail.question.questionText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // User's answer
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: detail.isCorrect
                    ? Colors.green[50]
                    : Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: detail.isCorrect
                      ? Colors.green[200]!
                      : Colors.red[200]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Câu trả lời của bạn:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...detail.userAnswer.selectedAnswerIds.map((id) {
                    final option = detail.question.getOptionById(id);
                    return Text(
                      '• ${option?.text ?? "Unknown"}',
                      style: const TextStyle(fontSize: 15),
                    );
                  }),
                ],
              ),
            ),

            // Correct answer (if wrong)
            if (!detail.isCorrect) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đáp án đúng:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...detail.correctAnswerIds.map((id) {
                      final option = detail.question.getOptionById(id);
                      return Text(
                        '• ${option?.text ?? "Unknown"}',
                        style: const TextStyle(fontSize: 15),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // Explanation
            if (detail.explanation != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        detail.explanation!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
