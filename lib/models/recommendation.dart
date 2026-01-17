enum RecommendationType {
  lesson,
  quiz,
  topic,
}

class Recommendation {
  final String id;
  final RecommendationType type;
  final String title;
  final String description;
  final String iconUrl;
  final String reason;
  final int priority;

  Recommendation({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.reason,
    this.priority = 0,
  });

  String get typeLabel {
    switch (type) {
      case RecommendationType.lesson:
        return 'Bài học';
      case RecommendationType.quiz:
        return 'Quiz';
      case RecommendationType.topic:
        return 'Chủ đề';
    }
  }
}
