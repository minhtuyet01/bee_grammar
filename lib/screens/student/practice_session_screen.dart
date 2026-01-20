import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/practice_service.dart';
import '../../models/test_question.dart';
import 'practice_result_screen.dart';

class PracticeSessionScreen extends StatefulWidget {
  final String practiceType;
  final String title;
  final List<dynamic> questions;
  final String? topicId;
  final String? difficulty;
  final int? estimatedMinutes;  // Thời gian ước tính (phút)

  const PracticeSessionScreen({
    super.key,
    required this.practiceType,
    required this.title,
    required this.questions,
    this.topicId,
    this.difficulty,
    this.estimatedMinutes,
  });

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> {
  final _practiceService = PracticeService();
  late List<dynamic> _userAnswers;  // Hỗ trợ nhiều loại: int (MC), String (Fill), Map (Error)
  int _currentQuestionIndex = 0;
  DateTime? _startTime;
  Timer? _timer;
  late int _remainingSeconds;  // Thời gian còn lại (giây)

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(widget.questions.length, null);
    _startTime = DateTime.now();
    
    // Tính thời gian countdown dựa trên số câu và độ khó
    _remainingSeconds = _calculateEstimatedTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _calculateEstimatedTime() {
    // Nếu có estimatedMinutes từ config, dùng nó
    if (widget.estimatedMinutes != null) {
      return widget.estimatedMinutes! * 60;
    }
    
    // Nếu không, tính dựa trên số câu và độ khó
    final questionCount = widget.questions.length;
    final difficulty = widget.difficulty ?? 'medium';
    
    int secondsPerQuestion;
    if (difficulty == 'easy') {
      secondsPerQuestion = 30;  // 30 giây/câu
    } else if (difficulty == 'hard') {
      secondsPerQuestion = 70;  // 70 giây/câu
    } else {
      secondsPerQuestion = 50;  // 50 giây/câu (medium)
    }
    
    return questionCount * secondsPerQuestion;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            // Hết giờ - tự động nộp bài
            timer.cancel();
            _submitPractice();
          }
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  bool _isTimeRunningLow() {
    return _remainingSeconds <= 60;  // Còn 1 phút
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _userAnswers[_currentQuestionIndex] = answerIndex;
    });
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  Future<void> _submitPractice() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Nộp bài'),
        content: Text(
          'Bạn đã trả lời ${_userAnswers.where((a) => a != null).length}/${widget.questions.length} câu.\n\nBạn có chắc muốn nộp bài?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Nộp bài'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Calculate score
    final result = _practiceService.calculateScore(
      questions: widget.questions,
      userAnswers: _userAnswers,
    );

    // Calculate time spent
    final timeSpent = _startTime != null
        ? DateTime.now().difference(_startTime!).inSeconds
        : 0;

    // Save to Firebase
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _practiceService.savePracticeSession(
        userId: userId,
        practiceType: widget.practiceType,
        topicId: widget.topicId,
        difficulty: widget.difficulty,
        totalQuestions: result['totalQuestions'],
        correctAnswers: result['correctAnswers'],
        score: result['score'],
        timeSpent: timeSpent,
        answers: result['answerDetails'],
      );
    }

