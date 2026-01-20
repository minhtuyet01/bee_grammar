import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/test_service.dart';
import '../../models/test_question.dart';
import 'test_taking_screen.dart';

class LevelTestSelectionScreen extends StatefulWidget {
  const LevelTestSelectionScreen({super.key});

  @override
  State<LevelTestSelectionScreen> createState() => _LevelTestSelectionScreenState();
}

class _LevelTestSelectionScreenState extends State<LevelTestSelectionScreen> {
  final TestService _testService = TestService();
  
  // Level configurations
  final Map<String, Map<String, dynamic>> _levelConfig = {
    'beginner': {
      'title': 'Cơ Bản',
      'subtitle': 'Beginner (A1-A2)',
      'questionCount': 30,
      'duration': 35,
      'passingScore': 70,
      'color': Colors.green,
      'icon': Icons.school,
      'description': 'Kiểm tra kiến thức cơ bản về ngữ pháp tiếng Anh',
    },
    'intermediate': {
      'title': 'Trung Cấp',
      'subtitle': 'Intermediate (B1-B2)',
      'questionCount': 40,
      'duration': 50,
      'passingScore': 75,
      'color': Colors.orange,
      'icon': Icons.trending_up,
      'description': 'Kiểm tra kiến thức trung cấp và nâng cao',
    },
    'advanced': {
      'title': 'Nâng Cao',
      'subtitle': 'Advanced (B2-C1)',
      'questionCount': 50,
      'duration': 70,
      'passingScore': 80,
      'color': Colors.red,
      'icon': Icons.emoji_events,
      'description': 'Thử thách với các câu hỏi nâng cao nhất',
    },
  };

  // Load from Firebase
  Map<String, bool> _levelUnlocked = {
    'beginner': true,
    'intermediate': false,
    'advanced': false,
  };

  Map<String, int?> _levelScores = {
    'beginner': null,
    'intermediate': null,
    'advanced': null,
  };

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
  }

  Future<void> _loadUserProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _loading = false);
      return;
    }

    try {
      // Load scores and unlock status from Firebase
      final scores = await _testService.getAllLevelTestScores(user.uid);
      final unlockStatus = await _testService.getLevelUnlockStatus(user.uid);

      setState(() {
        _levelScores = {
          'beginner': scores['beginner'],
          'intermediate': scores['intermediate'],
          'advanced': scores['advanced'],
        };
        _levelUnlocked = unlockStatus;
        _loading = false;
      });
    } catch (e) {
      print('Error loading user progress: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiểm Tra Cấp Độ'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildLevelCard('beginner'),
            const SizedBox(height: 16),
            _buildLevelCard('intermediate'),
            const SizedBox(height: 16),
            _buildLevelCard('advanced'),
            const SizedBox(height: 24),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.assessment,
              size: 48,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 12),
            Text(
              'Đánh Giá Trình Độ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hoàn thành các bài kiểm tra để đánh giá trình độ của bạn',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(String level) {
    final config = _levelConfig[level]!;
    final isLocked = !_levelUnlocked[level]!;
    final score = _levelScores[level];
    final isPassed = score != null && score >= config['passingScore'];

    return Card(
      elevation: isLocked ? 2 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: isLocked ? null : () => _startTest(level),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isLocked
                ? LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade200],
                  )
                : LinearGradient(
                    colors: [
                      config['color'].withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isLocked
                            ? Colors.grey
                            : config['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isLocked ? Icons.lock : config['icon'],
                        color: isLocked ? Colors.white : config['color'],
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            config['title'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isLocked ? Colors.grey[700] : Colors.black87,
                            ),
                          ),
                          Text(
                            config['subtitle'],
                            style: TextStyle(
                              fontSize: 14,
                              color: isLocked ? Colors.grey[600] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isPassed)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '$score%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  config['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: isLocked ? Colors.grey[600] : Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildInfoChip(
                      Icons.quiz,
                      '${config['questionCount']} câu',
                      isLocked,
                    ),
                    _buildInfoChip(
                      Icons.timer,
                      '${config['duration']} phút',
                      isLocked,
                    ),
                    _buildInfoChip(
                      Icons.star,
                      'Đạt ${config['passingScore']}%',
                      isLocked,
                    ),
                  ],
                ),
                if (isLocked) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber.shade900, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _getUnlockMessage(level),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, bool isLocked) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isLocked ? Colors.grey.shade400 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLocked ? Colors.grey.shade500 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: isLocked ? Colors.grey[700] : Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isLocked ? Colors.grey[700] : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  'Hướng Dẫn',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInstructionItem('Hoàn thành từng cấp độ theo thứ tự'),
            _buildInstructionItem('Đạt điểm yêu cầu để mở khóa cấp độ tiếp theo'),
            _buildInstructionItem('Bạn có thể làm lại bài kiểm tra bất kỳ lúc nào'),
            _buildInstructionItem('Kết quả cao nhất sẽ được lưu lại'),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  String _getUnlockMessage(String level) {
    if (level == 'intermediate') {
      return 'Hoàn thành bài kiểm tra Cơ Bản với điểm ≥70% để mở khóa';
    } else if (level == 'advanced') {
      return 'Hoàn thành bài kiểm tra Trung Cấp với điểm ≥75% để mở khóa';
    }
    return '';
  }

  Future<void> _startTest(String level) async {
    final config = _levelConfig[level]!;
    
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bắt đầu kiểm tra ${config['title']}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• ${config['questionCount']} câu hỏi'),
            Text('• Thời gian: ${config['duration']} phút'),
            Text('• Điểm đạt: ${config['passingScore']}%'),
            const SizedBox(height: 12),
            Text(
              'Bạn đã sẵn sàng chưa?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: config['color'],
            ),
            child: const Text('Bắt đầu'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Load questions
    try {
      final questions = await _testService.getLevelTestQuestions(level);
      
      if (!mounted) return;
      
      // Navigate to test taking screen
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestTakingScreen(
            testType: 'level',
            title: 'Kiểm Tra ${config['title']}',
            questions: questions,
            timeLimit: config['duration'] * 60, // Convert to seconds
          ),
        ),
      );

      // Handle result and update progress
      if (result != null && mounted) {
        // TODO: Save result to database
        setState(() {
          final score = result['score'] as int;
          _levelScores[level] = score;
          
          // Unlock next level if passed
          if (score >= config['passingScore']) {
            if (level == 'beginner') {
              _levelUnlocked['intermediate'] = true;
            } else if (level == 'intermediate') {
              _levelUnlocked['advanced'] = true;
            }
          }
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: Không thể tải câu hỏi')),
      );
    }
  }
}
