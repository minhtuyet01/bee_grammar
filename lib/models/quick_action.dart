import 'package:flutter/material.dart';

enum QuickActionType {
  practice,
  review,
  challenge,
  shop,
  stats,
}

class QuickAction {
  final QuickActionType type;
  final String title;
  final IconData icon;
  final Color color;
  final int? badgeCount;
  final VoidCallback? onTap;

  QuickAction({
    required this.type,
    required this.title,
    required this.icon,
    required this.color,
    this.badgeCount,
    this.onTap,
  });

  static List<QuickAction> getDefaultActions() => [
        QuickAction(
          type: QuickActionType.practice,
          title: 'Luyện tập',
          icon: Icons.fitness_center,
          color: Colors.orange,
        ),
        QuickAction(
          type: QuickActionType.review,
          title: 'Ôn tập',
          icon: Icons.replay,
          color: Colors.blue,
          badgeCount: 5,
        ),
        QuickAction(
          type: QuickActionType.challenge,
          title: 'Thử thách',
          icon: Icons.emoji_events,
          color: Colors.purple,
        ),
        QuickAction(
          type: QuickActionType.shop,
          title: 'Cửa hàng',
          icon: Icons.shopping_bag,
          color: Colors.green,
        ),
        QuickAction(
          type: QuickActionType.stats,
          title: 'Thống kê',
          icon: Icons.bar_chart,
          color: Colors.teal,
        ),
      ];
}
