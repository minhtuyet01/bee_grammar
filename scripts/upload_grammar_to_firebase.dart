import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bee_grammar/data/grammar_content_data.dart';

/// Script to upload grammar lessons to Firebase
/// Run this once to populate Firestore with grammar data
Future<void> uploadGrammarLessonsToFirebase() async {
  final firestore = FirebaseFirestore.instance;
  final lessons = GrammarContentData.getAllLessons();
  final categories = GrammarContentData.getAllCategories();

  print('Starting upload of ${lessons.length} lessons and ${categories.length} categories...');

  try {
    // Upload categories
    final categoriesCollection = firestore.collection('grammar_categories');
    for (final category in categories) {
      await categoriesCollection.doc(category.id).set({
        'id': category.id,
        'title': category.title,
        'description': category.description,
        'icon': category.icon.codePoint,
        'color': category.color.value,
        'order': category.order,
        'lessonIds': category.lessonIds,
      });
      print('✓ Uploaded category: ${category.title}');
    }

    // Upload lessons
    final lessonsCollection = firestore.collection('grammar_lessons');
    for (final lesson in lessons) {
      await lessonsCollection.doc(lesson.id).set({
        'id': lesson.id,
        'categoryId': lesson.categoryId,
        'title': lesson.title,
        'objective': lesson.objective,
        'theory': lesson.theory,
        'formulas': lesson.formulas,
        'notes': lesson.notes,
        'usages': lesson.usages,
        'examples': lesson.examples.map((e) => {
          'english': e.english,
          'vietnamese': e.vietnamese,
          'note': e.note,
        }).toList(),
        'recognitionSigns': lesson.recognitionSigns,
        'commonMistakes': lesson.commonMistakes,
        'exercises': lesson.exercises.map((e) => {
          'id': e.id,
          'type': e.type.toString(),
          'question': e.question,
          'options': e.options,
          'wordBank': e.wordBank,
          'correctAnswer': e.correctAnswer,
          'explanation': e.explanation,
        }).toList(),
        'order': lesson.order,
      });
      print('✓ Uploaded lesson: ${lesson.title}');
    }

    print('\n✅ Successfully uploaded all grammar data to Firebase!');
    print('Total: ${categories.length} categories, ${lessons.length} lessons');
  } catch (e) {
    print('❌ Error uploading data: $e');
  }
}

/// Main function to run the upload script
void main() async {
  print('=== Grammar Data Upload Script ===\n');
  await uploadGrammarLessonsToFirebase();
  print('\n=== Upload Complete ===');
}
