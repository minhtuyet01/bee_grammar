import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/grammar_content_service.dart';
import '../../data/lesson_progress_service.dart';
import '../../models/grammar_lesson.dart';
import '../../widgets/lesson_progress_bar.dart';
import '../../widgets/skeleton_loading.dart';
import 'grammar_lesson_detail_screen.dart';

class GrammarTensesScreen extends StatefulWidget {
  final GrammarCategory category;

  const GrammarTensesScreen({super.key, required this.category});

  @override
  State<GrammarTensesScreen> createState() => _GrammarTensesScreenState();
}

class _GrammarTensesScreenState extends State<GrammarTensesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _progressService = LessonProgressService();
  final _contentService = GrammarContentService();
  List<GrammarLesson> _allLessons = [];
  Map<String, int> _progressMap = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadLessons();
    await _loadProgress();
  }

  Future<void> _loadLessons() async {
    try {
      // Load from Firebase with caching
      final lessons = await _contentService.getLessonsByCategory(widget.category.id);
      setState(() {
        _allLessons = lessons;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tải dữ liệu: $e')),
        );
      }
    }
  }

  Future<void> _loadProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() => _isLoading = false);
      return;
    }

    final lessonIds = _allLessons.map((l) => l.id).toList();
    final progressMap = await _progressService.getMultipleLessonsProgress(
      userId: userId,
      lessonIds: lessonIds,
    );

    if (mounted) {
      setState(() {
        _progressMap = progressMap;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.wb_sunny),
              text: 'Hiện tại',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'Quá khứ',
            ),
            Tab(
              icon: Icon(Icons.wb_twilight),
              text: 'Tương lai',
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const LessonListSkeleton(itemCount: 4)
          : TabBarView(
              controller: _tabController,
              children: [
                _buildTenseTab(['cat1_present_simple', 'cat1_present_continuous', 'cat1_present_perfect', 'cat1_present_perfect_continuous'], Colors.blue),
                _buildTenseTab(['cat1_past_simple', 'cat1_past_continuous', 'cat1_past_perfect', 'cat1_past_perfect_continuous'], Colors.orange),
                _buildTenseTab(['cat1_future_simple', 'cat1_future_continuous', 'cat1_future_perfect', 'cat1_future_perfect_continuous'], Colors.purple),
              ],
            ),
    );
  }

  Widget _buildTenseTab(List<String> lessonIds, Color color) {
    final lessons = _allLessons.where((l) => lessonIds.contains(l.id)).toList();

    if (lessons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Chưa có bài học',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        final progress = _progressMap[lesson.id] ?? 0;
        return _buildLessonCard(context, lesson, index + 1, color, progress);
      },
    );
  }

  Widget _buildLessonCard(
      BuildContext context, GrammarLesson lesson, int number, Color color, int progress) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GrammarLessonDetailScreen(
                lesson: lesson,
                categoryTitle: widget.category.title,
              ),
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
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: progress == 100
                          ? Icon(Icons.check, color: color, size: 20)
                          : Text(
                              '$number',
                              style: TextStyle(
                                color: color,
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
