import 'package:flutter/material.dart';
import 'test_taking_screen.dart';
import '../../data/test_service.dart';

class RandomTestStartScreen extends StatefulWidget {
  const RandomTestStartScreen({super.key});

  @override
  State<RandomTestStartScreen> createState() => _RandomTestStartScreenState();
}

class _RandomTestStartScreenState extends State<RandomTestStartScreen> {
  bool _isChallengeMode = false;
  int _selectedTimeLimit = 20; // Default 20 minutes

  Future<void> _startTest(BuildContext context) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final testService = TestService();
    final questions = await testService.getRandomTestQuestions();

    if (!context.mounted) return;
    Navigator.pop(context); // Close loading

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có câu hỏi')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestTakingScreen(
          testType: 'random',
          title: _isChallengeMode ? 'Thử thách ngẫu nhiên' : 'Đề ngẫu nhiên',
          questions: questions,
          timeLimit: _isChallengeMode ? (_selectedTimeLimit * 60) : null, // Convert minutes to seconds
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đề ngẫu nhiên'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shuffle,
                  size: 60,
                  color: Colors.purple[700],
                ),
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Đề Ngẫu Nhiên',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Luyện tập với 20 câu hỏi ngẫu nhiên\ntừ tất cả các chủ đề và độ khó',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Features
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildFeature(Icons.quiz, '20 câu hỏi', 'Mix tất cả chủ đề'),
                    const SizedBox(height: 16),
                    _buildFeature(Icons.trending_up, 'Đa dạng', 'Tất cả độ khó'),
                    // Only show time feature in Practice Mode
                    if (!_isChallengeMode) ...[
                      const SizedBox(height: 16),
                      _buildFeature(Icons.timer_off, 'Không giới hạn', 'Luyện tập thoải mái'),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Challenge Mode Toggle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isChallengeMode ? Colors.orange[50] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isChallengeMode ? Colors.orange[200]! : Colors.blue[200]!,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isChallengeMode ? Icons.flash_on : Icons.school,
                      color: _isChallengeMode ? Colors.orange[700] : Colors.blue[700],
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isChallengeMode ? '⚡ Challenge Mode' : '📚 Practice Mode',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _isChallengeMode ? Colors.orange[900] : Colors.blue[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isChallengeMode
                                ? 'Có giới hạn thời gian, lưu điểm cao nhất'
                                : 'Không giới hạn thời gian, thoải mái luyện tập',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isChallengeMode,
                      onChanged: (value) {
                        setState(() {
                          _isChallengeMode = value;
                        });
                      },
                      activeColor: Colors.orange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Time limit selector (only show in Challenge Mode)
              if (_isChallengeMode)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.orange[700], size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Chọn thời gian:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildTimeOption(20, '20 phút'),
                          const SizedBox(width: 8),
                          _buildTimeOption(25, '25 phút'),
                          const SizedBox(width: 8),
                          _buildTimeOption(30, '30 phút'),
                        ],
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 32),

              // Start button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _startTest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isChallengeMode ? Colors.orange : Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isChallengeMode ? Icons.flash_on : Icons.play_arrow,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isChallengeMode ? 'Bắt đầu thử thách' : 'Bắt đầu luyện tập',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.purple[700]),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeOption(int minutes, String label) {
    final isSelected = _selectedTimeLimit == minutes;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTimeLimit = minutes;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange[100] : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.orange[900] : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
