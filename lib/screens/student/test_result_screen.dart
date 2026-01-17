import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/test_service.dart';

class TestResultScreen extends StatefulWidget {
  final String testTitle;
  final String testType;
  final String? mockExamId;
  final Map<String, dynamic> result;
  final int timeSpent;

  const TestResultScreen({
    super.key,
    required this.testTitle,
    required this.testType,
    this.mockExamId,
    required this.result,
    required this.timeSpent,
  });

  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  int? _attemptNumber;
  int? _bestScore;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.testType == 'mock' && widget.mockExamId != null) {
      _loadMockExamStats();
    } else {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadMockExamStats() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }

    final testService = TestService();
    final history = await testService.getMockExamHistory(userId, widget.mockExamId!);
    
    if (history.isNotEmpty) {
      final scores = history.map((h) => h['score'] as int).toList();
      setState(() {
        _attemptNumber = history.first['attemptNumber'] as int;
        _bestScore = scores.reduce((a, b) => a > b ? a : b);
        _loading = false;
      });
    } else {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = widget.result['totalQuestions'] as int;
    final correctAnswers = widget.result['correctAnswers'] as int;
    final score = widget.result['score'] as int;
    final passed = widget.result['passed'] as bool;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
        backgroundColor: const Color(0xFFD4A574),
        automaticallyImplyLeading: false,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Result icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: passed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      passed ? Icons.check_circle : Icons.info,
                      size: 64,
                      color: passed ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Status text
                  Text(
                    passed ? 'Xuất sắc!' : 'Cần cố gắng thêm',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: passed ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.testTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  // Mock exam attempt info
                  if (widget.testType == 'mock' && _attemptNumber != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.history, size: 16, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Lần làm: #$_attemptNumber',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                          if (_bestScore != null && score == _bestScore) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const Text(
                              'Cao nhất',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),

                  // Score card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                icon: Icons.check_circle,
                                label: 'Đúng',
                                value: '$correctAnswers',
                                color: Colors.green,
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.grey[300],
                              ),
                              _buildStatItem(
                                icon: Icons.cancel,
                                label: 'Sai',
                                value: '${totalQuestions - correctAnswers}',
                                color: Colors.red,
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.grey[300],
                              ),
                              _buildStatItem(
                                icon: Icons.access_time,
                                label: 'Thời gian',
                                value: _formatTime(widget.timeSpent),
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            '$correctAnswers/$totalQuestions câu',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Điểm: $score%',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (_bestScore != null && widget.testType == 'mock') ...[
                            const SizedBox(height: 12),
                            Text(
                              'Điểm cao nhất: $_bestScore%',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Pass/Fail message
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: passed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: passed ? Colors.green : Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          passed ? Icons.emoji_events : Icons.lightbulb_outline,
                          color: passed ? Colors.green : Colors.orange,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            passed
                                ? 'Chúc mừng! Bạn đã vượt qua bài kiểm tra.'
                                : 'Hãy ôn tập thêm và thử lại nhé!',
                            style: TextStyle(
                              fontSize: 14,
                              color: passed ? Colors.green[800] : Colors.orange[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                // Action buttons in a row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('Về trang chủ'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFD4A574)),
                          foregroundColor: const Color(0xFFD4A574),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Quay lại'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFD4A574),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) {
      return '${minutes}p ${secs}s';
    }
    return '${secs}s';
  }
}
