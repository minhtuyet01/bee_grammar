import 'package:flutter/material.dart';
import '../../models/grammar_lesson.dart';
import '../../widgets/grammar/formula_table_widget.dart';
import '../../widgets/grammar/present_continuous_table_widget.dart';
import '../../widgets/grammar/present_perfect_table_widget.dart';
import '../../widgets/grammar/present_perfect_continuous_table_widget.dart';
import '../../widgets/grammar/past_simple_table_widget.dart';
import '../../widgets/grammar/past_continuous_table_widget.dart';
import '../../widgets/grammar/past_perfect_table_widget.dart';
import '../../widgets/grammar/past_perfect_continuous_table_widget.dart';
import '../../widgets/grammar/future_simple_table_widget.dart';
import '../../widgets/grammar/future_continuous_table_widget.dart';
import '../../widgets/grammar/future_perfect_table_widget.dart';
import '../../widgets/grammar/future_perfect_continuous_table_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/learning_history_service.dart';
import '../../data/lesson_progress_service.dart';
import '../../widgets/lesson_progress_bar.dart';
import 'dart:async';

class GrammarLessonDetailScreen extends StatefulWidget {
  final GrammarLesson lesson;

  const GrammarLessonDetailScreen({super.key, required this.lesson});

  @override
  State<GrammarLessonDetailScreen> createState() => _GrammarLessonDetailScreenState();
}

