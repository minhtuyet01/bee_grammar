import 'auth_service.dart';
import 'content_service.dart';
import 'firebase_auth_service.dart';
import 'firebase_listening_service.dart';
import 'firebase_grammar_service.dart';
import 'firebase_grammar_progress_service.dart';
import 'firebase_social_service.dart';
import 'firebase_user_progress_service.dart';
import 'firebase_user_preferences_service.dart';
import 'firebase_messaging_service.dart';

/// Service locator for managing app services
/// Simple singleton pattern for dependency injection
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();
  
  // Legacy services (kept for compatibility, but not used)
  late final InMemoryAuthService authService;
  late final InMemoryContentService contentService;
  
  // Firebase Services (Primary)
  late final FirebaseAuthService firebaseAuthService;
  late final FirebaseListeningService firebaseListeningService;
  late final FirebaseGrammarService firebaseGrammarService;
  late final FirebaseGrammarProgressService firebaseGrammarProgressService;
  late final FirebaseSocialService firebaseSocialService;
  late final FirebaseUserProgressService firebaseUserProgressService;
  late final FirebaseUserPreferencesService firebaseUserPreferencesService;
  late final FirebaseMessagingService firebaseMessagingService;
  
  bool _initialized = false;
  
  /// Initialize all services
  Future<void> initialize() async {
    if (_initialized) return;
    
    // Initialize legacy services (for compatibility)
    authService = InMemoryAuthService();
    contentService = InMemoryContentService();
    
    // Initialize Firebase services (Primary)
    firebaseAuthService = FirebaseAuthService();
    firebaseListeningService = FirebaseListeningService();
    firebaseGrammarService = FirebaseGrammarService();
    firebaseGrammarProgressService = FirebaseGrammarProgressService();
    firebaseSocialService = FirebaseSocialService();
    firebaseUserProgressService = FirebaseUserProgressService();
    firebaseUserPreferencesService = FirebaseUserPreferencesService();
    firebaseMessagingService = FirebaseMessagingService();
    
    // Initialize FCM
    await firebaseMessagingService.initialize();
    
    _initialized = true;
    
    print('✅ ServiceLocator initialized - Using Firebase services');
  }
  
  /// Reset all services (for testing)
  void reset() {
    _initialized = false;
  }
}
