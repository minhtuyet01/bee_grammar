import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../models/grammar_exercise.dart';
import '../../data/firebase_grammar_progress_service.dart';

class GrammarExerciseScreen extends StatefulWidget {
  final List<GrammarExercise> exercises;
  final int initialIndex;
  final String unitId;

  const GrammarExerciseScreen({
    super.key,
    required this.exercises,
    this.initialIndex = 0,
    required this.unitId,
  });

  @override
  State<GrammarExerciseScreen> createState() => _GrammarExerciseScreenState();
}

class _GrammarExerciseScreenState extends State<GrammarExerciseScreen> {
  late int _currentIndex;
  late PageController _pageController;
  final _progressService = FirebaseGrammarProgressService();
  
  final Map<int, String> _userAnswers = {};
  final Map<int, bool> _checkedAnswers = {};
  int _totalXpEarned = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercises[_currentIndex];
    final progress = (_currentIndex + 1) / widget.exercises.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise ${_currentIndex + 1}/${widget.exercises.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        itemCount: widget.exercises.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          return _buildExercisePage(widget.exercises[index], index);
        },
      ),
    );
  }

  Widget _buildExercisePage(GrammarExercise exercise, int index) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Exercise type badge
          _buildExerciseTypeBadge(exercise),
          const SizedBox(height: 24),

          // Question
          _buildQuestion(exercise),
          const SizedBox(height: 24),

          // Answer input based on type
          _buildAnswerInput(exercise, index),
          const SizedBox(height: 24),

          // Feedback (shown after checking)
          if (_checkedAnswers[index] != null)
            _buildFeedback(exercise, index),

          const SizedBox(height: 24),

          // Action buttons
          _buildActionButtons(exercise, index),
        ],
      ),
    );
  }

  Widget _buildExerciseTypeBadge(GrammarExercise exercise) {
    final typeInfo = _getExerciseTypeInfo(exercise.type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: typeInfo['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(typeInfo['icon'], size: 16, color: typeInfo['color']),
          const SizedBox(width: 6),
          Text(
            typeInfo['label'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: typeInfo['color'],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(GrammarExercise exercise) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Question',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              exercise.question,
              style: const TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerInput(GrammarExercise exercise, int index) {
    switch (exercise.type) {
      case ExerciseType.fillInBlank:
        return _buildFillInBlankInput(exercise, index);
      case ExerciseType.multipleChoice:
        return _buildMultipleChoiceInput(exercise, index);
      case ExerciseType.errorCorrection:
        return _buildErrorCorrectionInput(exercise, index);
      case ExerciseType.sentenceReorder:
        return _buildSentenceReorderInput(exercise, index);
      case ExerciseType.transformation:
        return _buildTransformationInput(exercise, index);
    }
  }

  Widget _buildFillInBlankInput(GrammarExercise exercise, int index) {
    return TextField(
      enabled: _checkedAnswers[index] == null,
      decoration: InputDecoration(
        labelText: 'Your answer',
        hintText: 'Type your answer here',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: _checkedAnswers[index] == null
            ? null
            : _checkedAnswers[index]!
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
      ),
      onChanged: (value) {
        setState(() {
          _userAnswers[index] = value;
        });
      },
      controller: TextEditingController(text: _userAnswers[index] ?? ''),
    );
  }

  Widget _buildMultipleChoiceInput(GrammarExercise exercise, int index) {
    final options = exercise.options ?? [];
    return Column(
      children: options.asMap().entries.map((entry) {
        final optionIndex = entry.key;
        final option = entry.value;
        final isSelected = _userAnswers[index] == option;
        final isChecked = _checkedAnswers[index] != null;
        final isCorrect = option == exercise.correctAnswer;

        Color? backgroundColor;
        Widget? trailing;
        
        if (isChecked) {
          if (isSelected) {
            // Show user's selected answer with appropriate color
            backgroundColor = isCorrect
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1);
            trailing = Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? Colors.green : Colors.red,
            );
          } else if (isCorrect && !isSelected) {
            // Only show correct answer if user selected wrong answer
            backgroundColor = Colors.green.withOpacity(0.1);
            trailing = const Icon(Icons.check_circle, color: Colors.green);
          }
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: RadioListTile<String>(
            value: option,
            groupValue: _userAnswers[index],
            onChanged: isChecked
                ? null
                : (value) {
                    setState(() {
                      _userAnswers[index] = value!;
                    });
                  },
            title: Text(option),
            secondary: trailing,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildErrorCorrectionInput(GrammarExercise exercise, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Find and correct the error:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          enabled: _checkedAnswers[index] == null,
          decoration: InputDecoration(
            labelText: 'Corrected sentence',
            hintText: 'Type the corrected sentence',
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: _checkedAnswers[index] == null
                ? null
                : _checkedAnswers[index]!
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
          ),
          maxLines: 3,
          onChanged: (value) {
            setState(() {
              _userAnswers[index] = value;
            });
          },
          controller: TextEditingController(text: _userAnswers[index] ?? ''),
        ),
      ],
    );
  }

  Widget _buildSentenceReorderInput(GrammarExercise exercise, int index) {
    // Simple implementation - user types the reordered sentence
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reorder the words to make a correct sentence:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          enabled: _checkedAnswers[index] == null,
          decoration: InputDecoration(
            labelText: 'Reordered sentence',
            hintText: 'Type the words in correct order',
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: _checkedAnswers[index] == null
                ? null
                : _checkedAnswers[index]!
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
          ),
          maxLines: 2,
          onChanged: (value) {
            setState(() {
              _userAnswers[index] = value;
            });
          },
          controller: TextEditingController(text: _userAnswers[index] ?? ''),
        ),
      ],
    );
  }

  Widget _buildTransformationInput(GrammarExercise exercise, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transform the sentence:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          enabled: _checkedAnswers[index] == null,
          decoration: InputDecoration(
            labelText: 'Transformed sentence',
            hintText: 'Type the transformed sentence',
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: _checkedAnswers[index] == null
                ? null
                : _checkedAnswers[index]!
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
          ),
          maxLines: 3,
          onChanged: (value) {
            setState(() {
              _userAnswers[index] = value;
            });
          },
          controller: TextEditingController(text: _userAnswers[index] ?? ''),
        ),
      ],
    );
  }

  Widget _buildFeedback(GrammarExercise exercise, int index) {
    final isCorrect = _checkedAnswers[index]!;
    return Card(
      color: isCorrect
          ? Colors.green.withOpacity(0.1)
          : Colors.red.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  isCorrect ? 'Correct!' : 'Incorrect',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
                if (isCorrect) ...[
                  const Spacer(),
                  Text(
                    '+${exercise.xpReward} XP',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ],
            ),
            if (!isCorrect) ...[
              const SizedBox(height: 12),
              Text(
                'Correct answer: ${exercise.correctAnswer}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      exercise.explanation,
                      style: const TextStyle(fontSize: 14),
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

  Widget _buildActionButtons(GrammarExercise exercise, int index) {
    final hasAnswer = _userAnswers[index]?.isNotEmpty ?? false;
    final isChecked = _checkedAnswers[index] != null;
    final isLast = index == widget.exercises.length - 1;

    return Row(
      children: [
        if (!isChecked) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: _currentIndex > 0 ? _previousExercise : null,
              child: const Text('Previous'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: hasAnswer ? () => _checkAnswer(exercise, index) : null,
              child: const Text('Check Answer'),
            ),
          ),
        ] else ...[
          Expanded(
            child: ElevatedButton(
              onPressed: isLast ? _finishExercises : _nextExercise,
              child: Text(isLast ? 'Finish' : 'Next'),
            ),
          ),
        ],
      ],
    );
  }

  void _checkAnswer(GrammarExercise exercise, int index) async {
    final userAnswer = _userAnswers[index] ?? '';
    final isCorrect = exercise.checkAnswer(userAnswer);

    setState(() {
      _checkedAnswers[index] = isCorrect;
      if (isCorrect) {
        _totalXpEarned += exercise.xpReward;
      }
    });

    // Save to Firebase
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? '';
    await _progressService.saveExerciseScore(
      userId,
      widget.unitId,
      exercise.id,
      isCorrect ? 100 : 0,
      isCorrect ? exercise.xpReward : 0,
    );
  }

  void _nextExercise() {
    if (_currentIndex < widget.exercises.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousExercise() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishExercises() {
    final correctCount = _checkedAnswers.values.where((v) => v).length;
    final totalCount = widget.exercises.length;
    final percentage = (correctCount / totalCount * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Exercise Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              percentage >= 70 ? Icons.celebration : Icons.thumb_up,
              size: 64,
              color: percentage >= 70 ? Colors.amber : Colors.blue,
            ),
            const SizedBox(height: 16),
            Text(
              'Score: $correctCount/$totalCount ($percentage%)',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Total XP earned: $_totalXpEarned',
              style: const TextStyle(fontSize: 16, color: Colors.amber),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to topic
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getExerciseTypeInfo(ExerciseType type) {
    switch (type) {
      case ExerciseType.fillInBlank:
        return {
          'label': 'Fill in the Blank',
          'icon': Icons.edit,
          'color': Colors.blue,
        };
      case ExerciseType.multipleChoice:
        return {
          'label': 'Multiple Choice',
          'icon': Icons.radio_button_checked,
          'color': Colors.green,
        };
      case ExerciseType.errorCorrection:
        return {
          'label': 'Error Correction',
          'icon': Icons.error_outline,
          'color': Colors.orange,
        };
      case ExerciseType.sentenceReorder:
        return {
          'label': 'Sentence Reorder',
          'icon': Icons.reorder,
          'color': Colors.purple,
        };
      case ExerciseType.transformation:
        return {
          'label': 'Transformation',
          'icon': Icons.transform,
          'color': Colors.teal,
        };
    }
  }
}
