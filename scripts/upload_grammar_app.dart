import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bee_grammar/data/grammar_content_data.dart';

/// Flutter app to upload grammar data to Firebase
/// Run with: flutter run -t scripts/upload_grammar_app.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const UploadGrammarApp());
}

class UploadGrammarApp extends StatelessWidget {
  const UploadGrammarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Grammar Data',
      home: const UploadScreen(),
    );
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String _status = 'Ready to upload';
  bool _isUploading = false;
  int _uploadedCategories = 0;
  int _uploadedLessons = 0;

  Future<void> _uploadData() async {
    setState(() {
      _isUploading = true;
      _status = 'Starting upload...';
    });

    try {
      final firestore = FirebaseFirestore.instance;
      final lessons = GrammarContentData.getAllLessons();
      final categories = GrammarContentData.getCategories();

      // Upload categories
      setState(() => _status = 'Uploading categories...');
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
        setState(() {
          _uploadedCategories++;
          _status = 'Uploaded $_uploadedCategories/${categories.length} categories';
        });
      }

      // Upload lessons
      setState(() => _status = 'Uploading lessons...');
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
        setState(() {
          _uploadedLessons++;
          _status = 'Uploaded $_uploadedLessons/${lessons.length} lessons';
        });
      }

      setState(() {
        _status = '✅ Success! Uploaded ${categories.length} categories and ${lessons.length} lessons';
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _status = '❌ Error: $e';
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Grammar Data to Firebase'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload, size: 100, color: Colors.blue),
              const SizedBox(height: 32),
              Text(
                _status,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_uploadedCategories > 0)
                Text('Categories: $_uploadedCategories'),
              if (_uploadedLessons > 0)
                Text('Lessons: $_uploadedLessons'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadData,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    _isUploading ? 'Uploading...' : 'Upload to Firebase',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
