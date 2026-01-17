import 'package:flutter/material.dart';

/// Grammar Category - Nhóm nội dung ngữ pháp
class GrammarCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int order;
  final List<String> lessonIds; // IDs of lessons in this category

  const GrammarCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.order,
    required this.lessonIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon.codePoint,
      'color': color.value,
      'order': order,
      'lessonIds': lessonIds,
    };
  }

  factory GrammarCategory.fromJson(Map<String, dynamic> json) {
    return GrammarCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
      color: Color(json['color'] as int),
      order: json['order'] as int,
      lessonIds: List<String>.from(json['lessonIds'] as List),
    );
  }
}

/// Grammar Lesson - Bài học ngữ pháp
class GrammarLesson {
  final String id;
  final String categoryId;
  final String title;
  final String objective; // Mục tiêu bài học
  final String theory; // Lý thuyết ngắn gọn
  final List<String> formulas; // Công thức ngữ pháp
  final List<String>? notes; // Chú thích cho công thức
  final List<String> usages; // Cách dùng
  final List<GrammarExample> examples; // Ví dụ minh họa
  final List<String>? recognitionSigns; // Dấu hiệu nhận biết
  final List<String> commonMistakes; // Lỗi sai thường gặp
  final List<GrammarExerciseItem> exercises; // Bài tập
  final int order;

  const GrammarLesson({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.objective,
    required this.theory,
    required this.formulas,
    this.notes,
    required this.usages,
    required this.examples,
    this.recognitionSigns,
    required this.commonMistakes,
    required this.exercises,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'objective': objective,
      'theory': theory,
      'formulas': formulas,
      'notes': notes,
      'usages': usages,
      'examples': examples.map((e) => e.toJson()).toList(),
      'recognitionSigns': recognitionSigns,
      'commonMistakes': commonMistakes,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'order': order,
    };
  }

  factory GrammarLesson.fromJson(Map<String, dynamic> json) {
    return GrammarLesson(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      title: json['title'] as String,
      objective: json['objective'] as String,
      theory: json['theory'] as String,
      formulas: List<String>.from(json['formulas'] as List),
      notes: json['notes'] != null ? List<String>.from(json['notes'] as List) : null,
      usages: List<String>.from(json['usages'] as List),
      examples: (json['examples'] as List)
          .map((e) => GrammarExample.fromJson(e as Map<String, dynamic>))
          .toList(),
      recognitionSigns: json['recognitionSigns'] != null ? List<String>.from(json['recognitionSigns'] as List) : null,
      commonMistakes: List<String>.from(json['commonMistakes'] as List),
      exercises: (json['exercises'] as List)
          .map((e) => GrammarExerciseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      order: json['order'] as int,
    );
  }
}

/// Grammar Example - Ví dụ minh họa
class GrammarExample {
  final String english;
  final String vietnamese;
  final String? note; // Ghi chú thêm

  const GrammarExample({
    required this.english,
    required this.vietnamese,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'vietnamese': vietnamese,
      'note': note,
    };
  }

  factory GrammarExample.fromJson(Map<String, dynamic> json) {
    return GrammarExample(
      english: json['english'] as String,
      vietnamese: json['vietnamese'] as String,
      note: json['note'] as String?,
    );
  }
}

/// Grammar Exercise Item - Câu hỏi bài tập
class GrammarExerciseItem {
  final String id;
  final ExerciseType type; // MCQ, FillInBlank, or DragAndDrop
  final String question;
  final List<String>? options; // For MCQ
  final List<String>? wordBank; // For Drag & Drop (shuffled words)
  final String correctAnswer;
  final String? explanation;

  const GrammarExerciseItem({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.wordBank,
    required this.correctAnswer,
    this.explanation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'question': question,
      'options': options,
      'wordBank': wordBank,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
    };
  }

  factory GrammarExerciseItem.fromJson(Map<String, dynamic> json) {
    return GrammarExerciseItem(
      id: json['id'] as String,
      type: ExerciseType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => ExerciseType.multipleChoice,
      ),
      question: json['question'] as String,
      options: json['options'] != null
          ? List<String>.from(json['options'] as List)
          : null,
      wordBank: json['wordBank'] != null
          ? List<String>.from(json['wordBank'] as List)
          : null,
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String?,
    );
  }
}

enum ExerciseType {
  multipleChoice,
  fillInBlank,
  dragAndDrop,
}
