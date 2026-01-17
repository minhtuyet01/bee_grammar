class Example {
  final String id;
  final String sentence;
  final String translation;
  final String? explanation;
  final String? audioUrl;

  Example({
    required this.id,
    required this.sentence,
    required this.translation,
    this.explanation,
    this.audioUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sentence': sentence,
      'translation': translation,
      'explanation': explanation,
      'audioUrl': audioUrl,
    };
  }

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      id: json['id'] as String,
      sentence: json['sentence'] as String,
      translation: json['translation'] as String,
      explanation: json['explanation'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );
  }

  Example copyWith({
    String? id,
    String? sentence,
    String? translation,
    String? explanation,
    String? audioUrl,
  }) {
    return Example(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
      translation: translation ?? this.translation,
      explanation: explanation ?? this.explanation,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Example && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Lesson {
  final String id;
  final String topicId;
  final String title;
  final String theoryContent;
  final List<Example> examples;
  final int orderIndex;
  final int estimatedMinutes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lesson({
    required this.id,
    required this.topicId,
    required this.title,
    required this.theoryContent,
    required this.examples,
    required this.orderIndex,
    this.estimatedMinutes = 15,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  // Get example count
  int get exampleCount => examples.length;

  // Check if lesson has examples
  bool get hasExamples => examples.isNotEmpty;

  // Get examples with audio
  List<Example> get examplesWithAudio {
    return examples.where((e) => e.audioUrl != null).toList();
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'title': title,
      'theoryContent': theoryContent,
      'examples': examples.map((e) => e.toJson()).toList(),
      'orderIndex': orderIndex,
      'estimatedMinutes': estimatedMinutes,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      topicId: json['topicId'] as String,
      title: json['title'] as String,
      theoryContent: json['theoryContent'] as String,
      examples: (json['examples'] as List<dynamic>)
          .map((e) => Example.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderIndex: json['orderIndex'] as int,
      estimatedMinutes: json['estimatedMinutes'] as int? ?? 15,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // CopyWith method
  Lesson copyWith({
    String? id,
    String? topicId,
    String? title,
    String? theoryContent,
    List<Example>? examples,
    int? orderIndex,
    int? estimatedMinutes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      title: title ?? this.title,
      theoryContent: theoryContent ?? this.theoryContent,
      examples: examples ?? this.examples,
      orderIndex: orderIndex ?? this.orderIndex,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lesson && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for sorting lessons
extension LessonListExtension on List<Lesson> {
  List<Lesson> sortByOrderIndex() {
    final sorted = List<Lesson>.from(this);
    sorted.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return sorted;
  }

  List<Lesson> activeOnly() {
    return where((lesson) => lesson.isActive).toList();
  }

  List<Lesson> byTopic(String topicId) {
    return where((lesson) => lesson.topicId == topicId).toList();
  }
}
