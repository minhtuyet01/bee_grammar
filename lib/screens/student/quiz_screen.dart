import 'package:flutter/material.dart';
import '../../data/service_locator.dart';
import '../../models/lesson.dart';
import '../../models/quiz.dart';
import '../../models/quiz_answer.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  final String attemptId;

  const QuizScreen({
    super.key,
    required this.lesson,
    required this.attemptId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Quiz> _quizzes = [];
  int _currentQuestionIndex = 0;
  final Map<String, List<String>> _selectedAnswers = {};
  final Map<String, QuizAnswer> _submittedAnswers = {};
  bool _isLoading = true;
  bool _isSubmitting = false;
  bool _showFeedback = false;

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    setState(() => _isLoading = true);

    try {
      final quizService = ServiceLocator().quizService;
      final quizzes = await quizService.getQuizzesForLesson(widget.lesson.id);

      setState(() {
        _quizzes = quizzes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.toString()}')),
        );
      }
    }
  }

  Quiz get _currentQuiz => _quizzes[_currentQuestionIndex];
  bool get _isLastQuestion => _currentQuestionIndex == _quizzes.length - 1;
  bool get _hasAnswered => _submittedAnswers.containsKey(_currentQuiz.id);

  void _toggleAnswer(String optionId) {
    if (_hasAnswered) return; // Can't change after submission

    setState(() {
      final currentAnswers = _selectedAnswers[_currentQuiz.id] ?? [];

      if (_currentQuiz.type == QuizType.multipleChoice || 
          _currentQuiz.type == QuizType.trueFalse) {
        // Single choice - replace
        _selectedAnswers[_currentQuiz.id] = [optionId];
      } else {
        // Multiple choice - toggle
        if (currentAnswers.contains(optionId)) {
          currentAnswers.remove(optionId);
        } else {
          currentAnswers.add(optionId);
        }
        _selectedAnswers[_currentQuiz.id] = currentAnswers;
      }
    });
  }

  Future<void> _submitAnswer() async {
    final selectedIds = _selectedAnswers[_currentQuiz.id] ?? [];
    
    if (selectedIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn đáp án')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final quizService = ServiceLocator().quizService;
      final answer = await quizService.submitAnswer(
        attemptId: widget.attemptId,
        quizId: _currentQuiz.id,
        selectedAnswerIds: selectedIds,
      );

      setState(() {
        _submittedAnswers[_currentQuiz.id] = answer;
        _showFeedback = true;
        _isSubmitting = false;
      });
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.toString()}')),
        );
      }
    }
  }

  void _nextQuestion() {
    if (_isLastQuestion) {
      _finishQuiz();
    } else {
      setState(() {
        _currentQuestionIndex++;
        _showFeedback = false;
      });
    }
  }

  Future<void> _finishQuiz() async {
    try {
      final quizService = ServiceLocator().quizService;
      final result = await quizService.gradeQuizAttempt(widget.attemptId);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultScreen(result: result),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Đang tải...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_quizzes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kiểm tra')),
        body: const Center(child: Text('Không có câu hỏi')),
      );
    }

    final currentAnswer = _submittedAnswers[_currentQuiz.id];
    final selectedIds = _selectedAnswers[_currentQuiz.id] ?? [];

    return WillPopScope(
      onWillPop: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thoát bài kiểm tra?'),
            content: const Text('Tiến trình của bạn sẽ bị mất.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Tiếp tục'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Thoát'),
              ),
            ],
          ),
        );
        return confirmed ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Câu ${_currentQuestionIndex + 1}/${_quizzes.length}'),
        ),
        body: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _quizzes.length,
              backgroundColor: Colors.grey[200],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question
                    Card(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(_currentQuiz.difficulty),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _currentQuiz.difficulty.displayName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _currentQuiz.questionText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Options
                    ..._currentQuiz.options.map((option) {
                      final isSelected = selectedIds.contains(option.id);
                      final isCorrect = _currentQuiz.correctAnswerIds.contains(option.id);
                      final showCorrect = _showFeedback && isCorrect;
                      final showIncorrect = _showFeedback && isSelected && !isCorrect;

                      return _OptionCard(
                        option: option,
                        isSelected: isSelected,
                        showCorrect: showCorrect,
                        showIncorrect: showIncorrect,
                        onTap: () => _toggleAnswer(option.id),
                        disabled: _hasAnswered,
                      );
                    }),

                    // Feedback section
                    if (_showFeedback && currentAnswer != null) ...[
                      const SizedBox(height: 20),
                      Card(
                        color: currentAnswer.isCorrect
                            ? Colors.green[50]
                            : Colors.red[50],
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    currentAnswer.isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: currentAnswer.isCorrect
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    currentAnswer.isCorrect
                                        ? 'Chính xác!'
                                        : 'Chưa đúng',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: currentAnswer.isCorrect
                                          ? Colors.green[900]
                                          : Colors.red[900],
                                    ),
                                  ),
                                ],
                              ),
                              if (_currentQuiz.explanation != null) ...[
                                const SizedBox(height: 12),
                                Text(
                                  _currentQuiz.explanation!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Action buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: _showFeedback
                      ? ElevatedButton(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_isLastQuestion ? 'Hoàn thành' : 'Câu tiếp theo'),
                        )
                      : ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitAnswer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Trả lời'),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return Colors.green;
      case DifficultyLevel.medium:
        return Colors.orange;
      case DifficultyLevel.hard:
        return Colors.red;
    }
  }
}

class _OptionCard extends StatelessWidget {
  final QuizOption option;
  final bool isSelected;
  final bool showCorrect;
  final bool showIncorrect;
  final VoidCallback onTap;
  final bool disabled;

  const _OptionCard({
    required this.option,
    required this.isSelected,
    required this.showCorrect,
    required this.showIncorrect,
    required this.onTap,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    Color? backgroundColor;
    Widget? leadingIcon;

    if (showCorrect) {
      borderColor = Colors.green;
      backgroundColor = Colors.green[50];
      leadingIcon = const Icon(Icons.check_circle, color: Colors.green);
    } else if (showIncorrect) {
      borderColor = Colors.red;
      backgroundColor = Colors.red[50];
      leadingIcon = const Icon(Icons.cancel, color: Colors.red);
    } else if (isSelected) {
      borderColor = Theme.of(context).colorScheme.primary;
      backgroundColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor ?? Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (leadingIcon != null) ...[
                leadingIcon,
                const SizedBox(width: 12),
              ] else ...[
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  option.text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
