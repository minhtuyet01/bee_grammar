enum RewardType {
  diamonds,
  points,
  item,
  badge,
}

class DailyReward {
  final int day;
  final RewardType type;
  final int amount;
  final String? itemName;
  final String? itemIcon;
  final bool isClaimed;
  final bool isStreakBonus;

  DailyReward({
    required this.day,
    required this.type,
    required this.amount,
    this.itemName,
    this.itemIcon,
    this.isClaimed = false,
    this.isStreakBonus = false,
  });

  String get displayText {
    switch (type) {
      case RewardType.diamonds:
        return '$amount 💎';
      case RewardType.points:
        return '$amount ⭐';
      case RewardType.item:
        return itemName ?? 'Item';
      case RewardType.badge:
        return itemName ?? 'Badge';
    }
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'type': type.name,
        'amount': amount,
        'itemName': itemName,
        'itemIcon': itemIcon,
        'isClaimed': isClaimed,
        'isStreakBonus': isStreakBonus,
      };

  factory DailyReward.fromJson(Map<String, dynamic> json) => DailyReward(
        day: json['day'] as int,
        type: RewardType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => RewardType.points,
        ),
        amount: json['amount'] as int,
        itemName: json['itemName'] as String?,
        itemIcon: json['itemIcon'] as String?,
        isClaimed: json['isClaimed'] as bool? ?? false,
        isStreakBonus: json['isStreakBonus'] as bool? ?? false,
      );
}

class DailyRewardCalendar {
  final List<DailyReward> rewards;
  final int currentStreak;
  final DateTime lastClaimDate;

  DailyRewardCalendar({
    required this.rewards,
    required this.currentStreak,
    required this.lastClaimDate,
  });

  bool get canClaimToday {
    final now = DateTime.now();
    return now.difference(lastClaimDate).inDays >= 1;
  }

  DailyReward? get todayReward {
    final dayIndex = (currentStreak % rewards.length);
    return dayIndex < rewards.length ? rewards[dayIndex] : null;
  }

  int get totalDiamonds =>
      rewards.where((r) => r.isClaimed && r.type == RewardType.diamonds).fold(
            0,
            (sum, r) => sum + r.amount,
          );

  Map<String, dynamic> toJson() => {
        'rewards': rewards.map((r) => r.toJson()).toList(),
        'currentStreak': currentStreak,
        'lastClaimDate': lastClaimDate.toIso8601String(),
      };

  factory DailyRewardCalendar.fromJson(Map<String, dynamic> json) =>
      DailyRewardCalendar(
        rewards: (json['rewards'] as List<dynamic>)
            .map((e) => DailyReward.fromJson(e as Map<String, dynamic>))
            .toList(),
        currentStreak: json['currentStreak'] as int,
        lastClaimDate: DateTime.parse(json['lastClaimDate'] as String),
      );
}
