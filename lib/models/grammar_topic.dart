import 'package:flutter/material.dart';
import 'grammar_section.dart';
import 'grammar_example.dart';

class GrammarTopic {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<GrammarSection> sections;
  final double progress;
  final int totalSections;
  
  // New fields for enhanced grammar learning
  final String? theoryContent; // Markdown content
  final List<GrammarExample> examples;
  final List<String> exerciseIds;
  final bool isCompleted;

  const GrammarTopic({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.sections,
    this.progress = 0.0,
    int? totalSections,
    this.theoryContent,
    this.examples = const [],
    this.exerciseIds = const [],
    this.isCompleted = false,
  }) : totalSections = totalSections ?? sections.length;

  int get totalExercises => exerciseIds.length;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sections': sections.map((s) => s.toJson()).toList(),
      'progress': progress,
      'totalSections': totalSections,
      'theoryContent': theoryContent,
      'examples': examples.map((e) => e.toJson()).toList(),
      'exerciseIds': exerciseIds,
      'isCompleted': isCompleted,
    };
  }

  factory GrammarTopic.fromJson(Map<String, dynamic> json) {
    return GrammarTopic(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: Icons.book, // Default icon
      color: Colors.blue, // Default color
      sections: (json['sections'] as List?)
              ?.map((s) => GrammarSection.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      totalSections: json['totalSections'] as int?,
      theoryContent: json['theoryContent'] as String?,
      examples: (json['examples'] as List?)
              ?.map((e) => GrammarExample.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      exerciseIds: (json['exerciseIds'] as List?)?.cast<String>() ?? [],
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  GrammarTopic copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    List<GrammarSection>? sections,
    double? progress,
    int? totalSections,
    String? theoryContent,
    List<GrammarExample>? examples,
    List<String>? exerciseIds,
    bool? isCompleted,
  }) {
    return GrammarTopic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      sections: sections ?? this.sections,
      progress: progress ?? this.progress,
      totalSections: totalSections ?? this.totalSections,
      theoryContent: theoryContent ?? this.theoryContent,
      examples: examples ?? this.examples,
      exerciseIds: exerciseIds ?? this.exerciseIds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