    // Navigate to result screen
    if (mounted) {
      try {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PracticeResultScreen(
              practiceTitle: widget.title,
              result: result,
              timeSpent: timeSpent,
              questions: widget.questions.cast<TestQuestion>(),
              userAnswers: _userAnswers.cast<int>(),
            ),
          ),
        );
      } catch (e) {
        print('Error navigating to result: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra khi hiển thị kết quả')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    final selectedAnswer = _userAnswers[_currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thoát luyện tập'),
            content: const Text('Bài làm của bạn sẽ không được lưu. Bạn có chắc muốn thoát?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Thoát'),
              ),
            ],
          ),
        );
        return confirmed ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xFFD4A574),
        ),
        body: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / widget.questions.length,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4A574)),
              minHeight: 4,
            ),

            // Question counter
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Câu ${_currentQuestionIndex + 1}/${widget.questions.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 18,
                        color: _isTimeRunningLow() ? Colors.red : Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isTimeRunningLow() ? Colors.red : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Question and answers
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _buildQuestionContent(question, selectedAnswer),
              ),
            ),

            // Navigation buttons
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
              child: Row(
                children: [
                  // Previous button
                  if (_currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _previousQuestion,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Trước'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  if (_currentQuestionIndex > 0) const SizedBox(width: 12),

                  // Next/Submit button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _currentQuestionIndex < widget.questions.length - 1
                          ? _nextQuestion
                          : _submitPractice,
                      icon: Icon(
                        _currentQuestionIndex < widget.questions.length - 1
                            ? Icons.arrow_forward
                            : Icons.check,
                      ),
                      label: Text(
                        _currentQuestionIndex < widget.questions.length - 1
                            ? 'Tiếp'
                            : 'Nộp bài',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A574),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build question content based on type
  Widget _buildQuestionContent(dynamic question, dynamic selectedAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question text
        Text(
          question.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Type-specific content
        if (question.type == QuestionType.multipleChoice)
          _buildMultipleChoiceOptions(question, selectedAnswer)
        else if (question.type == QuestionType.fillInBlank)
          _buildFillInBlankInput(question, selectedAnswer)
        else if (question.type == QuestionType.errorCorrection)
          _buildErrorCorrectionInput(question, selectedAnswer),
      ],
    );
  }

  // Multiple Choice UI
  Widget _buildMultipleChoiceOptions(dynamic question, dynamic selectedAnswer) {
    return Column(
      children: List.generate(question.options.length, (index) {
        final option = question.options[index];
        final isSelected = selectedAnswer == index;
        final optionLabel = String.fromCharCode(65 + index); // A, B, C, D

        return GestureDetector(
          onTap: () => _selectAnswer(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFD4A574).withOpacity(0.1)
                  : Colors.white,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFD4A574)
                    : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFD4A574)
                        : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      optionLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFFD4A574),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Fill in Blank UI
  Widget _buildFillInBlankInput(dynamic question, dynamic selectedAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.hint != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Gợi ý: ${question.hint}',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        TextFormField(
          key: ValueKey('fill_${_currentQuestionIndex}'),
          initialValue: selectedAnswer is String ? selectedAnswer : '',
          decoration: InputDecoration(
            hintText: 'Nhập đáp án của bạn...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD4A574), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          onChanged: (value) {
            _userAnswers[_currentQuestionIndex] = value;
          },
        ),
      ],
    );
  }

  // Error Correction UI
  Widget _buildErrorCorrectionInput(dynamic question, dynamic selectedAnswer) {
    final words = question.incorrectSentence!.split(' ');
    final selectedData = selectedAnswer is Map ? selectedAnswer : null;
    final selectedPosition = selectedData?['position'];
    final correctionText = selectedData?['correction'] ?? '';

    final controller = TextEditingController(text: correctionText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.orange.shade700, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Tap vào từ sai, sau đó nhập từ đúng',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Câu có lỗi:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: words.asMap().entries.map<Widget>((entry) {
            final idx = entry.key;
            final word = entry.value;
            final isSelected = selectedPosition == idx;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _userAnswers[_currentQuestionIndex] = {
                    'position': idx,
                    'correction': correctionText,
                  };
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.red.shade100
                      : Colors.grey.shade200,
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  word,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.red.shade900 : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (selectedPosition != null) ...[
          const SizedBox(height: 16),
          Text(
            'Sửa thành:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: ValueKey('error_${_currentQuestionIndex}_$selectedPosition'),
            initialValue: correctionText,
            decoration: InputDecoration(
              hintText: 'Nhập từ đúng...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD4A574), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) {
              _userAnswers[_currentQuestionIndex] = {
                'position': selectedPosition,
                'correction': value,
              };
            },
          ),
        ],
      ],
    );
  }
}
