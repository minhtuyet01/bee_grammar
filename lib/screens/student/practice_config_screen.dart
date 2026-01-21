import 'package:flutter/material.dart';
import 'practice_session_screen.dart';
import '../../data/practice_service.dart';

class PracticeConfigScreen extends StatefulWidget {
  final String topicId;
  final String topicTitle;

  const PracticeConfigScreen({
    super.key,
    required this.topicId,
    required this.topicTitle,
  });

  @override
  State<PracticeConfigScreen> createState() => _PracticeConfigScreenState();
}

class _PracticeConfigScreenState extends State<PracticeConfigScreen> {
  String? _selectedDifficulty;
  int? _selectedQuestionCount;

  final List<Map<String, dynamic>> _difficulties = [
    {
      'id': 'easy',
      'title': 'Dễ',
      'description': 'Câu hỏi cơ bản, phù hợp người mới',
      'icon': Icons.star_border,
      'color': Colors.green,
    },
    {
      'id': 'medium',
      'title': 'Trung bình',
      'description': 'Câu hỏi vừa phải, cần hiểu rõ',
      'icon': Icons.star_half,
      'color': Colors.orange,
    },
    {
      'id': 'hard',
      'title': 'Khó',
      'description': 'Câu hỏi nâng cao, thử thách',
      'icon': Icons.star,
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> _questionCounts = [
    {'count': 10, 'icon': Icons.timer_outlined},
    {'count': 20, 'icon': Icons.timer},
    {'count': 30, 'icon': Icons.timer_sharp},
  ];

  @override
  void initState() {
    super.initState();
    // Set default values
    _selectedDifficulty = 'easy';
    _selectedQuestionCount = 10;
  }

  /// Get time estimate based on difficulty and question count
  String _getTimeEstimate(int count, String? difficulty) {
    if (difficulty == null) return '5-10 phút';
    
    if (difficulty == 'easy') {
      switch (count) {
        case 10: return '3-5 phút';
        case 20: return '6-10 phút';
        case 30: return '10-15 phút';
        default: return '5-10 phút';
      }
    } else if (difficulty == 'medium') {
      switch (count) {
        case 10: return '5-10 phút';
        case 20: return '10-15 phút';
        case 30: return '15-20 phút';
        default: return '10-15 phút';
      }
    } else { // hard
      switch (count) {
        case 10: return '8-12 phút';
        case 20: return '15-20 phút';
        case 30: return '20-30 phút';
        default: return '15-20 phút';
      }
    }
  }

  /// Get estimated minutes for countdown timer (use max value)
  int _getEstimatedMinutes(int count, String? difficulty) {
    if (difficulty == null) return 10;
    
    if (difficulty == 'easy') {
      switch (count) {
        case 10: return 5;
        case 20: return 10;
        case 30: return 15;
        default: return 10;
      }
    } else if (difficulty == 'medium') {
      switch (count) {
        case 10: return 10;
        case 20: return 15;
        case 30: return 20;
        default: return 15;
      }
    } else { // hard
      switch (count) {
        case 10: return 12;
        case 20: return 20;
        case 30: return 30;
        default: return 20;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luyện tập: ${widget.topicTitle}'),
        ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Difficulty Section
                  _buildSectionTitle('📊 Chọn độ khó'),
                  const SizedBox(height: 12),
                  ..._difficulties.map((difficulty) => _buildDifficultyCard(difficulty)),
                  
                  const SizedBox(height: 24),
                  
                  // Question Count Section
                  _buildSectionTitle('📝 Số câu hỏi'),
                  const SizedBox(height: 12),
                  ..._questionCounts.map((item) => _buildQuestionCountCard(item)),
                  
                  const SizedBox(height: 80), // Space for button
                ],
              ),
            ),
          ),
          
          // Start Button (Fixed at bottom)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _canStart() ? _startPractice : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Bắt đầu luyện tập',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDifficultyCard(Map<String, dynamic> difficulty) {
    final isSelected = _selectedDifficulty == difficulty['id'];
    final color = difficulty['color'] as Color;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedDifficulty = difficulty['id'] as String;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  difficulty['icon'] as IconData,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      difficulty['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? color : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      difficulty['description'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: color,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCountCard(Map<String, dynamic> item) {
    final count = item['count'] as int;
    final isSelected = _selectedQuestionCount == count;
    const color = Color(0xFFD4A574);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedQuestionCount = count;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$count câu hỏi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? color : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Thời gian: ${_getTimeEstimate(count, _selectedDifficulty)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: color,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canStart() {
    return _selectedDifficulty != null && _selectedQuestionCount != null;
  }

  Future<void> _startPractice() async {
    if (!_canStart()) return;

    final practiceService = PracticeService();
    final questions = await practiceService.getTopicPracticeQuestions(
      topicId: widget.topicId,
      difficulty: _selectedDifficulty!,
      count: _selectedQuestionCount!,
    );

    if (!mounted) return;

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có câu hỏi phù hợp')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PracticeSessionScreen(
          practiceType: 'topic',
          title: widget.topicTitle,
          questions: questions as List,
          topicId: widget.topicId,
          difficulty: _selectedDifficulty!,
          estimatedMinutes: _getEstimatedMinutes(
            _selectedQuestionCount!,
            _selectedDifficulty,
          ),
        ),
      ),
    );
  }
}
