import 'package:flutter/material.dart';

/// Represents a learning unit in the CEFR-based curriculum
class Unit {
  final String id;
  final String title;
  final String description;
  final int order;
  final String level; // "A1", "A2", "B1", "B2"
  final List<String> vocabulary;
  final List<String> grammar;
  final String iconUrl; // Emoji or icon
  final Color color;
  final bool isLocked;
  final int totalLessons;
  final int completedLessons;

  Unit({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.level,
    required this.vocabulary,
    required this.grammar,
    required this.iconUrl,
    required this.color,
    this.isLocked = false,
    required this.totalLessons,
    this.completedLessons = 0,
  });

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0.0;
  
  bool get isCompleted => completedLessons >= totalLessons;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'order': order,
        'level': level,
        'vocabulary': vocabulary,
        'grammar': grammar,
        'iconUrl': iconUrl,
        'color': color.value,
        'isLocked': isLocked,
        'totalLessons': totalLessons,
        'completedLessons': completedLessons,
      };

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        order: json['order'],
        level: json['level'],
        vocabulary: List<String>.from(json['vocabulary']),
        grammar: List<String>.from(json['grammar']),
        iconUrl: json['iconUrl'],
        color: Color(json['color']),
        isLocked: json['isLocked'] ?? false,
        totalLessons: json['totalLessons'],
        completedLessons: json['completedLessons'] ?? 0,
      );
}
