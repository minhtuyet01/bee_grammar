import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/practice_service.dart';
import '../../data/service_locator.dart';
import 'practice_session_screen.dart';
import 'topic_selection_screen.dart';


class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final _practiceService = PracticeService();
  bool _dailyChallengeCompleted = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final completed = await _practiceService.isDailyChallengeCompletedToday(userId);
      setState(() {
        _dailyChallengeCompleted = completed;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _startDailyChallenge() async {
    final questions = await _practiceService.getDailyChallengeQuestions();
    
    if (!mounted) return;
    
    // Check if questions are available
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Chưa có câu hỏi nào trong hệ thống. Vui lòng thử lại sau.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PracticeSessionScreen(
          practiceType: 'daily',
          title: 'Thử thách hàng ngày',
          questions: questions,
        ),
      ),
    ).then((_) => _loadData());
  }

  Future<void> _startMixedReview() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final questions = await _practiceService.getMixedReviewQuestions(
      userId: userId,
      count: 20,
    );

    if (!mounted) return;

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hãy hoàn thành một số bài học trước')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PracticeSessionScreen(
          practiceType: 'mixed',
          title: 'Luyện tập tổng hợp',
          questions: questions,
        ),
      ),
    ).then((_) => _loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily Challenge
                  _buildSectionCard(
                    context,
                    title: 'Thử Thách Hàng Ngày',
                    subtitle: '10 câu hỏi ngẫu nhiên',
                    icon: Icons.star,
                    color: Colors.amber,
                    completed: _dailyChallengeCompleted,
                    onTap: _dailyChallengeCompleted
                        ? null
                        : _startDailyChallenge,
                  ),
                  const SizedBox(height: 16),

                  // Grammar Practice (renamed from Topic Deep Dive)
                  _buildSectionCard(
                    context,
                    title: 'Luyện Tập Ngữ Pháp',
                    subtitle: 'Luyện tập theo chủ đề ngữ pháp',
                    icon: Icons.book,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TopicSelectionScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Mixed Practice
                  _buildSectionCard(
                    context,
                    title: 'Luyện Tập Tổng Hợp',
                    subtitle: 'Luyện tập không giới hạn',
                    icon: Icons.shuffle,
                    color: Colors.green,
                    onTap: _startMixedReview,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    bool completed = false,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(
          opacity: completed ? 0.6 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        completed ? 'Đã hoàn thành hôm nay' : subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: completed ? Colors.green : Colors.grey[600],
                          fontWeight: completed ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  completed ? Icons.check_circle : Icons.arrow_forward_ios,
                  size: 20,
                  color: completed ? Colors.green : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
