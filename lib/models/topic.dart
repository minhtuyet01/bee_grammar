class Topic {
  final String id;
  final String title;
  final String description;
  final int orderIndex;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Optional fields
  final String? iconUrl;
  final String? coverImageUrl;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.orderIndex,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.iconUrl,
    this.coverImageUrl,
  });

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'orderIndex': orderIndex,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'iconUrl': iconUrl,
      'coverImageUrl': coverImageUrl,
    };
  }

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      orderIndex: json['orderIndex'] as int,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      iconUrl: json['iconUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
    );
  }

  // CopyWith method
  Topic copyWith({
    String? id,
    String? title,
    String? description,
    int? orderIndex,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? iconUrl,
    String? coverImageUrl,
  }) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iconUrl: iconUrl ?? this.iconUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Topic && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for sorting topics
extension TopicListExtension on List<Topic> {
  List<Topic> sortByOrderIndex() {
    final sorted = List<Topic>.from(this);
    sorted.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return sorted;
  }

  List<Topic> activeOnly() {
    return where((topic) => topic.isActive).toList();
  }
}
