import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/learning_history_service.dart';
import '../../data/firebase_user_progress_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final _service = LearningHistoryService();
  final _progressService = FirebaseUserProgressService();

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê'),
        backgroundColor: const Color(0xFFD4A574),
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _service.streamStatistics(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi: ${snapshot.error}'),
            );
          }

          final stats = snapshot.data ?? {};
          final totalLessons = stats['totalLessonsCompleted'] ?? 0;

          if (totalLessons == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có dữ liệu thống kê',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hoàn thành bài học đầu tiên để xem thống kê',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Streak Card (Prominent)
                _buildStreakCard(userId),
                const SizedBox(height: 24),

                // Summary cards
                _buildSectionHeader('Tổng quan', Icons.dashboard),
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.book,
                        label: 'Bài đã học',
                        value: '${stats['totalLessonsCompleted'] ?? 0}',
                        color: const Color(0xFFD4A574),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.quiz,
                        label: 'Bài tập',
                        value: '${stats['totalExercisesCompleted'] ?? 0}',
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.percent,
                        label: 'Điểm TB',
                        value: '${stats['averageScore'] ?? 0}%',
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.access_time,
                        label: 'Thời gian',
                        value: _formatTime(stats['totalTimeSpent'] ?? 0),
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Accuracy
                _buildSectionHeader('Độ chính xác', Icons.check_circle),
                const SizedBox(height: 12),
                _buildAccuracyCard(stats),
                const SizedBox(height: 24),
                
                // Progress by category
                _buildSectionHeader('Tiến độ theo chủ đề', Icons.category),
                const SizedBox(height: 12),
                _buildCategoryProgress(stats['categoriesProgress'] ?? {}),
                
                const SizedBox(height: 24),
                
                // Weak topics
                _buildSectionHeader('Chủ đề cần cải thiện', Icons.warning_amber),
                const SizedBox(height: 12),
                _buildWeakTopics(stats['categoriesProgress'] ?? {}),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color(0xFFD4A574)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard(String userId) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _progressService.streamUserProgress(userId),
      builder: (context, snapshot) {
        final progress = snapshot.data ?? {};
        final streak = progress['streak'] ?? 0;
        final lastStudyDate = progress['lastStudyDate'] as DateTime?;
        
        final isActive = lastStudyDate != null &&
            DateTime.now().difference(lastStudyDate).inDays < 1;

        return Card(
          elevation: 4,
          color: const Color(0xFFD4A574).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.orange : Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_fire_department,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Streak hiện tại',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$streak ngày',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4A574),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isActive ? '🔥 Đang hoạt động' : '💤 Chưa học hôm nay',
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccuracyCard(Map<String, dynamic> stats) {
    final correct = stats['totalCorrectAnswers'] ?? 0;
    final total = stats['totalQuestions'] ?? 1;
    final accuracy = total > 0 ? (correct / total * 100).round() : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tỷ lệ trả lời đúng',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '$accuracy%',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _getAccuracyColor(accuracy),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: accuracy / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(_getAccuracyColor(accuracy)),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đúng: $correct',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                Text(
                  'Tổng: $total',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProgress(Map<String, dynamic> categoriesProgress) {
    final categories = {
      'cat_1': {'title': '12 Thì Cơ Bản', 'total': 12, 'color': Colors.blue},
      'cat_2': {'title': 'Câu Điều Kiện', 'total': 4, 'color': Colors.green},
      'cat_3': {'title': 'Câu Bị Động', 'total': 3, 'color': Colors.orange},
      'cat_4': {'title': 'Mệnh Đề Quan Hệ', 'total': 4, 'color': Colors.purple},
      'cat_5': {'title': 'Câu Gián Tiếp', 'total': 3, 'color': Colors.red},
    };

    return Column(
      children: categories.entries.map((entry) {
        final catId = entry.key;
        final catData = entry.value;
        final progress = categoriesProgress[catId] ?? {};
        final completed = progress['completed'] ?? 0;
        final total = catData['total'] as int;
        final percentage = total > 0 ? (completed / total * 100).round() : 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        catData['title'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '$completed/$total',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: total > 0 ? completed / total : 0,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(catData['color'] as Color),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$percentage% hoàn thành',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (percentage == 100)
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeakTopics(Map<String, dynamic> categoriesProgress) {
    final categories = {
      'cat_1': {'title': '12 Thì Cơ Bản', 'total': 12},
      'cat_2': {'title': 'Câu Điều Kiện', 'total': 4},
      'cat_3': {'title': 'Câu Bị Động', 'total': 3},
      'cat_4': {'title': 'Mệnh Đề Quan Hệ', 'total': 4},
      'cat_5': {'title': 'Câu Gián Tiếp', 'total': 3},
    };

    // Find topics with < 50% completion
    final weakTopics = categories.entries.where((entry) {
      final progress = categoriesProgress[entry.key] ?? {};
      final completed = progress['completed'] ?? 0;
      final total = entry.value['total'] as int;
      final percentage = total > 0 ? (completed / total * 100) : 0;
      return percentage < 50 && completed > 0;
    }).toList();

    if (weakTopics.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.emoji_events, color: Colors.green, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tuyệt vời! Bạn đang học tốt tất cả chủ đề',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: weakTopics.map((entry) {
        final catData = entry.value;
        final progress = categoriesProgress[entry.key] ?? {};
        final completed = progress['completed'] ?? 0;
        final total = catData['total'] as int;
        final percentage = total > 0 ? (completed / total * 100).round() : 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.orange.withOpacity(0.1),
          child: ListTile(
            leading: const Icon(Icons.trending_down, color: Colors.orange),
            title: Text(
              catData['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('$percentage% hoàn thành'),
            trailing: Text(
              '$completed/$total',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getAccuracyColor(int accuracy) {
    if (accuracy >= 80) return Colors.green;
    if (accuracy >= 60) return Colors.orange;
    return Colors.red;
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}p';
    } else if (minutes > 0) {
      return '${minutes}p';
    }
    return '${seconds}s';
  }
}
