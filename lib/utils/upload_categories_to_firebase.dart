import '../data/firebase_grammar_content_service.dart';
import '../data/grammar_content_data.dart';

/// One-time script to upload categories with iconPath to Firebase
/// Run this once to update Firebase with custom icon paths
Future<void> uploadCategoriesToFirebase() async {
  print('🚀 Starting upload of categories to Firebase...');
  
  try {
    // Get local categories with iconPath
    final categories = GrammarContentData.getCategories();
    print('📦 Found ${categories.length} categories to upload');
    
    // Upload to Firebase
    final firebaseService = FirebaseGrammarContentService();
    final success = await firebaseService.uploadCategories(categories);
    
    if (success) {
      print('✅ Successfully uploaded all categories with iconPath!');
      print('Categories uploaded:');
      for (final cat in categories) {
        print('  - ${cat.title}: iconPath = ${cat.iconPath}');
      }
    } else {
      print('❌ Failed to upload categories');
    }
  } catch (e) {
    print('❌ Error uploading categories: $e');
  }
}
