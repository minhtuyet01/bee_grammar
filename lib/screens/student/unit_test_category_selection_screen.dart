import 'package:flutter/material.dart';
import '../../data/test_service.dart';
import 'test_taking_screen.dart';

class UnitTestCategorySelectionScreen extends StatelessWidget {
  const UnitTestCategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn chủ đề'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategoryCard(
            context,
            categoryId: 'cat_1',
            title: '12 Thì Cơ Bản',
            description: '15 câu • 20 phút',
            icon: Icons.access_time,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildCategoryCard(
            context,
            categoryId: 'cat_2',
            title: 'Câu Điều Kiện',
            description: '15 câu • 20 phút',
            icon: Icons.help_outline,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildCategoryCard(
            context,
            categoryId: 'cat_3',
            title: 'Câu Bị Động',
            description: '15 câu • 20 phút',
            icon: Icons.swap_horiz,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildCategoryCard(
            context,
            categoryId: 'cat_4',
            title: 'Mệnh Đề Quan Hệ',
            description: '15 câu • 20 phút',
            icon: Icons.link,
            color: Colors.purple,
          ),
          const SizedBox(height: 12),
          _buildCategoryCard(
            context,
            categoryId: 'cat_5',
            title: 'Câu Gián Tiếp',
            description: '15 câu • 20 phút',
            icon: Icons.chat_bubble_outline,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String categoryId,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _startUnitTest(context, categoryId, title),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startUnitTest(
    BuildContext context,
    String categoryId,
    String title,
  ) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Get questions
      final testService = TestService();
      final questions = await testService.getUnitTestQuestions(categoryId);

      if (!context.mounted) return;
      Navigator.pop(context); // Close loading

      if (questions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không tìm thấy câu hỏi')),
        );
        return;
      }

      // Navigate to test taking screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestTakingScreen(
            questions: questions,
            testTitle: title,
            testType: 'unit',
            category: categoryId,
            timeLimit: 20 * 60, // 20 minutes in seconds
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context); // Close loading
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }
}
