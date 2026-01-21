import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/mock_exam_data.dart';
import '../../data/test_service.dart';
import 'test_taking_screen.dart';

class MockExamDetailScreen extends StatefulWidget {
  final MockExam exam;

  const MockExamDetailScreen({
    super.key,
    required this.exam,
  });

  @override
  State<MockExamDetailScreen> createState() => _MockExamDetailScreenState();
}

class _MockExamDetailScreenState extends State<MockExamDetailScreen> {
  final _testService = TestService();
  List<Map<String, dynamic>> _history = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }

    final history = await _testService.getMockExamHistory(userId, widget.exam.id);
    setState(() {
      _history = history;
      _loading = false;
    });
  }

  Future<void> _startExam() async {
    final questions = await _testService.getMockExamQuestions(widget.exam.id);
    
    if (!mounted) return;

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có câu hỏi cho đề thi này')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestTakingScreen(
          testType: 'mock',
          mockExamId: widget.exam.id,
          title: widget.exam.title,
          questions: questions,
          timeLimit: widget.exam.timeLimit,
        ),
      ),
    ).then((_) => _loadHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.title),
        ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Exam Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFD4A574).withOpacity(0.1),
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.assignment,
                          size: 64,
                          color: Color(0xFFD4A574),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.exam.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.exam.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildInfoItem(
                              Icons.quiz,
                              '${widget.exam.totalQuestions} câu',
                            ),
                            _buildInfoItem(
                              Icons.timer,
                              '${widget.exam.timeLimit ~/ 60} phút',
                            ),
                            _buildInfoItem(
                              Icons.history,
                              '${_history.length} lần',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _startExam,
                            icon: const Icon(Icons.play_arrow),
                            label: Text(
                              _history.isEmpty ? 'Bắt đầu làm bài' : 'Làm lại',
                              style: const TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // History Section
                  if (_history.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.history, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Lịch sử làm bài',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        final attempt = _history[index];
                        final attemptNumber = _history.length - index;
                        final score = attempt['score'] as int;
                        final timeSpent = attempt['timeSpent'] as int;
                        final completedAt = attempt['completedAt'] as DateTime;
                        final daysSince = DateTime.now().difference(completedAt).inDays;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: score >= 80
                                    ? Colors.green.withOpacity(0.1)
                                    : score >= 60
                                        ? Colors.orange.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '#$attemptNumber',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: score >= 80
                                        ? Colors.green
                                        : score >= 60
                                            ? Colors.orange
                                            : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              '$score% • ${_formatTime(timeSpent)}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              _formatDate(daysSince),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: score >= 80
                                ? const Icon(Icons.star, color: Colors.amber)
                                : null,
                          ),
                        );
                      },
                    ),
                  ] else ...[
                    const SizedBox(height: 40),
                    Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Chưa có lịch sử làm bài',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hãy bắt đầu làm bài để xem kết quả',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFD4A574)),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatDate(int days) {
    if (days == 0) return 'Hôm nay';
    if (days == 1) return 'Hôm qua';
    if (days < 7) return '$days ngày trước';
    if (days < 30) return '${days ~/ 7} tuần trước';
    return '${days ~/ 30} tháng trước';
  }
}
