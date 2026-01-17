import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/grammar_lesson.dart';

/// Service for fetching grammar lessons from Firebase
class FirebaseGrammarLessonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all grammar categories
  Future<List<GrammarCategory>> getCategories() async {
    try {
      final snapshot = await _firestore
          .collection('grammar_categories')
          .orderBy('order')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return GrammarCategory(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
          color: Color(data['color']),
          order: data['order'],
          lessonIds: List<String>.from(data['lessonIds']),
        );
      }).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  /// Get all grammar lessons
  Future<List<GrammarLesson>> getLessons() async {
    try {
      final snapshot = await _firestore
          .collection('grammar_lessons')
          .orderBy('order')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return GrammarLesson(
          id: data['id'],
          categoryId: data['categoryId'],
          title: data['title'],
          objective: data['objective'],
          theory: data['theory'],
          formulas: List<String>.from(data['formulas']),
          notes: data['notes'] != null ? List<String>.from(data['notes']) : null,
          usages: List<String>.from(data['usages']),
          examples: (data['examples'] as List).map((e) => GrammarExample(
            english: e['english'],
            vietnamese: e['vietnamese'],
            note: e['note'],
          )).toList(),
          recognitionSigns: data['recognitionSigns'] != null 
              ? List<String>.from(data['recognitionSigns']) 
              : null,
          commonMistakes: List<String>.from(data['commonMistakes']),
          exercises: (data['exercises'] as List).map((e) => GrammarExerciseItem(
            id: e['id'],
            type: ExerciseType.values.firstWhere(
              (type) => type.toString() == e['type'],
              orElse: () => ExerciseType.multipleChoice,
            ),
            question: e['question'],
            options: e['options'] != null ? List<String>.from(e['options']) : null,
            wordBank: e['wordBank'] != null ? List<String>.from(e['wordBank']) : null,
            correctAnswer: e['correctAnswer'],
            explanation: e['explanation'],
          )).toList(),
          order: data['order'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching lessons: $e');
      return [];
    }
  }

  /// Get lessons by category
  Future<List<GrammarLesson>> getLessonsByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('grammar_lessons')
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('order') // Uses Firestore index for better performance
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return GrammarLesson(
          id: data['id'],
          categoryId: data['categoryId'],
          title: data['title'],
          objective: data['objective'],
          theory: data['theory'],
          formulas: List<String>.from(data['formulas']),
          notes: data['notes'] != null ? List<String>.from(data['notes']) : null,
          usages: List<String>.from(data['usages']),
          examples: (data['examples'] as List).map((e) => GrammarExample(
            english: e['english'],
            vietnamese: e['vietnamese'],
            note: e['note'],
          )).toList(),
          recognitionSigns: data['recognitionSigns'] != null 
              ? List<String>.from(data['recognitionSigns']) 
              : null,
          commonMistakes: List<String>.from(data['commonMistakes']),
          exercises: (data['exercises'] as List).map((e) => GrammarExerciseItem(
            id: e['id'],
            type: ExerciseType.values.firstWhere(
              (type) => type.toString() == e['type'],
              orElse: () => ExerciseType.multipleChoice,
            ),
            question: e['question'],
            options: e['options'] != null ? List<String>.from(e['options']) : null,
            wordBank: e['wordBank'] != null ? List<String>.from(e['wordBank']) : null,
            correctAnswer: e['correctAnswer'],
            explanation: e['explanation'],
          )).toList(),
          order: data['order'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching lessons by category: $e');
      return [];
    }
  }

  /// Get a specific lesson
  Future<GrammarLesson?> getLesson(String lessonId) async {
    try {
      final doc = await _firestore
          .collection('grammar_lessons')
          .doc(lessonId)
          .get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      return GrammarLesson(
        id: data['id'],
        categoryId: data['categoryId'],
        title: data['title'],
        objective: data['objective'],
        theory: data['theory'],
        formulas: List<String>.from(data['formulas']),
        notes: data['notes'] != null ? List<String>.from(data['notes']) : null,
        usages: List<String>.from(data['usages']),
        examples: (data['examples'] as List).map((e) => GrammarExample(
          english: e['english'],
          vietnamese: e['vietnamese'],
          note: e['note'],
        )).toList(),
        recognitionSigns: data['recognitionSigns'] != null 
            ? List<String>.from(data['recognitionSigns']) 
            : null,
        commonMistakes: List<String>.from(data['commonMistakes']),
        exercises: (data['exercises'] as List).map((e) => GrammarExerciseItem(
          id: e['id'],
          type: ExerciseType.values.firstWhere(
            (type) => type.toString() == e['type'],
            orElse: () => ExerciseType.multipleChoice,
          ),
          question: e['question'],
          options: e['options'] != null ? List<String>.from(e['options']) : null,
          wordBank: e['wordBank'] != null ? List<String>.from(e['wordBank']) : null,
          correctAnswer: e['correctAnswer'],
          explanation: e['explanation'],
        )).toList(),
        order: data['order'],
      );
    } catch (e) {
      print('Error fetching lesson: $e');
      return null;
    }
  }
}
