/// User persona types for personalized learning
enum UserPersona {
  beginner,   // Người mới bắt đầu
  working,    // Người đi làm
  student,    // Sinh viên
  child,      // Trẻ em (7-12 tuổi)
}

extension UserPersonaExtension on UserPersona {
  String get displayName {
    switch (this) {
      case UserPersona.beginner:
        return 'Người mới bắt đầu';
      case UserPersona.working:
        return 'Người đi làm';
      case UserPersona.student:
        return 'Sinh viên';
      case UserPersona.child:
        return 'Trẻ em';
    }
  }

  String get description {
    switch (this) {
      case UserPersona.beginner:
        return 'Chưa có nền tảng tiếng Anh, muốn học từ cơ bản';
      case UserPersona.working:
        return 'Cần tiếng Anh giao tiếp công việc, thời gian hạn chế';
      case UserPersona.student:
        return 'Cần tiếng Anh học thuật & giao tiếp';
      case UserPersona.child:
        return 'Học qua game, hình ảnh, nội dung vui nhộn';
    }
  }

  String get icon {
    switch (this) {
      case UserPersona.beginner:
        return '🌱';
      case UserPersona.working:
        return '💼';
      case UserPersona.student:
        return '🎓';
      case UserPersona.child:
        return '👶';
    }
  }

  String get suggestedLevel {
    switch (this) {
      case UserPersona.beginner:
        return 'A1';
      case UserPersona.working:
        return 'A2';
      case UserPersona.student:
        return 'B1';
      case UserPersona.child:
        return 'A1';
    }
  }
}

/// User profile with learning preferences and progress
class UserLearningProfile {
  final String userId;
  final UserPersona persona;
  final String cefrLevel; // "A1", "A2", "B1", "B2"
  final int totalXP;
  final int currentStreak;
  final int longestStreak;
  final int diamonds;
  final DateTime? lastStudyDate;
  final Map<String, bool> achievements; // achievement_id: unlocked
  final int dailyGoalMinutes;
  final bool hasCompletedOnboarding;

  UserLearningProfile({
    required this.userId,
    required this.persona,
    required this.cefrLevel,
    this.totalXP = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.diamonds = 0,
    this.lastStudyDate,
    this.achievements = const {},
    this.dailyGoalMinutes = 5,
    this.hasCompletedOnboarding = false,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'persona': persona.name,
        'cefrLevel': cefrLevel,
        'totalXP': totalXP,
        'currentStreak': currentStreak,
        'longestStreak': longestStreak,
        'diamonds': diamonds,
        'lastStudyDate': lastStudyDate?.toIso8601String(),
        'achievements': achievements,
        'dailyGoalMinutes': dailyGoalMinutes,
        'hasCompletedOnboarding': hasCompletedOnboarding,
      };

  factory UserLearningProfile.fromJson(Map<String, dynamic> json) => UserLearningProfile(
        userId: json['userId'],
        persona: UserPersona.values.firstWhere((e) => e.name == json['persona']),
        cefrLevel: json['cefrLevel'],
        totalXP: json['totalXP'] ?? 0,
        currentStreak: json['currentStreak'] ?? 0,
        longestStreak: json['longestStreak'] ?? 0,
        diamonds: json['diamonds'] ?? 0,
        lastStudyDate: json['lastStudyDate'] != null ? DateTime.parse(json['lastStudyDate']) : null,
        achievements: Map<String, bool>.from(json['achievements'] ?? {}),
        dailyGoalMinutes: json['dailyGoalMinutes'] ?? 5,
        hasCompletedOnboarding: json['hasCompletedOnboarding'] ?? false,
      );

  UserLearningProfile copyWith({
    UserPersona? persona,
    String? cefrLevel,
    int? totalXP,
    int? currentStreak,
    int? longestStreak,
    int? diamonds,
    DateTime? lastStudyDate,
    Map<String, bool>? achievements,
    int? dailyGoalMinutes,
    bool? hasCompletedOnboarding,
  }) {
    return UserLearningProfile(
      userId: userId,
      persona: persona ?? this.persona,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      totalXP: totalXP ?? this.totalXP,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      diamonds: diamonds ?? this.diamonds,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      achievements: achievements ?? this.achievements,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }
}
