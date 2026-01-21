import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/test_service.dart';
import '../../models/test_question.dart';
import 'test_result_screen.dart';
import '../../utils/page_transitions.dart';

class TestTakingScreen extends StatefulWidget {
  final String testType; // 'mock' or 'random'
  final String? mockExamId; // for mock exams
  final String title;
  final List<TestQuestion> questions;
  final int? timeLimit; // null for random test

  const TestTakingScreen({
    super.key,
    required this.testType,
    this.mockExamId,
    required this.title,
    required this.questions,
    this.timeLimit,
  });

  @override
  State<TestTakingScreen> createState() => _TestTakingScreenState();
}

class _TestTakingScreenState extends State<TestTakingScreen> {
  final _testService = TestService();
  late List<TestQuestion> _questions;
  late List<int?> _userAnswers; // For multiple choice
  late List<String?> _userTextAnswers; // For fill in blank
  late List<TextEditingController> _textControllers;
  int _currentQuestionIndex = 0;
  Timer? _timer;
  int _secondsRemaining = 0;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _loadTest();
  }

  void _loadTest() {
    _questions = widget.questions;
    _userAnswers = List.filled(_questions.length, null);
    _userTextAnswers = List.filled(_questions.length, null);
    _textControllers = List.generate(
      _questions.length,
      (index) => TextEditingController(),
    );
    
    // Set time limit
    if (widget.timeLimit != null) {
      _secondsRemaining = widget.timeLimit!;
    } else {
      _secondsRemaining = 0; // No time limit for random test
    }
    
    _startTime = DateTime.now();
    
    if (_secondsRemaining > 0) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _submitTest();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _userAnswers[_currentQuestionIndex] = answerIndex;
    });
  }

  void _updateTextAnswer(String text) {
    _userTextAnswers[_currentQuestionIndex] = text.trim();
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  Future<void> _submitTest() async {
    _timer?.cancel();

    // Check for unanswered questions
    final unansweredIndices = <int>[];
    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      if (question.type == QuestionType.multipleChoice) {
        if (_userAnswers[i] == null) {
          unansweredIndices.add(i);
        }
      } else if (question.type == QuestionType.fillInBlank) {
        if (_userTextAnswers[i] == null || _userTextAnswers[i]!.trim().isEmpty) {
          unansweredIndices.add(i);
        }
      }
    }

    // Show warning if there are unanswered questions
    if (unansweredIndices.isNotEmpty) {
      final shouldContinue = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('⚠️ Còn câu chưa làm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bạn còn ${unansweredIndices.length} câu chưa trả lời:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: unansweredIndices.map((index) {
                      return Chip(
                        label: Text('Câu ${index + 1}'),
                        backgroundColor: Colors.orange.shade100,
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Bạn có muốn tiếp tục nộp bài không?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Quay lại làm tiếp'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Nộp bài luôn'),
            ),
          ],
        ),
      );

      if (shouldContinue != true) {
        _startTimer();
        return;
      }
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Nộp bài'),
        content: Text(
          'Bạn đã trả lời ${_userAnswers.where((a) => a != null).length}/${_questions.length} câu.\n\nBạn có chắc muốn nộp bài?',
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

    if (confirmed != true) {
      _startTimer();
      return;
    }

    // Calculate score
    final result = _testService.calculateScore(
      questions: _questions,
      userAnswers: _userAnswers,
      userTextAnswers: _userTextAnswers,
    );

    // Calculate time spent
    final timeSpent = _startTime != null
        ? DateTime.now().difference(_startTime!).inSeconds
        : 0;

    // Save to Firebase
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      if (widget.testType == 'mock' && widget.mockExamId != null) {
        // Save mock exam result
        await _testService.saveMockExamResult(
          userId: userId,
          mockExamId: widget.mockExamId!,
          totalQuestions: result['total'] as int,
          correctAnswers: result['correct'] as int,
          score: result['percentage'] as int,
          timeSpent: timeSpent,
          answers: result['answerDetails'],
        );
      } else if (widget.testType == 'random') {
        // Save random test result
        await _testService.saveRandomTestResult(
          userId: userId,
          totalQuestions: result['total'] as int,
          correctAnswers: result['correct'] as int,
          score: result['percentage'] as int,
          timeSpent: timeSpent,
          answers: result['answerDetails'],
        );
      } else if (widget.testType == 'unit') {
        // Save unit test result
        await _testService.saveTestResult(
          userId: userId,
          testType: 'unit',
          category: widget.title, // Category name
          totalQuestions: result['total'] as int,
          correctAnswers: result['correct'] as int,
          score: result['percentage'] as int,
          timeSpent: timeSpent,
          answers: result['answerDetails'],
        );
      } else if (widget.testType == 'level') {
        // Save level test result
        await _testService.saveTestResult(
          userId: userId,
          testType: 'level',
          level: widget.title, // Level name
          totalQuestions: result['total'] as int,
          correctAnswers: result['correct'] as int,
          score: result['percentage'] as int,
          timeSpent: timeSpent,
          answers: result['answerDetails'],
        );
      }
    }

    // Navigate to result screen
    if (mounted) {
      PageTransitions.pushReplacement(
        context,
        TestResultScreen(
          testTitle: widget.title,
          testType: widget.testType,
          mockExamId: widget.mockExamId,
          result: result,
          timeSpent: timeSpent,
          questions: _questions,
          userAnswers: _userAnswers,
          userTextAnswers: _userTextAnswers,
        ),
        type: TransitionType.fadeSlide,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final selectedAnswer = _userAnswers[_currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thoát bài kiểm tra'),
            content: const Text('Bài làm của bạn sẽ không được lưu. Bạn có chắc muốn thoát?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
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
          actions: [
            // Timer (only show if there's a time limit)
            if (_secondsRemaining > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: _secondsRemaining < 60 ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18,
                      color: _secondsRemaining < 60 ? Colors.white : Colors.black87,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _secondsRemaining < 60 ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
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
                    'Câu ${_currentQuestionIndex + 1}/${_questions.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_userAnswers.where((a) => a != null).length + _userTextAnswers.where((a) => a != null && a.isNotEmpty).length} đã trả lời',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Question and answers
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Text(
                      _questions[_currentQuestionIndex].question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Question options or fill-in-blank
                    if (_questions[_currentQuestionIndex].type == QuestionType.multipleChoice)
                      // Multiple choice options
                      ...List.generate(
                        _questions[_currentQuestionIndex].options!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () => _selectAnswer(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _userAnswers[_currentQuestionIndex] == index
                                    ? const Color(0xFFD4A574).withOpacity(0.2)
                                    : Colors.grey[100],
                                border: Border.all(
                                  color: _userAnswers[_currentQuestionIndex] == index
                                      ? const Color(0xFFD4A574)
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _userAnswers[_currentQuestionIndex] == index
                                          ? const Color(0xFFD4A574)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: _userAnswers[_currentQuestionIndex] == index
                                            ? const Color(0xFFD4A574)
                                            : Colors.grey[400]!,
                                        width: 2,
                                      ),
                                    ),
                                    child: _userAnswers[_currentQuestionIndex] == index
                                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _questions[_currentQuestionIndex].options![index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: _userAnswers[_currentQuestionIndex] == index
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      // Fill in blank
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_questions[_currentQuestionIndex].hint != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.lightbulb_outline, color: Colors.blue[700], size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Gợi ý: ${_questions[_currentQuestionIndex].hint}',
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          TextField(
                            controller: _textControllers[_currentQuestionIndex],
                            onChanged: _updateTextAnswer,
                            decoration: InputDecoration(
                              hintText: 'Nhập câu trả lời của bạn...',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFFD4A574), width: 2),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            style: const TextStyle(fontSize: 16),
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                          ),
                        ],
                      ),

                    const SizedBox(height: 32),
                  ],
                ),
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
                  // Previous button (always visible, disabled when at first question)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _currentQuestionIndex > 0 ? _previousQuestion : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Trước'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Next/Submit button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _currentQuestionIndex < _questions.length - 1
                          ? _nextQuestion
                          : _submitTest,
                      icon: Icon(
                        _currentQuestionIndex < _questions.length - 1
                            ? Icons.arrow_forward
                            : Icons.check,
                      ),
                      label: Text(
                        _currentQuestionIndex < _questions.length - 1
                            ? 'Tiếp'
                            : 'Nộp bài',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
