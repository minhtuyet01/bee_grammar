import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/mock_exam_data.dart';
import '../../data/test_service.dart';
import 'mock_exam_detail_screen.dart';

class MockExamListScreen extends StatefulWidget {
  const MockExamListScreen({super.key});

  @override
  State<MockExamListScreen> createState() => _MockExamListScreenState();
}

class _MockExamListScreenState extends State<MockExamListScreen> {
  final _testService = TestService();
  Map<String, Map<String, dynamic>> _examStats = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadExamStats();
  }

  Future<void> _loadExamStats() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }

    final stats = <String, Map<String, dynamic>>{};
    for (final exam in MockExamData.exams) {
      final history = await _testService.getMockExamHistory(userId, exam.id);
      if (history.isNotEmpty) {
        final bestScore = history.map((h) => h['score'] as int).reduce((a, b) => a > b ? a : b);
        final latestAttempt = history.first;
        final daysSince = DateTime.now().difference(
          (latestAttempt['completedAt'] as DateTime)
        ).inDays;

        stats[exam.id] = {
          'bestScore': bestScore,
          'totalAttempts': history.length,
          'daysSinceLastAttempt': daysSince,
        };
      }
    }

    setState(() {
      _examStats = stats;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đề thi thử'),
        foregroundColor: Colors.purple,
        surfaceTintColor: Colors.purple.withOpacity(0.1),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MockExamData.exams.length,
              itemBuilder: (context, index) {
                final exam = MockExamData.exams[index];
                final stats = _examStats[exam.id];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MockExamDetailScreen(exam: exam),
                        ),
                      ).then((_) => _loadExamStats());
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4A574).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.assignment,
                                  color: Color(0xFFD4A574),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exam.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${exam.totalQuestions} câu • ${exam.timeLimit ~/ 60} phút',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 8),
                          if (stats != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatItem(
                                  Icons.emoji_events,
                                  'Điểm cao nhất',
                                  '${stats['bestScore']}%',
                                  Colors.amber,
                                ),
                                _buildStatItem(
                                  Icons.history,
                                  'Số lần làm',
                                  '${stats['totalAttempts']}',
                                  Colors.blue,
                                ),
                                _buildStatItem(
                                  Icons.access_time,
                                  'Lần cuối',
                                  _formatDaysSince(stats['daysSinceLastAttempt']),
                                  Colors.green,
                                ),
                              ],
                            ),
                          ] else ...[
                            Center(
                              child: Text(
                                'Chưa làm bài',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatDaysSince(int days) {
    if (days == 0) return 'Hôm nay';
    if (days == 1) return 'Hôm qua';
    if (days < 7) return '$days ngày';
    if (days < 30) return '${days ~/ 7} tuần';
    return '${days ~/ 30} tháng';
  }
}
