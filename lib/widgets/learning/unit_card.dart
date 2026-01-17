import 'package:flutter/material.dart';
import '../../models/unit.dart';

class UnitCard extends StatelessWidget {
  final Unit unit;
  final VoidCallback? onTap;

  const UnitCard({
    super.key,
    required this.unit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: unit.isLocked ? null : onTap,
        child: Stack(
          children: [
            // Background gradient
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    unit.color.withOpacity(0.1),
                    unit.color.withOpacity(0.05),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: unit.isLocked
                          ? Colors.grey.shade300
                          : unit.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: unit.isLocked ? Colors.grey.shade400 : unit.color,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: unit.isLocked
                          ? Icon(Icons.lock, size: 40, color: Colors.grey.shade600)
                          : Text(
                              unit.iconUrl,
                              style: const TextStyle(fontSize: 40),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Text(
                          unit.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: unit.isLocked ? Colors.grey.shade600 : null,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Description
                        Text(
                          unit.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: unit.isLocked ? Colors.grey.shade500 : Colors.grey.shade700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),

                        // Progress bar
                        if (!unit.isLocked) ...[
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: unit.progress,
                                    minHeight: 6,
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor: AlwaysStoppedAnimation<Color>(unit.color),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${unit.completedLessons}/${unit.totalLessons}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock, size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 6),
                                Text(
                                  'Hoàn thành unit trước',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Chevron
                  if (!unit.isLocked)
                    Icon(
                      Icons.chevron_right,
                      color: unit.color,
                      size: 32,
                    ),
                ],
              ),
            ),

            // Completed badge
            if (unit.isCompleted)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Hoàn thành',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
