import 'package:flutter/material.dart';
import 'test_taking_screen.dart';
import '../../data/test_service.dart';

class TestLevelSelectionScreen extends StatefulWidget {
  const TestLevelSelectionScreen({super.key});

  @override
  State<TestLevelSelectionScreen> createState() => _TestLevelSelectionScreenState();
}

class _TestLevelSelectionScreenState extends State<TestLevelSelectionScreen> {
  final _testService = TestService();
  final Map<String, int> _questionCounts = {};
  bool _loading = true;

  final levels = [
    {
      'id': 'beginner',
      'title': 'Cơ bản',
      'description': 'Dành cho người mới bắt đầu',
      'icon': Icons.star_border,
      'color': Colors.green
    },
    {
      'id': 'intermediate',
      'title': 'Trung cấp',
      'description': 'Đã có kiến thức nền tảng',
      'icon': Icons.star_half,
      'color': Colors.orange
    },
    {
      'id': 'advanced',
      'title': 'Nâng cao',
      'description': 'Thành thạo ngữ pháp',
      'icon': Icons.star,
      'color': Colors.red
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadQuestionCounts();
  }

  Future<void> _loadQuestionCounts() async {
    // Use fixed counts from local question bank
    _questionCounts['beginner'] = 30;
    _questionCounts['intermediate'] = 40;
    _questionCounts['advanced'] = 50;
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn cấp độ'),
        backgroundColor: Colors.blue,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final level = levels[index];
                final levelId = level['id'] as String;
                final questionCount = _questionCounts[levelId] ?? 0;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () async {
                      if (questionCount == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Chưa có câu hỏi cho cấp độ này')),
                        );
                        return;
                      }

                      // Show loading
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator()),
                      );

                      final questions = await _testService.getLevelTestQuestions(levelId);
                      
                      if (!mounted) return;
                      Navigator.pop(context); // Close loading

                      if (questions.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Không thể tải câu hỏi')),
                        );
                        return;
                      }
                      
                      // Set time limit based on difficulty
                      int timeLimit;
                      switch (levelId) {
                        case 'beginner':
                          timeLimit = 2100; // 35 minutes
                          break;
                        case 'intermediate':
                          timeLimit = 3000; // 50 minutes
                          break;
                        case 'advanced':
                          timeLimit = 4200; // 70 minutes
                          break;
                        default:
                          timeLimit = 2100; // Default 35 minutes
                      }
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestTakingScreen(
                            testType: 'level',
                            title: 'Kiểm tra ${level['title']}',
                            questions: questions,
                            timeLimit: timeLimit,
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
                              color: (level['color'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              level['icon'] as IconData,
                              size: 32,
                              color: level['color'] as Color,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      level['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Difficulty stars
                                    ...List.generate(
                                      index + 1,
                                      (_) => Icon(
                                        Icons.star,
                                        size: 16,
                                        color: level['color'] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  level['description'] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '$questionCount câu hỏi • ${_getTimeText(levelId)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
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

  String _getTimeText(String levelId) {
    switch (levelId) {
      case 'beginner':
        return '35 phút';
      case 'intermediate':
        return '50 phút';
      case 'advanced':
        return '70 phút';
      default:
        return '35 phút';
    }
  }
}