class _GrammarLessonDetailScreenState extends State<GrammarLessonDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  
  // GlobalKeys for each section
  final GlobalKey _objectiveKey = GlobalKey();
  final GlobalKey _theoryKey = GlobalKey();
  final GlobalKey _formulaKey = GlobalKey();
  final GlobalKey _usagesKey = GlobalKey();
  final GlobalKey _recognitionKey = GlobalKey();
  final GlobalKey _mistakesKey = GlobalKey();

  // Progress tracking
  final _progressService = LessonProgressService();
  Timer? _theoryTimer;
  int _theoryTimeSpent = 0;
  bool _hasScrolled = false;
  bool _hasInteraction = false;
  int _progressPercentage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadProgress();
    _setupListeners();
  }

  @override
  void dispose() {
    _theoryTimer?.cancel();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final progress = await _progressService.getLessonProgress(
      userId: userId,
      lessonId: widget.lesson.id,
    );

    if (mounted) {
      setState(() {
        _progressPercentage = progress['progressPercentage'] ?? 0;
      });
    }
  }

  void _setupListeners() {
    // Tab change listener
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _hasInteraction = true;
        
        // Start timer when on theory tab (index 0)
        if (_tabController.index == 0) {
          _startTheoryTimer();
        } else {
          _stopTheoryTimer();
          
          // Mark examples viewed when switching to examples tab
          if (_tabController.index == 1) {
            _updateExamplesProgress();
          }
        }
      }
    });

    // Scroll listener
    _scrollController.addListener(() {
      if (!_hasScrolled && _scrollController.offset > 100) {
        setState(() {
          _hasScrolled = true;
        });
        _updateTheoryProgress();
      }
    });

    // Start timer initially if on theory tab
    if (_tabController.index == 0) {
      _startTheoryTimer();
    }
  }

  void _startTheoryTimer() {
    _theoryTimer?.cancel();
    _theoryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _theoryTimeSpent++;
      if (_theoryTimeSpent >= 30 && _hasScrolled) {
        _updateTheoryProgress();
      }
    });
  }

  void _stopTheoryTimer() {
    _theoryTimer?.cancel();
  }

  Future<void> _updateTheoryProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _progressService.updateTheoryProgress(
      userId: userId,
      lessonId: widget.lesson.id,
      timeSpent: _theoryTimeSpent,
      scrolled: _hasScrolled,
    );

    _loadProgress();
  }

  Future<void> _updateExamplesProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _progressService.updateExamplesProgress(
      userId: userId,
      lessonId: widget.lesson.id,
    );

    _loadProgress();
  }

  Future<void> _updateExercisesProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _progressService.updateExercisesProgress(
      userId: userId,
      lessonId: widget.lesson.id,
    );

    _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Increased height for progress bar
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.lesson.title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: LessonProgressBar(
                progressPercentage: _progressPercentage,
                showLabel: false,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Lý Thuyết'),
            Tab(text: 'Ví Dụ'),
            Tab(text: 'Bài Tập'),
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
    );
  }

  Widget _buildTheoryTab() {
    // Define available sections
    final sections = <String, Widget Function()>{
      'Mục Tiêu': () => _buildSection('🎯 Mục Tiêu', widget.lesson.objective, Colors.blue),
      'Khái Niệm': () => _buildSection('📚 Khái niệm', widget.lesson.theory, Colors.green),
      if (widget.lesson.formulas.isNotEmpty || 
          widget.lesson.id == 'lesson_1' || widget.lesson.id == 'lesson_2' || 
          widget.lesson.id == 'lesson_3' || widget.lesson.id == 'lesson_3_1' ||
          widget.lesson.id == 'lesson_3_2' || widget.lesson.id == 'lesson_3_3' ||
          widget.lesson.id == 'lesson_4' || widget.lesson.id == 'lesson_4_1' ||
          widget.lesson.id == 'lesson_4_2' || widget.lesson.id == 'lesson_4_3' ||
          widget.lesson.id == 'lesson_5' || widget.lesson.id == 'lesson_1_6')
        'Công Thức': () => _buildFormulaSection(),
      if (widget.lesson.usages.isNotEmpty)
        'Cách Dùng': () => _buildListSection('💡 Cách Dùng', widget.lesson.usages, Colors.purple),
      if (widget.lesson.recognitionSigns != null && widget.lesson.recognitionSigns!.isNotEmpty)
        'Dấu Hiệu Nhận Biết': () => _buildListSection('🔍 Dấu Hiệu Nhận Biết', widget.lesson.recognitionSigns!, const Color(0xFFFF1493)),
      if (widget.lesson.commonMistakes.isNotEmpty)
        'Lỗi Sai Thường Gặp': () => _buildListSection('⚠️ Lỗi Sai Thường Gặp', widget.lesson.commonMistakes, Colors.red),
    };

    final sectionNames = sections.keys.toList();
    
    // Ensure current section is within bounds
    if (_currentSection >= sectionNames.length) {
      _currentSection = 0;
    }

    return Column(
      children: [
        // Current section content
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: sections[sectionNames[_currentSection]]!(),
          ),
        ),
        // Navigation bar at bottom
        Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 12 + MediaQuery.of(context).padding.bottom,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.grey.shade100,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade700
                    : Colors.grey.shade300,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              IconButton(
                onPressed: _currentSection > 0 ? () {
                  setState(() => _currentSection--);
                } : null,
                icon: const Icon(Icons.arrow_back_ios),
                tooltip: _currentSection > 0 ? sectionNames[_currentSection - 1] : null,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.white,
                ),
              ),
              // Current section name
              Expanded(
                child: Text(
                  sectionNames[_currentSection],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
              // Next button
              IconButton(
                onPressed: _currentSection < sectionNames.length - 1 ? () {
                  setState(() => _currentSection++);
                } : null,
                icon: const Icon(Icons.arrow_forward_ios),
                tooltip: _currentSection < sectionNames.length - 1 ? sectionNames[_currentSection + 1] : null,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormulaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('📝 Công Thức', Colors.orange),
        const SizedBox(height: 12),

        if (widget.lesson.id == 'lesson_1') ...[
          const FormulaTableWidget(),
        ] else if (widget.lesson.id == 'lesson_2') ...[
          const PresentContinuousTableWidget(),
        ] else if (widget.lesson.id == 'lesson_3') ...[
          const PastSimpleTableWidget(),
        ] else if (widget.lesson.id == 'lesson_3_1') ...[
          const PastContinuousTableWidget(),
        ] else if (widget.lesson.id == 'lesson_3_2') ...[
          const PastPerfectTableWidget(),
        ] else if (widget.lesson.id == 'lesson_3_3') ...[
          const PastPerfectContinuousTableWidget(),
        ] else if (widget.lesson.id == 'lesson_4') ...[
          const FutureSimpleTableWidget(),
        ] else if (widget.lesson.id == 'lesson_4_1') ...[
          const FutureContinuousTableWidget(),
        ] else if (widget.lesson.id == 'lesson_4_2') ...[
          const FuturePerfectTableWidget(),
        ] else if (widget.lesson.id == 'lesson_4_3') ...[
          const FuturePerfectContinuousTableWidget(),
        ] else if (widget.lesson.id == 'lesson_5') ...[
          const PresentPerfectTableWidget(),
        ] else if (widget.lesson.id == 'lesson_1_6') ...[
          const PresentPerfectContinuousTableWidget(),
        ] else ...[
          ...widget.lesson.formulas.map((formula) => _buildFormulaCard(formula)),
        ],
      ],
    );
  }

  Widget _buildExamplesTab() {
    if (widget.lesson.examples.isEmpty) {
      return const Center(child: Text('Chưa có ví dụ'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.lesson.examples.length,
      itemBuilder: (context, index) {
        final example = widget.lesson.examples[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  example.english,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  example.vietnamese,
                  style: const TextStyle(fontSize: 15),
                ),
                if (example.note != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb, size: 16, color: Colors.amber),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            example.note!,
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
    if (widget.lesson.exercises.isEmpty) {
      return const Center(child: Text('Chưa có bài tập'));
    }

    return _ExerciseQuizWidget(
      exercises: widget.lesson.exercises,
      lesson: widget.lesson,
    );
  }

  Widget _buildSection(String title, String content, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title, color),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildListSection(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title, color),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: entry.key < items.length - 1 ? 12 : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.key + 1}. ',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    // Define section names based on available sections
    final sections = [
      'Mục Tiêu',
      'Khái Niệm',
      if (widget.lesson.formulas.isNotEmpty || 
          widget.lesson.id == 'lesson_1' || widget.lesson.id == 'lesson_2' || 
          widget.lesson.id == 'lesson_3' || widget.lesson.id == 'lesson_3_1' ||
          widget.lesson.id == 'lesson_3_2' || widget.lesson.id == 'lesson_3_3' ||
          widget.lesson.id == 'lesson_4' || widget.lesson.id == 'lesson_4_1' ||
          widget.lesson.id == 'lesson_4_2' || widget.lesson.id == 'lesson_4_3' ||
          widget.lesson.id == 'lesson_5' || widget.lesson.id == 'lesson_1_6') 'Công Thức',
      if (widget.lesson.usages.isNotEmpty) 'Cách Dùng',
      if (widget.lesson.recognitionSigns != null && widget.lesson.recognitionSigns!.isNotEmpty) 'Dấu Hiệu Nhận Biết',
      if (widget.lesson.commonMistakes.isNotEmpty) 'Lỗi Sai Thường Gặp',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _currentSection > 0 ? () {
              setState(() {
                _currentSection--;
              });
              _scrollToTop();
            } : null,
            icon: const Icon(Icons.arrow_back),
            label: Text('← ${_currentSection > 0 ? sections[_currentSection - 1] : "Phần trước"}'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Next button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _currentSection < sections.length - 1 ? () {
              setState(() {
                _currentSection++;
              });
              _scrollToTop();
            } : null,
            icon: const Icon(Icons.arrow_forward),
            label: Text('${_currentSection < sections.length - 1 ? sections[_currentSection + 1] : "Phần tiếp"} →'),
            iconAlignment: IconAlignment.end,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildFormulaCard(String formula) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.functions, color: Colors.orange, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              formula,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMistakeCard(String mistake) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Text(
        mistake,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildNoteItem(String note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}


// Interactive Exercise Quiz Widget
class _ExerciseQuizWidget extends StatefulWidget {
  final List<GrammarExerciseItem> exercises;
  final GrammarLesson lesson;

  const _ExerciseQuizWidget({
    required this.exercises,
    required this.lesson,
  });

  @override
  State<_ExerciseQuizWidget> createState() => _ExerciseQuizWidgetState();
}

class _ExerciseQuizWidgetState extends State<_ExerciseQuizWidget> {
  int _currentIndex = 0;
  final Map<int, String> _userAnswers = {};
  final Map<int, bool> _checkedAnswers = {};
  int _totalPoints = 0;
  final Map<int, List<String>> _shuffledWordBanks = {}; // Cache shuffled word banks
  final Map<int, TextEditingController> _textControllers = {}; // Cache text controllers
  late DateTime _startTime; // Track start time

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now(); // Record start time
  }

  GrammarExerciseItem get _currentExercise => widget.exercises[_currentIndex];
  bool get _isChecked => _checkedAnswers[_currentIndex] != null;
  bool get _isLastExercise => _currentIndex == widget.exercises.length - 1;

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / widget.exercises.length;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        // Exercise content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with question number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Câu ${_currentIndex + 1}/${widget.exercises.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Question
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _currentExercise.question,
                      style: const TextStyle(fontSize: 18, height: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Answer options
                _buildAnswerInput(),
                const SizedBox(height: 16),

                // Feedback after checking
                if (_isChecked) _buildFeedback(),
                const SizedBox(height: 16),

                // Action buttons
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerInput() {
    if (_currentExercise.type == ExerciseType.multipleChoice && _currentExercise.options != null) {
      return _buildMultipleChoiceInput();
    } else if (_currentExercise.type == ExerciseType.dragAndDrop && _currentExercise.wordBank != null) {
      return _buildDragDropInput();
    } else {
      return _buildFillInBlankInput();
    }
  }

  Widget _buildMultipleChoiceInput() {
    final options = _currentExercise.options!;
    return Column(
      children: options.map((option) {
        final isSelected = _userAnswers[_currentIndex] == option;
        final isCorrect = option == _currentExercise.correctAnswer;
        
        Color? backgroundColor;
        Widget? trailing;
        
        if (_isChecked) {
          if (isSelected) {
            backgroundColor = isCorrect
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1);
            trailing = Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? Colors.green : Colors.red,
            );
          } else if (isCorrect) {
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
              color: isSelected ? Colors.blue : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: RadioListTile<String>(
            value: option,
            groupValue: _userAnswers[_currentIndex],
            onChanged: _isChecked
                ? null
                : (value) {
                    setState(() {
                      _userAnswers[_currentIndex] = value!;
                    });
                  },
            title: Text(option),
            secondary: trailing,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDragDropInput() {
    // Get or create shuffled word bank for this exercise
    if (!_shuffledWordBanks.containsKey(_currentIndex)) {
      final wordBank = List<String>.from(_currentExercise.wordBank ?? []);
      wordBank.shuffle();
      _shuffledWordBanks[_currentIndex] = wordBank;
    }
    final wordBank = _shuffledWordBanks[_currentIndex]!;
    final selectedWords = _userAnswers[_currentIndex]?.split(' ').where((w) => w.isNotEmpty).toList() ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Answer area
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 60),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isChecked
                ? (_checkedAnswers[_currentIndex]!
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1))
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isChecked
                  ? (_checkedAnswers[_currentIndex]! ? Colors.green : Colors.red)
                  : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedWords.isEmpty
                ? [
                    Text(
                      'Chọn các từ bên dưới để tạo câu',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ]
                : selectedWords.map((word) {
                    return GestureDetector(
                      onTap: _isChecked
                          ? null
                          : () {
                              setState(() {
                                selectedWords.remove(word);
                                _userAnswers[_currentIndex] = selectedWords.join(' ');
                              });
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          word,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        
        // Word bank
        const Text(
          'Chọn từ:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: wordBank.map((word) {
            final isUsed = selectedWords.contains(word);
            return GestureDetector(
              onTap: _isChecked || isUsed
                  ? null
                  : () {
                      setState(() {
                        selectedWords.add(word);
                        _userAnswers[_currentIndex] = selectedWords.join(' ');
                      });
                    },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isUsed ? Colors.grey[300] : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isUsed ? Colors.grey[400]! : Colors.blue,
                    width: 2,
                  ),
                ),
                child: Text(
                  word,
                  style: TextStyle(
                    color: isUsed ? Colors.grey[600] : Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFillInBlankInput() {
    // Get or create text controller for this exercise
    if (!_textControllers.containsKey(_currentIndex)) {
      _textControllers[_currentIndex] = TextEditingController(text: _userAnswers[_currentIndex] ?? '');
      _textControllers[_currentIndex]!.addListener(() {
        setState(() {
          _userAnswers[_currentIndex] = _textControllers[_currentIndex]!.text;
        });
      });
    }
    
    return TextField(
      enabled: !_isChecked,
      controller: _textControllers[_currentIndex],
      decoration: InputDecoration(
        labelText: 'Nhập câu trả lời',
        hintText: 'Gõ đáp án...',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: _isChecked
            ? (_checkedAnswers[_currentIndex]!
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1))
            : null,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all text controllers
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildFeedback() {
    final isCorrect = _checkedAnswers[_currentIndex]!;
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
                  isCorrect ? 'Chính xác! 🎉' : 'Chưa đúng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            if (!isCorrect) ...[ 
              const SizedBox(height: 12),
              Text(
                'Đáp án đúng: ${_currentExercise.correctAnswer}',
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
                      _currentExercise.explanation ?? '',
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

  Widget _buildActionButtons() {
    final hasAnswer = _userAnswers[_currentIndex]?.isNotEmpty ?? false;

    if (!_isChecked) {
      return ElevatedButton(
        onPressed: hasAnswer ? _checkAnswer : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Kiểm tra', style: TextStyle(fontSize: 16)),
      );
    } else {
      return ElevatedButton(
        onPressed: _nextExercise,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
        ),
        child: Text(
          _isLastExercise ? 'Hoàn thành' : 'Tiếp theo',
          style: const TextStyle(fontSize: 16),
        ),
      );
    }
  }

  void _checkAnswer() {
    final userAnswer = _userAnswers[_currentIndex]?.trim() ?? '';
    final correctAnswer = _currentExercise.correctAnswer.trim();
    final isCorrect = userAnswer.toLowerCase() == correctAnswer.toLowerCase();

    setState(() {
      _checkedAnswers[_currentIndex] = isCorrect;
      if (isCorrect) {
        _totalPoints += 10;
      }
    });
  }

  void _nextExercise() {
    if (_isLastExercise) {
      _showCompletionDialog();
    } else {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _showCompletionDialog() async {
    final correctCount = _checkedAnswers.values.where((v) => v).length;
    final totalCount = widget.exercises.length;
    final percentage = (correctCount / totalCount * 100).round();
    
    // Calculate time spent
    final timeSpent = DateTime.now().difference(_startTime).inSeconds;
    
    // Save to Firebase
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final service = LearningHistoryService();
        await service.saveLessonCompletion(
          userId: userId,
          lessonId: widget.lesson.id,
          lessonTitle: widget.lesson.title,
          categoryId: widget.lesson.categoryId ?? '',
          categoryTitle: '', // Will be populated from categoryId in service
          score: percentage,
          correctAnswers: correctCount,
          totalQuestions: totalCount,
          timeSpent: timeSpent,
        );
        
        // Update exercises progress
        final progressService = LessonProgressService();
        await progressService.updateExercisesProgress(
          userId: userId,
          lessonId: widget.lesson.id,
        );
      } catch (e) {
        print('Error saving lesson completion: $e');
      }
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành bài tập! 🎉'),
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
              'Điểm số: $correctCount/$totalCount ($percentage%)',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _userAnswers.clear();
                _checkedAnswers.clear();
                _totalPoints = 0;
                _startTime = DateTime.now(); // Reset start time
              });
            },
            child: const Text('Làm lại'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Xong'),
          ),
        ],
      ),
    );
  }
}

