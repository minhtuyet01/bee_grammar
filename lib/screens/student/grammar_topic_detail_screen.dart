import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../models/grammar_topic.dart';
import '../../models/grammar_exercise.dart';
import '../../data/firebase_grammar_service.dart';
import '../../data/firebase_grammar_progress_service.dart';
import '../../data/mock_exercise_data.dart';
import 'grammar_exercise_screen.dart';

class GrammarTopicDetailScreen extends StatefulWidget {
  final GrammarTopic topic;
  final String unitId;

  const GrammarTopicDetailScreen({
    super.key,
    required this.topic,
    required this.unitId,
  });

  @override
  State<GrammarTopicDetailScreen> createState() => _GrammarTopicDetailScreenState();
}

class _GrammarTopicDetailScreenState extends State<GrammarTopicDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _grammarService = FirebaseGrammarService();
  final _progressService = FirebaseGrammarProgressService();
  
  List<GrammarExercise> _exercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadExercises();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Replace with real Firebase data
      final exercises = MockExerciseData.getExercisesForTopic(widget.topic.id);
      setState(() {
        _exercises = exercises;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading exercises: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Theory', icon: Icon(Icons.book)),
            Tab(text: 'Examples', icon: Icon(Icons.lightbulb_outline)),
            Tab(text: 'Exercises', icon: Icon(Icons.edit_note)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTheoryTab(),
          _buildExamplesTab(),
          _buildExercisesTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildTheoryTab() {
    if (widget.topic.theoryContent == null || widget.topic.theoryContent!.isEmpty) {
      return _buildEmptyState('No theory content available');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.topic.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.topic.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          // TODO: Render markdown content
          Text(
            widget.topic.theoryContent!,
            style: const TextStyle(fontSize: 15, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesTab() {
    if (widget.topic.examples.isEmpty) {
      return _buildEmptyState('No examples available');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.topic.examples.length,
      itemBuilder: (context, index) {
        final example = widget.topic.examples[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      example.isCorrect ? Icons.check_circle : Icons.cancel,
                      color: example.isCorrect ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        example.sentence,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  example.translation,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (example.explanation.isNotEmpty) ...[
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
                        const Icon(Icons.info_outline, size: 16, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            example.explanation,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExercisesTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_exercises.isEmpty) {
      return _buildEmptyState('No exercises available');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _exercises.length,
      itemBuilder: (context, index) {
        final exercise = _exercises[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getDifficultyColor(exercise.difficulty).withOpacity(0.2),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getDifficultyColor(exercise.difficulty),
                ),
              ),
            ),
            title: Text(
              _getExerciseTypeLabel(exercise.type),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Difficulty: ${_getDifficultyLabel(exercise.difficulty)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToExercise(exercise, index),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: widget.topic.isCompleted ? null : _markAsCompleted,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.topic.color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            widget.topic.isCompleted ? 'Completed ✓' : 'Mark as Completed',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> _markAsCompleted() async {
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? '';
    final success = await _progressService.markTopicCompleted(
      userId,
      widget.unitId,
      widget.topic.id,
      50, // XP reward for completing topic
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Topic completed! +50 XP')),
      );
      Navigator.pop(context);
    }
  }

  void _navigateToExercise(GrammarExercise exercise, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GrammarExerciseScreen(
          exercises: _exercises,
          initialIndex: index,
          unitId: widget.unitId,
        ),
      ),
    );
  }

  String _getExerciseTypeLabel(ExerciseType type) {
    switch (type) {
      case ExerciseType.fillInBlank:
        return 'Fill in the Blank';
      case ExerciseType.multipleChoice:
        return 'Multiple Choice';
      case ExerciseType.errorCorrection:
        return 'Error Correction';
      case ExerciseType.sentenceReorder:
        return 'Sentence Reorder';
      case ExerciseType.transformation:
        return 'Transformation';
    }
  }

  String _getDifficultyLabel(int difficulty) {
    switch (difficulty) {
      case 1:
        return 'Easy';
      case 2:
        return 'Medium';
      case 3:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  Color _getDifficultyColor(int difficulty) {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
