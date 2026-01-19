import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/grammar_content_service.dart';
import '../../data/lesson_progress_service.dart';
import '../../models/grammar_lesson.dart';
import '../../widgets/lesson_progress_bar.dart';
import '../../widgets/skeleton_loading.dart';
import 'grammar_lesson_detail_screen.dart';

class GrammarLessonsScreen extends StatefulWidget {
  final GrammarCategory category;

  const GrammarLessonsScreen({super.key, required this.category});

  @override
  State<GrammarLessonsScreen> createState() => _GrammarLessonsScreenState();
}

class _GrammarLessonsScreenState extends State<GrammarLessonsScreen> {
  final _progressService = LessonProgressService();
  final _contentService = GrammarContentService();
  Map<String, int> _progressMap = {};
  List<GrammarLesson> _lessons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() => _isLoading = false);
      return;
    }

    // Load lessons from Firebase with caching
    final lessons = await _contentService.getLessonsByCategory(widget.category.id);
    final lessonIds = lessons.map((l) => l.id).toList();

    final progressMap = await _progressService.getMultipleLessonsProgress(
      userId: userId,
      lessonIds: lessonIds,
    );

    if (mounted) {
      setState(() {
        _lessons = lessons;
        _progressMap = progressMap;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: _isLoading
          ? const LessonListSkeleton(itemCount: 10)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _lessons.length,
              itemBuilder: (context, index) {
                final lesson = _lessons[index];
                final progress = _progressMap[lesson.id] ?? 0;
                return _buildLessonCard(context, lesson, index + 1, progress);
              },
            ),
    );
  }

  Widget _buildLessonCard(BuildContext context, GrammarLesson lesson, int number, int progress) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GrammarLessonDetailScreen(lesson: lesson),
            ),
          );
          // Reload progress when returning
          _loadProgress();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Number badge
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.category.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: progress == 100
                          ? Icon(Icons.check, color: widget.category.color, size: 20)
                          : Text(
                              '$number',
                              style: TextStyle(
                                color: widget.category.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson.objective,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Arrow
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ],
              ),
              
              // Progress bar - Always show
              const SizedBox(height: 12),
              LessonProgressBar(
                progressPercentage: progress,
                showLabel: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
