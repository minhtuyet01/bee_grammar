import 'package:flutter/material.dart';

class GrammarSection {
  final String id;
  final String title;
  final String? subtitle;
  final List<String> usage;
  final Map<String, String>? formulas;
  final List<String> examples;
  final List<String> commonMistakes;
  final Map<String, String>? tips;
  final String? comparison;

  const GrammarSection({
    required this.id,
    required this.title,
    this.subtitle,
    required this.usage,
    this.formulas,
    required this.examples,
    required this.commonMistakes,
    this.tips,
    this.comparison,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'usage': usage,
      'formulas': formulas,
      'examples': examples,
      'commonMistakes': commonMistakes,
      'tips': tips,
      'comparison': comparison,
    };
  }

  factory GrammarSection.fromJson(Map<String, dynamic> json) {
    return GrammarSection(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      usage: List<String>.from(json['usage'] as List),
      formulas: json['formulas'] != null
          ? Map<String, String>.from(json['formulas'] as Map)
          : null,
      examples: List<String>.from(json['examples'] as List),
      commonMistakes: List<String>.from(json['commonMistakes'] as List),
      tips: json['tips'] != null
          ? Map<String, String>.from(json['tips'] as Map)
          : null,
      comparison: json['comparison'] as String?,
    );
  }
}
