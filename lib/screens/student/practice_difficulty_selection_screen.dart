import 'package:flutter/material.dart';
import 'question_count_selection_screen.dart';

class DifficultySelectionScreen extends StatelessWidget {
  final String topicId;
  final String topicTitle;

  const DifficultySelectionScreen({
    super.key,
    required this.topicId,
    required this.topicTitle,
  });

  @override
  Widget build(BuildContext context) {
    final difficulties = [
      {
        'id': 'easy',
        'title': 'Dễ',
        'description': 'Câu hỏi cơ bản, phù hợp người mới',
        'icon': Icons.star_border,
        'color': Colors.green
      },
      {
        'id': 'medium',
        'title': 'Trung bình',
        'description': 'Câu hỏi vừa phải, cần hiểu rõ',
        'icon': Icons.star_half,
        'color': Colors.orange
      },
      {
        'id': 'hard',
        'title': 'Khó',
        'description': 'Câu hỏi nâng cao, thử thách',
        'icon': Icons.star,
        'color': Colors.red
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn độ khó'),
        backgroundColor: const Color(0xFFD4A574),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: difficulties.length,
        itemBuilder: (context, index) {
          final difficulty = difficulties[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionCountSelectionScreen(
                      topicId: topicId,
                      topicTitle: topicTitle,
                      difficulty: difficulty['id'] as String,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: (difficulty['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        difficulty['icon'] as IconData,
                        size: 32,
                        color: difficulty['color'] as Color,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            difficulty['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            difficulty['description'] as String,
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
        },
      ),
    );
  }
}
