import 'package:flutter/material.dart';
import '../../models/test_question.dart';

class PracticeReviewScreen extends StatelessWidget {
  final List<TestQuestion> questions;
  final List<int> userAnswers;
  final String practiceTitle;

  const PracticeReviewScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
    required this.practiceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xem lại đáp án'),
        backgroundColor: const Color(0xFFD4A574),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final userAnswer = userAnswers[index];
          final isCorrect = userAnswer == question.correctAnswer;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question number and status
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isCorrect ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Câu ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isCorrect ? 'Đúng' : 'Sai',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Question text
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Options
                  ...List.generate(question.options?.length ?? 0, (optionIndex) {
                    final isUserAnswer = optionIndex == userAnswer;
                    final isCorrectAnswer = optionIndex == question.correctAnswer;
                    
                    Color? backgroundColor;
                    Color? borderColor;
                    IconData? icon;
                    
                    if (isCorrectAnswer) {
                      backgroundColor = Colors.green.withOpacity(0.1);
                      borderColor = Colors.green;
                      icon = Icons.check_circle;
                    } else if (isUserAnswer && !isCorrect) {
                      backgroundColor = Colors.red.withOpacity(0.1);
                      borderColor = Colors.red;
                      icon = Icons.cancel;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(
                          color: borderColor ?? Colors.grey.shade300,
                          width: borderColor != null ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${String.fromCharCode(65 + optionIndex)}.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: borderColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              question.options?[optionIndex] ?? '',
                              style: TextStyle(
                                color: borderColor ?? Colors.black87,
                              ),
                            ),
                          ),
                          if (icon != null)
                            Icon(
                              icon,
                              color: borderColor,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  }),

                  // Explanation
                  if (question.explanation.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.shade200,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Giải thích:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  question.explanation,
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ],
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
        },
      ),
    );
  }
}
