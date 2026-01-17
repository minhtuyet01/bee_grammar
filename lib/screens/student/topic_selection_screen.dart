import 'package:flutter/material.dart';
import 'practice_difficulty_selection_screen.dart';

class TopicSelectionScreen extends StatelessWidget {
  const TopicSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'id': 'cat_1', 'title': '12 Thì Cơ Bản', 'icon': Icons.access_time, 'color': Colors.blue},
      {'id': 'cat_2', 'title': 'Câu Điều Kiện', 'icon': Icons.question_mark, 'color': Colors.green},
      {'id': 'cat_3', 'title': 'Câu Bị Động', 'icon': Icons.swap_horiz, 'color': Colors.orange},
      {'id': 'cat_4', 'title': 'Mệnh Đề Quan Hệ', 'icon': Icons.link, 'color': Colors.purple},
      {'id': 'cat_5', 'title': 'Câu Gián Tiếp', 'icon': Icons.chat_bubble_outline, 'color': Colors.red},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn chủ đề'),
        backgroundColor: const Color(0xFFD4A574),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (topic['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  topic['icon'] as IconData,
                  color: topic['color'] as Color,
                ),
              ),
              title: Text(
                topic['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DifficultySelectionScreen(
                      topicId: topic['id'] as String,
                      topicTitle: topic['title'] as String,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
