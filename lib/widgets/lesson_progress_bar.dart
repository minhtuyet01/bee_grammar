import 'package:flutter/material.dart';

class LessonProgressBar extends StatelessWidget {
  final int progressPercentage;
  final bool showLabel;

  const LessonProgressBar({
    super.key,
    required this.progressPercentage,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiến độ bài học',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFD4A574), // App theme color
                  ),
                ),
                Text(
                  '$progressPercentage%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getProgressColor(progressPercentage),
                  ),
                ),
              ],
            ),
          ),
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          child: Stack(
            children: [
              // Filled portion
              FractionallySizedBox(
                widthFactor: progressPercentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: _getProgressColor(progressPercentage),
                  ),
                ),
              ),
              // Completion checkmark
              if (progressPercentage == 100)
                Positioned(
                  right: 4,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(int percentage) {
    if (percentage == 100) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    if (percentage >= 40) return Colors.amber;
    return Colors.grey[700]!;
  }
}
