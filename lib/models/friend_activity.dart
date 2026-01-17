enum ActivityType {
  lessonCompleted,
  achievementUnlocked,
  streakMilestone,
  quizPassed,
}

class FriendActivity {
  final String friendId;
  final String friendName;
  final String friendAvatar;
  final ActivityType type;
  final String description;
  final DateTime timestamp;

  FriendActivity({
    required this.friendId,
    required this.friendName,
    required this.friendAvatar,
    required this.type,
    required this.description,
    required this.timestamp,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inDays > 0) return '${diff.inDays} ngày trước';
    if (diff.inHours > 0) return '${diff.inHours} giờ trước';
    if (diff.inMinutes > 0) return '${diff.inMinutes} phút trước';
    return 'Vừa xong';
  }

  String get icon {
    switch (type) {
      case ActivityType.lessonCompleted:
        return '📚';
      case ActivityType.achievementUnlocked:
        return '🏆';
      case ActivityType.streakMilestone:
        return '🔥';
      case ActivityType.quizPassed:
        return '✅';
    }
  }
}
