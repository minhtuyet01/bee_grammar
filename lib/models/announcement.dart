enum AnnouncementType {
  info,
  update,
  event,
  warning,
}

class Announcement {
  final String id;
  final String title;
  final String message;
  final AnnouncementType type;
  final String iconUrl;
  final String? actionLink;
  final DateTime? expiryDate;
  final DateTime createdAt;

  Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.iconUrl,
    this.actionLink,
    this.expiryDate,
    required this.createdAt,
  });

  bool get isExpired =>
      expiryDate != null && DateTime.now().isAfter(expiryDate!);

  bool get isActive => !isExpired;
}
