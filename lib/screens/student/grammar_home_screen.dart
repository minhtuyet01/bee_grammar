import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../data/firebase_grammar_service.dart';
import '../../data/firebase_grammar_progress_service.dart';
import '../../models/grammar_unit.dart';
import '../../widgets/grammar/grammar_unit_card.dart';
import 'grammar_unit_detail_screen.dart';

class GrammarHomeScreen extends StatefulWidget {
  const GrammarHomeScreen({super.key});

  @override
  State<GrammarHomeScreen> createState() => _GrammarHomeScreenState();
}

class _GrammarHomeScreenState extends State<GrammarHomeScreen> {
  final _grammarService = FirebaseGrammarService();
  final _progressService = FirebaseGrammarProgressService();
  
  String _selectedLevel = 'A1';
  List<GrammarUnit> _units = [];
  Map<String, dynamic> _stats = {};
  bool _isLoading = true;

  final List<String> _levels = ['A1', 'A2', 'B1', 'B2'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? '';
      
      // Use Firebase to get units by level
      // For now, using empty list until grammar_units collection is created
      final units = <GrammarUnit>[];
      
      // Load user statistics
      final stats = await _progressService.getUserStatistics(userId);

      setState(() {
        _units = units;
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading grammar data: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: CustomScrollView(
                slivers: [
                  // Level selector
                  SliverToBoxAdapter(
                    child: _buildLevelSelector(),
                  ),

                  // Progress overview
                  if (_stats.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildProgressOverview(),
                    ),

                  // Quick actions
                  SliverToBoxAdapter(
                    child: _buildQuickActions(),
                  ),

                  // Units list
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: _units.isEmpty
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 48),
                                  Icon(
                                    Icons.book_outlined,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No units available for $_selectedLevel',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final unit = _units[index];
                                return GrammarUnitCard(
                                  title: unit.title,
                                  description: unit.description,
                                  totalTopics: unit.totalTopics,
                                  completedTopics: unit.completedTopics,
                                  color: unit.color,
                                  icon: unit.icon,
                                  isLocked: unit.isLocked,
                                  onTap: () => _navigateToUnit(unit),
                                );
                              },
                              childCount: _units.length,
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildLevelSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chọn Cấp Độ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: _levels.map((level) {
              final isSelected = level == _selectedLevel;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _selectedLevel = level);
                      _loadData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      foregroundColor: isSelected ? Colors.white : Colors.black87,
                      elevation: isSelected ? 2 : 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      level,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressOverview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tiến Độ Của Bạn',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Chủ đề',
                '${_stats['totalTopicsCompleted'] ?? 0}',
                Icons.check_circle,
              ),
              _buildStatItem(
                'Bài tập',
                '${_stats['totalExercisesCompleted'] ?? 0}',
                Icons.edit_note,
              ),
              _buildStatItem(
                'Bài kiểm tra',
                '${_stats['totalTestsPassed'] ?? 0}',
                Icons.quiz,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hành Động Nhanh',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Continue Learning',
                  Icons.play_circle_outline,
                  Colors.green,
                  () {
                    // TODO: Navigate to last accessed topic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Continue learning - Coming soon')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'Daily Challenge',
                  Icons.star_outline,
                  Colors.orange,
                  () {
                    // TODO: Navigate to daily challenge
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Daily challenge - Coming soon')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToUnit(GrammarUnit unit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GrammarUnitDetailScreen(unit: unit),
      ),
    );
  }
}
