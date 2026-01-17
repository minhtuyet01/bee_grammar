import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/service_locator.dart';
import 'test_category_selection_screen.dart';
import 'test_level_selection_screen.dart';
import 'mock_exam_list_screen.dart';
import 'random_test_start_screen.dart';
import 'learning_history_screen.dart';
import '../../utils/page_transitions.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unit Test
            // Unit Test
            _buildTestCard(
              context,
              icon: Icons.book,
              title: 'Kiểm tra đơn vị',
              description: 'Kiểm tra từng chủ đề ngữ pháp cụ thể',
              questionCount: 15,
              timeLimit: 15,
              color: const Color(0xFFD4A574),
              onTap: () {
                PageTransitions.push(
                  context,
                  const TestCategorySelectionScreen(),
                  type: TransitionType.slideRight,
                );
              },
            ),
            const SizedBox(height: 12),
            _buildTestCard(
              context,
              icon: Icons.trending_up,
              title: 'Kiểm tra cấp độ',
              description: 'Kiểm tra theo trình độ: Cơ bản, Trung cấp, Nâng cao',
              questionCount: 30,
              timeLimit: 40, // Average time
              color: Colors.blue,
              onTap: () {
                PageTransitions.push(
                  context,
                  const TestLevelSelectionScreen(),
                  type: TransitionType.slideRight,
                );
              },
            ),
            const SizedBox(height: 12),
            _buildTestCard(
              context,
              icon: Icons.assignment,
              title: 'Đề thi thử',
              description: '6 đề cố định',
              questionCount: 20,
              timeLimit: 30,
              color: Colors.purple,
              onTap: () {
                PageTransitions.push(
                  context,
                  const MockExamListScreen(),
                  type: TransitionType.slideRight,
                );
              },
            ),
            const SizedBox(height: 12),
            _buildTestCard(
              context,
              icon: Icons.shuffle,
              title: 'Đề ngẫu nhiên',
              description: 'Luyện tập linh hoạt',
              questionCount: 20,
              timeLimit: 20, // Default for display
              color: Colors.orange,
              onTap: () {
                PageTransitions.push(
                  context,
                  const RandomTestStartScreen(),
                  type: TransitionType.slideRight,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required int questionCount,
    required int timeLimit,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
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
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
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
                        const SizedBox(height: 2),
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
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Bắt đầu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
