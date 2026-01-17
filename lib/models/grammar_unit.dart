import 'package:flutter/material.dart';
import 'grammar_topic.dart';

/// Represents a grammar learning unit (e.g., "Present Tenses")
class GrammarUnit {
  final String id;
  final String title;
  final String description;
  final String level; // A1, A2, B1, B2
  final int order;
  final List<GrammarTopic> topics;
  final String? unitTestId;
  final Color color;
  final IconData icon;
  final bool isLocked;

  const GrammarUnit({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.order,
    required this.topics,
    this.unitTestId,
    required this.color,
    required this.icon,
    this.isLocked = false,
  });

  // Progress tracking
  int get totalTopics => topics.length;
  int get completedTopics => topics.where((t) => t.isCompleted).length;
  double get progress => totalTopics > 0 ? completedTopics / totalTopics : 0.0;
  bool get isCompleted => completedTopics >= totalTopics;
  bool get canTakeTest => isCompleted && unitTestId != null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level,
      'order': order,
      'topics': topics.map((t) => t.toJson()).toList(),
      'unitTestId': unitTestId,
      'color': color.value,
      'isLocked': isLocked,
    };
  }

  factory GrammarUnit.fromJson(Map<String, dynamic> json) {
    return GrammarUnit(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      order: json['order'] as int,
      topics: (json['topics'] as List?)
              ?.map((t) => GrammarTopic.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
      unitTestId: json['unitTestId'] as String?,
      color: Color(json['color'] as int? ?? 0xFF2196F3),
      icon: Icons.book,
      isLocked: json['isLocked'] as bool? ?? false,
    );
  }

  GrammarUnit copyWith({
    String? id,
    String? title,
    String? description,
    String? level,
    int? order,
    List<GrammarTopic>? topics,
    String? unitTestId,
    Color? color,
    IconData? icon,
    bool? isLocked,
  }) {
    return GrammarUnit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      level: level ?? this.level,
      order: order ?? this.order,
      topics: topics ?? this.topics,
      unitTestId: unitTestId ?? this.unitTestId,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
