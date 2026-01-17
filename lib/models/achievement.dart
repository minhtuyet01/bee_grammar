class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int currentProgress;
  final int targetProgress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    this.isUnlocked = false,
    this.unlockedAt,
    this.currentProgress = 0,
    this.targetProgress = 1,
  });

  double get progressPercentage =>
      targetProgress > 0 ? (currentProgress / targetProgress).clamp(0.0, 1.0) : 0.0;

  bool get isInProgress => !isUnlocked && currentProgress > 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'iconUrl': iconUrl,
        'isUnlocked': isUnlocked,
        'unlockedAt': unlockedAt?.toIso8601String(),
        'currentProgress': currentProgress,
        'targetProgress': targetProgress,
      };

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        iconUrl: json['iconUrl'] as String,
        isUnlocked: json['isUnlocked'] as bool? ?? false,
        unlockedAt: json['unlockedAt'] != null
            ? DateTime.parse(json['unlockedAt'] as String)
            : null,
        currentProgress: json['currentProgress'] as int? ?? 0,
        targetProgress: json['targetProgress'] as int? ?? 1,
      );
}
