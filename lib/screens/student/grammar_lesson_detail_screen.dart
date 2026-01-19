import 'package:flutter/material.dart';
import '../../models/grammar_lesson.dart';
import '../../widgets/grammar/formula_table_widget.dart';
import '../../widgets/grammar/comparatives_table_widget.dart';
import '../../widgets/grammar/conditionals_table_widget.dart';
import '../../widgets/grammar/wish_table_widget.dart';
import '../../widgets/grammar/passive_voice_table_widget.dart';
import '../../widgets/grammar/subjunctive_table_widget.dart';
import '../../widgets/grammar/imperative_table_widget.dart';
import '../../widgets/grammar/reported_speech_table_widget.dart';
import '../../widgets/grammar/relative_clauses_table_widget.dart';
import '../../widgets/grammar/pronouns_table_widget.dart';
import '../../widgets/grammar/nouns_table_widget.dart';
import '../../widgets/grammar/adjectives_table_widget.dart';
import '../../widgets/grammar/verbs_table_widget.dart';
import '../../widgets/grammar/adverbs_table_widget.dart';
import '../../widgets/grammar/quantifiers_table_widget.dart';
import '../../widgets/grammar/prepositions_table_widget.dart';
import '../../widgets/grammar/articles_table_widget.dart';
import '../../widgets/grammar/conjunctions_table_widget.dart';
import '../../widgets/grammar/question_words_table_widget.dart';
import '../../widgets/grammar/yes_no_questions_table_widget.dart';
import '../../widgets/grammar/wh_questions_table_widget.dart';
import '../../widgets/grammar/tag_questions_table_widget.dart';
import '../../widgets/grammar/indirect_questions_table_widget.dart';
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
// Category 5 table widgets (Lessons 28-64)
import '../../widgets/grammar/enough_table_widget.dart';
import '../../widgets/grammar/suggest_table_widget.dart';
import '../../widgets/grammar/hope_table_widget.dart';
import '../../widgets/grammar/used_to_table_widget.dart';
import '../../widgets/grammar/mind_table_widget.dart';
import '../../widgets/grammar/would_you_like_table_widget.dart';
import '../../widgets/grammar/as_if_table_widget.dart';
import '../../widgets/grammar/although_table_widget.dart';
import '../../widgets/grammar/in_spite_of_table_widget.dart';
import '../../widgets/grammar/because_of_table_widget.dart';
import '../../widgets/grammar/so_such_too_table_widget.dart';
import '../../widgets/grammar/as_well_as_table_widget.dart';
import '../../widgets/grammar/not_only_but_also_table_widget.dart';
import '../../widgets/grammar/would_rather_table_widget.dart';
import '../../widgets/grammar/prefer_table_widget.dart';
import '../../widgets/grammar/refuse_table_widget.dart';
import '../../widgets/grammar/let_table_widget.dart';
import '../../widgets/grammar/lets_table_widget.dart';
import '../../widgets/grammar/difficult_table_widget.dart';
import '../../widgets/grammar/promise_table_widget.dart';
import '../../widgets/grammar/avoid_table_widget.dart';
import '../../widgets/grammar/advise_table_widget.dart';
import '../../widgets/grammar/after_table_widget.dart';
import '../../widgets/grammar/ask_table_widget.dart';
import '../../widgets/grammar/enjoy_table_widget.dart';
import '../../widgets/grammar/must_table_widget.dart';
import '../../widgets/grammar/as_much_as_table_widget.dart';
import '../../widgets/grammar/when_while_table_widget.dart';
import '../../widgets/grammar/find_table_widget.dart';
import '../../widgets/grammar/remember_table_widget.dart';
import '../../widgets/grammar/unless_table_widget.dart';
import '../../widgets/grammar/had_better_table_widget.dart';
import '../../widgets/grammar/despite_table_widget.dart';
import '../../widgets/grammar/it_was_not_until_table_widget.dart';
import '../../widgets/grammar/need_table_widget.dart';
import '../../widgets/grammar/regret_table_widget.dart';
import '../../widgets/grammar/stop_table_widget.dart';
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
    // Special layout for Category 5 - show all content on one page without tabs
    if (widget.lesson.categoryId == 'cat_5') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Objective
            _buildSection('🎯 Mục Tiêu', widget.lesson.objective, Colors.blue),
            const SizedBox(height: 20),
            
            // Theory
            _buildSection('📚 Khái niệm', widget.lesson.theory, Colors.green),
            const SizedBox(height: 20),
            
            // Formulas - Use table widgets
            _buildSectionTitle('📝 Công Thức', Colors.orange),
            const SizedBox(height: 12),
            _buildCategory5FormulaTable(),
          ],
        ),
      );
    }
    
    // Define available sections for other categories
    final sections = <String, Widget Function()>{
      'Mục Tiêu': () => _buildSection('🎯 Mục Tiêu', widget.lesson.objective, Colors.blue),
      'Khái Niệm': () => _buildSection('📚 Khái niệm', widget.lesson.theory, Colors.green),
      if (widget.lesson.formulas.isNotEmpty || 
          widget.lesson.id == 'lesson_1' || widget.lesson.id == 'lesson_2' || 
          widget.lesson.id == 'lesson_3' || widget.lesson.id == 'lesson_3_1' ||
          widget.lesson.id == 'lesson_3_2' || widget.lesson.id == 'lesson_3_3' ||
          widget.lesson.id == 'lesson_4' || widget.lesson.id == 'lesson_4_1' ||
          widget.lesson.id == 'lesson_4_2' || widget.lesson.id == 'lesson_4_3' ||
          widget.lesson.id == 'lesson_5' || widget.lesson.id == 'lesson_1_6' ||
          widget.lesson.id == 'lesson_6' || widget.lesson.id == 'lesson_7' ||
          widget.lesson.id == 'lesson_8' || widget.lesson.id == 'lesson_9' ||
          widget.lesson.id == 'lesson_10' || widget.lesson.id == 'lesson_11' ||
          widget.lesson.id == 'lesson_12' || widget.lesson.id == 'lesson_13' ||
          widget.lesson.id == 'lesson_14' || widget.lesson.id == 'lesson_15' ||
          widget.lesson.id == 'lesson_16' || widget.lesson.id == 'lesson_17' ||
          widget.lesson.id == 'lesson_18' || widget.lesson.id == 'lesson_19' ||
          widget.lesson.id == 'lesson_20' || widget.lesson.id == 'lesson_21' ||
          widget.lesson.id == 'lesson_22' || widget.lesson.id == 'lesson_23' ||
          widget.lesson.id == 'lesson_24' || widget.lesson.id == 'lesson_25' ||
          widget.lesson.id == 'lesson_26' || widget.lesson.id == 'lesson_27')
        // Use 'Phân Loại' for Category 3 (Parts of Speech), 'Công Thức' for others
        (widget.lesson.id == 'lesson_14' || widget.lesson.id == 'lesson_15' ||
         widget.lesson.id == 'lesson_16' || widget.lesson.id == 'lesson_17' ||
         widget.lesson.id == 'lesson_18' || widget.lesson.id == 'lesson_19' ||
         widget.lesson.id == 'lesson_20' || widget.lesson.id == 'lesson_21' ||
         widget.lesson.id == 'lesson_22')
          ? 'Phân Loại'
          : 'Công Thức': () => _buildFormulaSection(),
      // Only show Usage, Common Mistakes for non-Category 5 lessons
      if (widget.lesson.usages.isNotEmpty && widget.lesson.categoryId != 'cat_5')
        'Cách Dùng': () => _buildListSection('💡 Cách Dùng', widget.lesson.usages, Colors.purple),
      if (widget.lesson.recognitionSigns != null && widget.lesson.recognitionSigns!.isNotEmpty && widget.lesson.categoryId != 'cat_5')
        'Dấu Hiệu Nhận Biết': () => _buildListSection('🔍 Dấu Hiệu Nhận Biết', widget.lesson.recognitionSigns!, const Color(0xFFFF1493)),
      if (widget.lesson.commonMistakes.isNotEmpty && widget.lesson.categoryId != 'cat_5')
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
    // Check if this is a Category 3 lesson (Parts of Speech)
    final isCategory3 = widget.lesson.categoryId == 'cat_3';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          isCategory3 ? '📂 Phân Loại' : '📝 Công Thức',
          Colors.orange,
        ),
        const SizedBox(height: 12),

        if (widget.lesson.id == 'cat1_present_simple') ...[
          const FormulaTableWidget(),
        ] else if (widget.lesson.id == 'cat1_present_continuous') ...[
          const PresentContinuousTableWidget(),
        ] else if (widget.lesson.id == 'cat1_past_simple') ...[
          const PastSimpleTableWidget(),
        ] else if (widget.lesson.id == 'cat1_past_continuous') ...[
          const PastContinuousTableWidget(),
        ] else if (widget.lesson.id == 'cat1_past_perfect') ...[
          const PastPerfectTableWidget(),
        ] else if (widget.lesson.id == 'cat1_past_perfect_continuous') ...[
          const PastPerfectContinuousTableWidget(),
        ] else if (widget.lesson.id == 'cat1_future_simple') ...[
          const FutureSimpleTableWidget(),
        ] else if (widget.lesson.id == 'cat1_future_continuous') ...[
          const FutureContinuousTableWidget(),
        ] else if (widget.lesson.id == 'cat1_future_perfect') ...[
          const FuturePerfectTableWidget(),
        ] else if (widget.lesson.id == 'cat1_future_perfect_continuous') ...[
          const FuturePerfectContinuousTableWidget(),
        ] else if (widget.lesson.id == 'cat1_present_perfect') ...[
          const PresentPerfectTableWidget(),
        ] else if (widget.lesson.id == 'cat1_present_perfect_continuous') ...[
          const PresentPerfectContinuousTableWidget(),
        ] else if (widget.lesson.id == 'cat2_comparatives') ...[
          const ComparativesTableWidget(),
        ] else if (widget.lesson.id == 'cat2_conditionals') ...[
          const ConditionalsTableWidget(),
        ] else if (widget.lesson.id == 'cat2_wish_sentences') ...[
          const WishTableWidget(),
        ] else if (widget.lesson.id == 'cat2_active_passive') ...[
          const PassiveVoiceTableWidget(),
        ] else if (widget.lesson.id == 'cat2_subjunctive') ...[
          const SubjunctiveTableWidget(),
        ] else if (widget.lesson.id == 'cat2_imperative') ...[
          const ImperativeTableWidget(),
        ] else if (widget.lesson.id == 'cat2_direct_indirect') ...[
          const ReportedSpeechTableWidget(),
        ] else if (widget.lesson.id == 'cat2_relative_clauses') ...[
          const RelativeClausesTableWidget(),
        ] else if (widget.lesson.id == 'cat3_pronouns') ...[
          const PronounsTableWidget(),
        ] else if (widget.lesson.id == 'cat3_nouns') ...[
          const NounsTableWidget(),
        ] else if (widget.lesson.id == 'cat3_adjectives') ...[
          const AdjectivesTableWidget(),
        ] else if (widget.lesson.id == 'cat3_verbs') ...[
          const VerbsTableWidget(),
        ] else if (widget.lesson.id == 'cat3_adverbs') ...[
          const AdverbsTableWidget(),
        ] else if (widget.lesson.id == 'cat3_prepositions') ...[
          const QuantifiersTableWidget(),
        ] else if (widget.lesson.id == 'cat3_conjunctions') ...[
          const PrepositionsTableWidget(),
        ] else if (widget.lesson.id == 'cat3_articles') ...[
          const ArticlesTableWidget(),
        ] else if (widget.lesson.id == 'cat3_interjections') ...[
          const ConjunctionsTableWidget(),
        ] else if (widget.lesson.id == 'cat4_yes_no_questions') ...[
          const QuestionWordsTableWidget(),
        ] else if (widget.lesson.id == 'cat4_wh_questions') ...[
          const YesNoQuestionsTableWidget(),
        ] else if (widget.lesson.id == 'cat4_tag_questions') ...[
          const WhQuestionsTableWidget(),
        ] else if (widget.lesson.id == 'cat4_indirect_questions') ...[
          const TagQuestionsTableWidget(),
        ] else if (widget.lesson.id == 'cat4_choice_questions') ...[
          const IndirectQuestionsTableWidget(),
        ] 
        // Category 5 lessons
        else if (widget.lesson.id == 'cat5_enough') ...[
          const EnoughTableWidget(),
        ] else if (widget.lesson.id == 'cat5_suggest') ...[
          const SuggestTableWidget(),
        ] else if (widget.lesson.id == 'cat5_hope') ...[
          const HopeTableWidget(),
        ] else if (widget.lesson.id == 'cat5_used_to') ...[
          const UsedToTableWidget(),
        ] else if (widget.lesson.id == 'cat5_mind') ...[
          const MindTableWidget(),
        ] else if (widget.lesson.id == 'cat5_would_you_like') ...[
          const WouldYouLikeTableWidget(),
        ] else if (widget.lesson.id == 'cat5_as_if') ...[
          const AsIfTableWidget(),
        ] else if (widget.lesson.id == 'cat5_although') ...[
          const AlthoughTableWidget(),
        ] else if (widget.lesson.id == 'cat5_in_spite_of') ...[
          const InSpiteOfTableWidget(),
        ] else if (widget.lesson.id == 'cat5_because_of') ...[
          const BecauseOfTableWidget(),
        ] else if (widget.lesson.id == 'cat5_so_such_too') ...[
          const SoSuchTooTableWidget(),
        ] else if (widget.lesson.id == 'cat5_as_well_as') ...[
          const AsWellAsTableWidget(),
        ] else if (widget.lesson.id == 'cat5_not_only_but_also') ...[
          const NotOnlyButAlsoTableWidget(),
        ] else if (widget.lesson.id == 'cat5_would_rather') ...[
          const WouldRatherTableWidget(),
        ] else if (widget.lesson.id == 'cat5_prefer') ...[
          const PreferTableWidget(),
        ] else if (widget.lesson.id == 'cat5_refuse') ...[
          const RefuseTableWidget(),
        ] else if (widget.lesson.id == 'cat5_let') ...[
          const LetTableWidget(),
        ] else if (widget.lesson.id == 'cat5_lets') ...[
          const LetsTableWidget(),
        ] else if (widget.lesson.id == 'cat5_difficult') ...[
          const DifficultTableWidget(),
        ] else if (widget.lesson.id == 'cat5_promise') ...[
          const PromiseTableWidget(),
        ] else if (widget.lesson.id == 'cat5_avoid') ...[
          const AvoidTableWidget(),
        ] else if (widget.lesson.id == 'cat5_advise') ...[
          const AdviseTableWidget(),
        ] else if (widget.lesson.id == 'cat5_after') ...[
          const AfterTableWidget(),
        ] else if (widget.lesson.id == 'cat5_ask') ...[
          const AskTableWidget(),
        ] else if (widget.lesson.id == 'cat5_enjoy') ...[
          const EnjoyTableWidget(),
        ] else if (widget.lesson.id == 'cat5_must') ...[
          const MustTableWidget(),
        ] else if (widget.lesson.id == 'cat5_as_much_as') ...[
          const AsMuchAsTableWidget(),
        ] else if (widget.lesson.id == 'cat5_when_while') ...[
          const WhenWhileTableWidget(),
        ] else if (widget.lesson.id == 'cat5_find') ...[
          const FindTableWidget(),
        ] else if (widget.lesson.id == 'cat5_remember') ...[
          const RememberTableWidget(),
        ] else if (widget.lesson.id == 'cat5_unless') ...[
          const UnlessTableWidget(),
        ] else if (widget.lesson.id == 'cat5_had_better') ...[
          const HadBetterTableWidget(),
        ] else if (widget.lesson.id == 'cat5_despite') ...[
          const DespiteTableWidget(),
        ] else if (widget.lesson.id == 'cat5_it_was_not_until') ...[
          const ItWasNotUntilTableWidget(),
        ] else if (widget.lesson.id == 'cat5_need') ...[
          const NeedTableWidget(),
        ] else if (widget.lesson.id == 'cat5_regret') ...[
          const RegretTableWidget(),
        ] else if (widget.lesson.id == 'cat5_stop') ...[
          const StopTableWidget(),
        ] else ...[
          ...widget.lesson.formulas.map((formula) => _buildFormulaCard(formula)),
        ],
      ],
    );
  }

  Widget _buildCategory5FormulaTable() {
    switch (widget.lesson.id) {
      case 'cat5_enough': return const EnoughTableWidget();
      case 'cat5_suggest': return const SuggestTableWidget();
      case 'cat5_hope': return const HopeTableWidget();
      case 'cat5_used_to': return const UsedToTableWidget();
      case 'cat5_mind': return const MindTableWidget();
      case 'cat5_would_you_like': return const WouldYouLikeTableWidget();
      case 'cat5_as_if': return const AsIfTableWidget();
      case 'cat5_although': return const AlthoughTableWidget();
      case 'cat5_in_spite_of': return const InSpiteOfTableWidget();
      case 'cat5_because_of': return const BecauseOfTableWidget();
      case 'cat5_so_such_too': return const SoSuchTooTableWidget();
      case 'cat5_as_well_as': return const AsWellAsTableWidget();
      case 'cat5_not_only_but_also': return const NotOnlyButAlsoTableWidget();
      case 'cat5_would_rather': return const WouldRatherTableWidget();
      case 'cat5_prefer': return const PreferTableWidget();
      case 'cat5_refuse': return const RefuseTableWidget();
      case 'cat5_let': return const LetTableWidget();
      case 'cat5_lets': return const LetsTableWidget();
      case 'cat5_difficult': return const DifficultTableWidget();
      case 'cat5_promise': return const PromiseTableWidget();
      case 'cat5_avoid': return const AvoidTableWidget();
      case 'cat5_advise': return const AdviseTableWidget();
      case 'cat5_after': return const AfterTableWidget();
      case 'cat5_ask': return const AskTableWidget();
      case 'cat5_enjoy': return const EnjoyTableWidget();
      case 'cat5_must': return const MustTableWidget();
      case 'cat5_as_much_as': return const AsMuchAsTableWidget();
      case 'cat5_when_while': return const WhenWhileTableWidget();
      case 'cat5_find': return const FindTableWidget();
      case 'cat5_remember': return const RememberTableWidget();
      case 'cat5_unless': return const UnlessTableWidget();
      case 'cat5_had_better': return const HadBetterTableWidget();
      case 'cat5_despite': return const DespiteTableWidget();
      case 'cat5_it_was_not_until': return const ItWasNotUntilTableWidget();
      case 'cat5_need': return const NeedTableWidget();
      case 'cat5_regret': return const RegretTableWidget();
      case 'cat5_stop': return const StopTableWidget();
      default: return const SizedBox.shrink();
    }
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

