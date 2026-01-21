import 'package:flutter/material.dart';
import 'test_taking_screen.dart';
import '../../data/test_service.dart';
import '../../data/service_locator.dart';
import '../../utils/page_transitions.dart';

class TestCategorySelectionScreen extends StatefulWidget {
  const TestCategorySelectionScreen({super.key});

  @override
  State<TestCategorySelectionScreen> createState() => _TestCategorySelectionScreenState();
}

class _TestCategorySelectionScreenState extends State<TestCategorySelectionScreen> {
  final _testService = TestService();
  final Map<String, int> _questionCounts = {};
  List<Map<String, dynamic>> _categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load categories from Firebase
      final grammarService = ServiceLocator().firebaseGrammarService;
      final categories = await grammarService.getAllCategories();
      
      setState(() {
        _categories = categories;
      });

      // Load question counts for each category
      for (final category in _categories) {
        final categoryId = category['id'] as String;
        final count = await _testService.getQuestionCountByCategory(categoryId);
        _questionCounts[categoryId] = count;
      }
      
      setState(() => _loading = false);
    } catch (e) {
      print('Error loading data: $e');
      setState(() => _loading = false);
    }
  }

  // Get default icon for category (fallback if not in Firebase)
  IconData _getCategoryIcon(int index) {
    final icons = [
      Icons.access_time,
      Icons.question_mark,
      Icons.swap_horiz,
      Icons.link,
      Icons.chat_bubble_outline,
      Icons.book,
      Icons.school,
      Icons.edit,
    ];
    return icons[index % icons.length];
  }

  // Get default color for category (fallback if not in Firebase)
  Color _getCategoryColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn chủ đề'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final categoryId = category['id'] as String;
                final questionCount = _questionCounts[categoryId] ?? 0;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(index).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(index),
                        color: _getCategoryColor(index),
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
