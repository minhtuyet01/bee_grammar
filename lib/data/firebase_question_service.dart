import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/test_question.dart';

/// Firebase Question Service with Smart Caching
/// 
/// Strategy:
/// 1. Try cache first (7 days)
/// 2. If no cache, fetch from Firebase
/// 3. If Firebase fails, use expired cache
/// 4. Requires internet on first launch
class FirebaseQuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _cachePrefix = 'questions_cache_';
  static const String _lastSyncPrefix = 'questions_sync_';
  static const Duration _cacheExpiry = Duration(days: 7);

  /// Get questions with smart caching (cache-first)
  Future<List<TestQuestion>> getQuestions({
    String? category,
    String? level,
    int? limit,
  }) async {
    final cacheKey = _getCacheKey(category, level);
    
    // Try cache first
    final cached = await _getCachedQuestions(cacheKey);
    if (cached != null && cached.isNotEmpty) {
      // print('📦 Using cached questions: ${cached.length}'); // Removed log
      
      // Background sync if cache is old
      _backgroundSync(cacheKey, category, level);
      
      return _filterQuestions(cached, category, level, limit);
    }

    // No cache, fetch from Firebase
    print('☁️ Fetching from Firebase...');
    try {
      final questions = await _fetchFromFirebase(category, level);
      
      // Cache for next time
      await _cacheQuestions(cacheKey, questions);
      
      return _filterQuestions(questions, category, level, limit);
    } catch (e) {
      print('❌ Firebase error: $e');
      
      // Try expired cache as last resort
      final expiredCache = await _getCachedQuestions(cacheKey);
      if (expiredCache != null && expiredCache.isNotEmpty) {
        print('⚠️ Using expired cache as fallback');
        return _filterQuestions(expiredCache, category, level, limit);
      }
      
      // No cache available, throw error
      throw Exception('Unable to load questions. Please check your internet connection.');
    }
  }

  /// Fetch questions from Firebase
  Future<List<TestQuestion>> _fetchFromFirebase(String? category, String? level) async {
    Query query = _firestore.collection('questions');

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }
    if (level != null) {
      query = query.where('level', isEqualTo: level);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => TestQuestion.fromFirestore(doc))
        .toList();
  }

  /// Cache questions to SharedPreferences
  Future<void> _cacheQuestions(String key, List<TestQuestion> questions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = questions.map((q) => q.toFirestore()).toList();
      await prefs.setString(key, jsonEncode(jsonList));
      await prefs.setInt('${_lastSyncPrefix}$key', DateTime.now().millisecondsSinceEpoch);
      print('💾 Cached ${questions.length} questions');
    } catch (e) {
      print('⚠️ Cache error: $e');
    }
  }

  /// Get cached questions
  Future<List<TestQuestion>?> _getCachedQuestions(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);
      if (jsonString == null) return null;

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map((json) => TestQuestion.fromFirestore(
                _MockDocumentSnapshot(json as Map<String, dynamic>),
              ))
          .toList();
    } catch (e) {
      print('⚠️ Cache read error: $e');
      return null;
    }
  }

  /// Check if cache is expired
  Future<bool> _isCacheExpired(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSync = prefs.getInt('${_lastSyncPrefix}$key');
      if (lastSync == null) return true;

      final lastSyncTime = DateTime.fromMillisecondsSinceEpoch(lastSync);
      return DateTime.now().difference(lastSyncTime) > _cacheExpiry;
    } catch (e) {
      return true;
    }
  }

  /// Background sync (don't await)
  void _backgroundSync(String key, String? category, String? level) async {
    try {
      if (await _isCacheExpired(key)) {
        print('🔄 Background syncing...');
        final questions = await _fetchFromFirebase(category, level);
        await _cacheQuestions(key, questions);
        print('✅ Background sync complete');
      }
    } catch (e) {
      print('⚠️ Background sync failed: $e');
    }
  }

  /// Filter questions
  List<TestQuestion> _filterQuestions(
    List<TestQuestion> questions,
    String? category,
    String? level,
    int? limit,
  ) {
    var filtered = questions;

    if (category != null) {
      filtered = filtered.where((q) => q.category == category).toList();
    }
    if (level != null) {
      filtered = filtered.where((q) => q.level == level).toList();
    }

    filtered.shuffle();

    if (limit != null && limit > 0) {
      filtered = filtered.take(limit).toList();
    }

    return filtered;
  }

  /// Get cache key
  String _getCacheKey(String? category, String? level) {
    return '$_cachePrefix${category ?? 'all'}_${level ?? 'all'}';
  }

  /// Clear all cache
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith(_cachePrefix));
    for (final key in keys) {
      await prefs.remove(key);
      await prefs.remove('${_lastSyncPrefix}${key.replaceFirst(_cachePrefix, '')}');
    }
    print('🗑️ Cache cleared');
  }

  /// Force refresh (bypass cache)
  Future<List<TestQuestion>> forceRefresh({
    String? category,
    String? level,
  }) async {
    final questions = await _fetchFromFirebase(category, level);
    final cacheKey = _getCacheKey(category, level);
    await _cacheQuestions(cacheKey, questions);
    return questions;
  }

  /// Get all questions (for compatibility)
  Future<List<TestQuestion>> getAllQuestions() async {
    return await getQuestions();
  }

  /// Get questions by category (for compatibility)
  Future<List<TestQuestion>> getByCategory(String categoryId) async {
    return await getQuestions(category: categoryId);
  }

  /// Get questions by level (for compatibility)
  Future<List<TestQuestion>> getByLevel(String level) async {
    return await getQuestions(level: level);
  }

  /// Get questions by multiple categories
  Future<List<TestQuestion>> getByCategories(List<String> categoryIds) async {
    final allQuestions = <TestQuestion>[];
    for (final categoryId in categoryIds) {
      final questions = await getQuestions(category: categoryId);
      allQuestions.addAll(questions);
    }
    return allQuestions;
  }

  /// Get question count by category
  Future<int> getCountByCategory(String categoryId) async {
    final questions = await getQuestions(category: categoryId);
    return questions.length;
  }

  /// Get question count by level
  Future<int> getCountByLevel(String level) async {
    final questions = await getQuestions(level: level);
    return questions.length;
  }
}

/// Mock DocumentSnapshot for cache
class _MockDocumentSnapshot implements DocumentSnapshot {
  final Map<String, dynamic> _data;

  _MockDocumentSnapshot(this._data);

  @override
  Map<String, dynamic>? data() => _data;

  @override
  String get id => _data['id'] ?? '';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
