import 'package:flutter/material.dart';
import '../../data/service_locator.dart';
import '../../models/user.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await ServiceLocator().authService.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhiệm vụ'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Daily tasks section
          _buildSectionHeader('Nhiệm vụ hàng ngày', Icons.today),
          const SizedBox(height: 12),
          _buildTaskCard(
            title: 'Hoàn thành 1 bài học',
            description: 'Học ít nhất 1 bài trong ngày',
            progress: 0,
            total: 1,
            reward: 50,
            icon: Icons.school,
            color: Colors.blue,
          ),
          _buildTaskCard(
            title: 'Đạt 80% trong quiz',
            description: 'Trả lời đúng ít nhất 80% câu hỏi',
            progress: 0,
            total: 1,
            reward: 100,
            icon: Icons.quiz,
            color: Colors.green,
          ),
          _buildTaskCard(
            title: 'Học liên tục 3 ngày',
            description: 'Duy trì chuỗi học tập',
            progress: 1,
            total: 3,
            reward: 200,
            icon: Icons.local_fire_department,
            color: Colors.orange,
          ),
          const SizedBox(height: 24),

          // Weekly tasks section
          _buildSectionHeader('Nhiệm vụ tuần', Icons.calendar_month),
          const SizedBox(height: 12),
          _buildTaskCard(
            title: 'Hoàn thành 5 bài học',
            description: 'Học 5 bài trong tuần này',
            progress: 0,
            total: 5,
            reward: 300,
            icon: Icons.book,
            color: Colors.purple,
          ),
          _buildTaskCard(
            title: 'Đạt điểm hoàn hảo',
            description: 'Đạt 100% trong 1 quiz bất kỳ',
            progress: 0,
            total: 1,
            reward: 500,
            icon: Icons.emoji_events,
            color: Colors.amber,
          ),
          const SizedBox(height: 24),

          // Completed tasks section
          _buildSectionHeader('Nhiệm vụ đã hoàn thành', Icons.check_circle_outline),
          const SizedBox(height: 12),
          _buildCompletedTasksList(),
        ],
      ),
    );
  }

  Widget _buildCompletedTasksList() {
    // Mock completed tasks data
    final completedTasks = [
      {
        'title': 'Hoàn thành 1 bài học',
        'completedAt': 'Hôm nay, 9:30',
        'reward': 50,
        'icon': Icons.school,
        'color': Colors.blue,
      },
      {
        'title': 'Học liên tục 3 ngày',
        'completedAt': 'Hôm qua, 14:20',
        'reward': 200,
        'icon': Icons.local_fire_department,
        'color': Colors.orange,
      },
      {
        'title': 'Đạt 80% trong quiz',
        'completedAt': '2 ngày trước',
        'reward': 100,
        'icon': Icons.quiz,
        'color': Colors.green,
      },
    ];

    if (completedTasks.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.task_alt,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Chưa có nhiệm vụ nào hoàn thành',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: completedTasks.map((task) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (task['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                task['icon'] as IconData,
                color: task['color'] as Color,
                size: 24,
              ),
            ),
            title: Text(
              task['title'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              task['completedAt'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars, color: Colors.amber[700], size: 16),
                const SizedBox(width: 4),
                Text(
                  '+${task['reward']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.amber[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String description,
    required int progress,
    required int total,
    required int reward,
    required IconData icon,
    required Color color,
  }) {
    final isCompleted = progress >= total;
    final progressPercent = total > 0 ? (progress / total) : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green[700], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Hoàn thành',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressPercent,
                minHeight: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 8),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$progress/$total',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.stars, color: Colors.amber[700], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '+$reward PNT',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.amber[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
