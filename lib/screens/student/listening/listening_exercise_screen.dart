import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../models/listening_exercise.dart';
import '../../../models/listening_question.dart';
import '../../../models/listening_attempt.dart';
import '../../../data/service_locator.dart';
import 'listening_result_screen.dart';

class ListeningExerciseScreen extends StatefulWidget {
  final ListeningExercise exercise;

  const ListeningExerciseScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ListeningExerciseScreen> createState() => _ListeningExerciseScreenState();
}

class _ListeningExerciseScreenState extends State<ListeningExerciseScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Map<String, TextEditingController> _fillBlankControllers = {};
  int _currentQuestionIndex = 0;
  Map<String, String> _userAnswers = {}; // Changed to Map<String, String>
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _showTranscript = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for fill_blank questions
    for (var question in widget.exercise.questions) {
      if (question.isFillBlank()) {
        _fillBlankControllers[question.id] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _fillBlankControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  ListeningQuestion get _currentQuestion => widget.exercise.questions[_currentQuestionIndex];

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.exercise.questions.length - 1) {
      setState(() => _currentQuestionIndex++);
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() => _currentQuestionIndex--);
    }
  }

  void _submitAnswer() async {
    // Calculate score
    int correctCount = 0;
    for (var question in widget.exercise.questions) {
      final userAnswer = _userAnswers[question.id] ?? '';
      if (userAnswer.toString().trim().toLowerCase() == question.correctAnswer.trim().toLowerCase()) {
        correctCount++;
      }
    }

    // Create attempt
    final attempt = ListeningAttempt(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple ID
      exerciseId: widget.exercise.id,
      userId: 'current_user', // TODO: Get from auth service
      answers: _userAnswers, // Already Map<String, String>
      score: correctCount,
      completedAt: DateTime.now(),
    );

    // TODO: Save attempt to Firebase
    // await ServiceLocator().firebaseListeningService.saveAttempt(attempt);

    // Navigate to result screen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListeningResultScreen(
            exercise: widget.exercise,
            attempt: attempt,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (_currentQuestionIndex + 1) / widget.exercise.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.title),
        actions: [
          IconButton(
            icon: Icon(_showTranscript ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() => _showTranscript = !_showTranscript);
            },
            tooltip: _showTranscript ? 'Ẩn transcript' : 'Xem transcript',
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),

          // Audio player placeholder (simplified version)
          Container(
            padding: const EdgeInsets.all(16),
            color: isDark ? Colors.grey[900] : Colors.grey[100],
            child: Column(
              children: [
                Icon(
                  Icons.headphones,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Audio Player',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Duration: ${widget.exercise.duration}s',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                Text(
                  '(Audio player sẽ được tích hợp sau)',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500], fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          // Transcript (if shown)
          if (_showTranscript)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.article, size: 18, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        'Transcript',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.exercise.transcript,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question number
                  Text(
                    'Câu ${_currentQuestionIndex + 1}/${widget.exercise.questions.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Question text
                  Text(
                    _currentQuestion.question,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Answer options
                  _buildAnswerWidget(_currentQuestion),
                ],
              ),
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
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
                    ),
                  ),
                if (_currentQuestionIndex > 0) const SizedBox(width: 12),

                // Next/Submit button
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _currentQuestionIndex < widget.exercise.questions.length - 1
                        ? _nextQuestion
                        : _submitAnswer,
                    icon: Icon(
                      _currentQuestionIndex < widget.exercise.questions.length - 1
                          ? Icons.arrow_forward
                          : Icons.check,
                    ),
                    label: Text(
                      _currentQuestionIndex < widget.exercise.questions.length - 1
                          ? 'Tiếp theo'
                          : 'Nộp bài',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerWidget(ListeningQuestion question) {
    if (question.isMultipleChoice()) {
      return _buildMultipleChoice(question);
    } else if (question.isFillBlank()) {
      return _buildFillBlank(question);
    } else if (question.isTrueFalse()) {
      return _buildTrueFalse(question);
    }
    return const SizedBox();
  }

  Widget _buildMultipleChoice(ListeningQuestion question) {
    return Column(
      children: question.options.map((option) {
        final isSelected = _userAnswers[question.id] == option;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              setState(() => _userAnswers[question.id] = option);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFillBlank(ListeningQuestion question) {
    final controller = _fillBlankControllers[question.id]!;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Nhập câu trả lời...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
      onChanged: (value) {
        _userAnswers[question.id] = value;
      },
    );
  }

  Widget _buildTrueFalse(ListeningQuestion question) {
    return Row(
      children: [
        Expanded(
          child: _buildTrueFalseButton(question, 'True', Icons.check_circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTrueFalseButton(question, 'False', Icons.cancel),
        ),
      ],
    );
  }

  Widget _buildTrueFalseButton(ListeningQuestion question, String value, IconData icon) {
    final isSelected = _userAnswers[question.id] == value;
    final color = value == 'True' ? Colors.green : Colors.red;

    return InkWell(
      onTap: () {
        setState(() => _userAnswers[question.id] = value);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? color : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              value == 'True' ? 'Đúng' : 'Sai',
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
