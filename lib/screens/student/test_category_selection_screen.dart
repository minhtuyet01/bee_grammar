import 'package:flutter/material.dart';
import 'test_taking_screen.dart';
import '../../data/test_service.dart';
import '../../utils/page_transitions.dart';

class TestCategorySelectionScreen extends StatefulWidget {
  const TestCategorySelectionScreen({super.key});

  @override
  State<TestCategorySelectionScreen> createState() => _TestCategorySelectionScreenState();
}

class _TestCategorySelectionScreenState extends State<TestCategorySelectionScreen> {
  final _testService = TestService();
  final Map<String, int> _questionCounts = {};
  bool _loading = true;

  final categories = [
    {'id': 'cat_1', 'title': '12 Thì Cơ Bản', 'icon': Icons.access_time, 'color': Colors.blue},
    {'id': 'cat_2', 'title': 'Câu Điều Kiện', 'icon': Icons.question_mark, 'color': Colors.green},
    {'id': 'cat_3', 'title': 'Câu Bị Động', 'icon': Icons.swap_horiz, 'color': Colors.orange},
    {'id': 'cat_4', 'title': 'Mệnh Đề Quan Hệ', 'icon': Icons.link, 'color': Colors.purple},
    {'id': 'cat_5', 'title': 'Câu Gián Tiếp', 'icon': Icons.chat_bubble_outline, 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    _loadQuestionCounts();
  }

  Future<void> _loadQuestionCounts() async {
    for (final category in categories) {
      final categoryId = category['id'] as String;
      final count = await _testService.getQuestionCountByCategory(categoryId);
      _questionCounts[categoryId] = count;
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn chủ đề'),
        backgroundColor: const Color(0xFFD4A574),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final categoryId = category['id'] as String;
                final questionCount = _questionCounts[categoryId] ?? 0;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (category['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        category['icon'] as IconData,
                        color: category['color'] as Color,
                      ),
                    ),
                    title: Text(
                      category['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('15 câu • 20 phút'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () async {
                      if (questionCount == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Chưa có câu hỏi cho chủ đề này')),
                        );
                        return;
                      }

                      // Show loading
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator()),
                      );

                      final questions = await _testService.getUnitTestQuestions(categoryId);
                      
                      if (!mounted) return;
                      Navigator.pop(context); // Close loading

                      if (questions.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Không thể tải câu hỏi')),
                        );
                        return;
                      }
                      
                      PageTransitions.push(
                        context,
                        TestTakingScreen(
                          testType: 'unit',
                          title: category['title'] as String,
                          questions: questions,
                          timeLimit: 1200, // 20 minutes
                        ),
                        type: TransitionType.slideUp,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
