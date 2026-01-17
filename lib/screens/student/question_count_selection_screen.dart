import 'package:flutter/material.dart';
import '../../data/practice_service.dart';
import 'practice_session_screen.dart';

class QuestionCountSelectionScreen extends StatelessWidget {
  final String topicId;
  final String topicTitle;
  final String difficulty;

  const QuestionCountSelectionScreen({
    super.key,
    required this.topicId,
    required this.topicTitle,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    final counts = [
      {'count': 10, 'time': '5-10 phút', 'icon': Icons.timer_outlined},
      {'count': 20, 'time': '10-15 phút', 'icon': Icons.timer},
      {'count': 30, 'time': '15-20 phút', 'icon': Icons.timer_sharp},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Số câu hỏi'),
        backgroundColor: const Color(0xFFD4A574),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topicTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Độ khó: ${_getDifficultyLabel(difficulty)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ...counts.map((item) {
              final count = item['count'] as int;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _startPractice(context, count),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A574).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: const Color(0xFFD4A574),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$count câu hỏi',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Thời gian: ${item['time']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getDifficultyLabel(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return 'Dễ';
      case 'medium':
        return 'Trung bình';
      case 'hard':
        return 'Khó';
      default:
        return difficulty;
    }
  }

  Future<void> _startPractice(BuildContext context, int count) async {
    final practiceService = PracticeService();
    final questions = await practiceService.getTopicPracticeQuestions(
      topicId: topicId,
      difficulty: difficulty,
      count: count,
    );

    if (!context.mounted) return;

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có câu hỏi phù hợp')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PracticeSessionScreen(
          practiceType: 'topic',
          title: topicTitle,
          questions: questions as List,
          topicId: topicId,
          difficulty: difficulty,
        ),
      ),
    );
  }
}
