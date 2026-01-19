import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../data/grammar_content_data.dart';
import '../firebase_options.dart';

/// Script to upload grammar content to Firebase Firestore
/// 
/// This script will:
/// 1. Delete old collections (except users)
/// 2. Upload grammar categories
/// 3. Upload all grammar lessons
/// 
/// Run this script with: flutter run lib/scripts/upload_grammar_data.dart

void main() async {
  print('🚀 Starting Firebase Grammar Data Upload...\n');
  
  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully\n');

    final firestore = FirebaseFirestore.instance;

    // Step 1: Delete old collections (except users)
    print('🗑️  Step 1: Cleaning old collections...');
    await deleteOldCollections(firestore);
    print('✅ Old collections deleted\n');

    // Step 2: Upload categories
    print('📚 Step 2: Uploading grammar categories...');
    await uploadCategories(firestore);
    print('✅ Categories uploaded\n');

    // Step 3: Upload lessons
    print('📖 Step 3: Uploading grammar lessons...');
    await uploadLessons(firestore);
    print('✅ Lessons uploaded\n');

    print('🎉 All data uploaded successfully!');
    print('📊 Summary:');
    print('   - Categories: ${GrammarContentData.getCategories().length}');
    print('   - Lessons: ${GrammarContentData.getAllLessons().length}');
    
  } catch (e) {
    print('❌ Error: $e');
  }
}

/// Delete old collections except users
Future<void> deleteOldCollections(FirebaseFirestore firestore) async {
  final collectionsToDelete = [
    'grammar_categories',
    'grammar_lessons',
    'learning_history',
    'lesson_progress',
    'practice_sessions',
    'user_practice_stats',
    'user_statistics',
  ];

  for (final collectionName in collectionsToDelete) {
    try {
      print('   Deleting $collectionName...');
      final snapshot = await firestore.collection(collectionName).get();
      
      if (snapshot.docs.isEmpty) {
        print('   ⚠️  $collectionName is already empty');
        continue;
      }

      // Delete in batches of 500 (Firestore limit)
      final batch = firestore.batch();
      int count = 0;
      
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
        count++;
        
        if (count >= 500) {
          await batch.commit();
          count = 0;
        }
      }
      
      if (count > 0) {
        await batch.commit();
      }
      
      print('   ✅ Deleted ${snapshot.docs.length} documents from $collectionName');
    } catch (e) {
      print('   ⚠️  Error deleting $collectionName: $e');
    }
  }
}

/// Upload grammar categories
Future<void> uploadCategories(FirebaseFirestore firestore) async {
  final categories = GrammarContentData.getCategories();
  final batch = firestore.batch();

  for (final category in categories) {
    final docRef = firestore.collection('grammar_categories').doc(category.id);
    batch.set(docRef, category.toJson());
    print('   Adding category: ${category.title}');
  }

  await batch.commit();
}

/// Upload grammar lessons
Future<void> uploadLessons(FirebaseFirestore firestore) async {
  final lessons = GrammarContentData.getAllLessons();
  
  // Upload in batches of 500
  for (int i = 0; i < lessons.length; i += 500) {
    final batch = firestore.batch();
    final end = (i + 500 < lessons.length) ? i + 500 : lessons.length;
    
    for (int j = i; j < end; j++) {
      final lesson = lessons[j];
      final docRef = firestore.collection('grammar_lessons').doc(lesson.id);
      batch.set(docRef, lesson.toJson());
      print('   Adding lesson ${j + 1}/${lessons.length}: ${lesson.title}');
    }
    
    await batch.commit();
  }
}
