import 'package:hive_flutter/hive_flutter.dart';
import '../models/test_question.dart';

/// Local cache service using Hive for offline data storage
class LocalCacheService {
  static const String _questionsBoxName = 'questions_cache';
  static const String _lessonsBoxName = 'lessons_cache';
  static const String _metadataBoxName = 'cache_metadata';
  static const int _cacheExpiryDays = 7;

  Box<Map>? _questionsBox;
  Box<Map>? _lessonsBox;
  Box<Map>? _metadataBox;

  /// Initialize Hive and open boxes
  Future<void> initialize() async {
    await Hive.initFlutter();
    
    _questionsBox = await Hive.openBox<Map>(_questionsBoxName);
    _lessonsBox = await Hive.openBox<Map>(_lessonsBoxName);
    _metadataBox = await Hive.openBox<Map>(_metadataBoxName);
    
    print('✅ Local cache initialized');
    await _cleanExpiredCache();
  }

  // ========== Questions Cache ==========

  /// Cache questions by key (e.g., 'category_cat_1', 'level_beginner', 'exam_mock_1')
  Future<void> cacheQuestions(String key, List<TestQuestion> questions) async {
    if (_questionsBox == null) return;
    
    final data = {
      'questions': questions.map((q) => q.toMap()).toList(),
      'cachedAt': DateTime.now().toIso8601String(),
    };
    
    await _questionsBox!.put(key, data);
    await _updateMetadata(key);
    print('💾 Cached ${questions.length} questions for key: $key');
  }

  /// Get cached questions by key
  Future<List<TestQuestion>?> getCachedQuestions(String key) async {
    if (_questionsBox == null) return null;
    
    final data = _questionsBox!.get(key);
    if (data == null) return null;
    
    // Check if cache is expired
    if (_isCacheExpired(data['cachedAt'] as String)) {
      await _questionsBox!.delete(key);
      return null;
    }
    
    final questionsList = data['questions'] as List;
    final questions = questionsList
        .map((q) => TestQuestion.fromMap(Map<String, dynamic>.from(q)))
        .toList();
    
    print('📦 Retrieved ${questions.length} cached questions for key: $key');
    return questions;
  }

  // ========== Lessons Cache ==========

  /// Cache lesson content by lesson ID
  Future<void> cacheLesson(String lessonId, Map<String, dynamic> lessonData) async {
    if (_lessonsBox == null) return;
    
    final data = {
      'lesson': lessonData,
      'cachedAt': DateTime.now().toIso8601String(),
    };
    
    await _lessonsBox!.put(lessonId, data);
    await _updateMetadata(lessonId);
    print('💾 Cached lesson: $lessonId');
  }

  /// Get cached lesson by ID
  Future<Map<String, dynamic>?> getCachedLesson(String lessonId) async {
    if (_lessonsBox == null) return null;
    
    final data = _lessonsBox!.get(lessonId);
    if (data == null) return null;
    
    // Check if cache is expired
    if (_isCacheExpired(data['cachedAt'] as String)) {
      await _lessonsBox!.delete(lessonId);
      return null;
    }
    
    print('📦 Retrieved cached lesson: $lessonId');
    return Map<String, dynamic>.from(data['lesson'] as Map);
  }

  // ========== Cache Management ==========

  /// Update metadata for cache entry
  Future<void> _updateMetadata(String key) async {
    if (_metadataBox == null) return;
    
    await _metadataBox!.put(key, {
      'lastAccessed': DateTime.now().toIso8601String(),
    });
  }

  /// Check if cache is expired
  bool _isCacheExpired(String cachedAtString) {
    try {
      final cachedAt = DateTime.parse(cachedAtString);
      final now = DateTime.now();
      final difference = now.difference(cachedAt);
      return difference.inDays > _cacheExpiryDays;
    } catch (e) {
      return true; // If parsing fails, consider it expired
    }
  }

  /// Clean expired cache entries
  Future<void> _cleanExpiredCache() async {
    if (_questionsBox == null || _lessonsBox == null) return;
    
    int cleaned = 0;
    
    // Clean questions cache
    final questionKeys = _questionsBox!.keys.toList();
    for (final key in questionKeys) {
      final data = _questionsBox!.get(key);
      if (data != null && _isCacheExpired(data['cachedAt'] as String)) {
        await _questionsBox!.delete(key);
        cleaned++;
      }
    }
    
    // Clean lessons cache
    final lessonKeys = _lessonsBox!.keys.toList();
    for (final key in lessonKeys) {
      final data = _lessonsBox!.get(key);
      if (data != null && _isCacheExpired(data['cachedAt'] as String)) {
        await _lessonsBox!.delete(key);
        cleaned++;
      }
    }
    
    if (cleaned > 0) {
      print('🧹 Cleaned $cleaned expired cache entries');
    }
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await _questionsBox?.clear();
    await _lessonsBox?.clear();
    await _metadataBox?.clear();
    print('🗑️ All cache cleared');
  }

  /// Clear questions cache only
  Future<void> clearQuestionsCache() async {
    await _questionsBox?.clear();
    print('🗑️ Questions cache cleared');
  }

  /// Clear lessons cache only
  Future<void> clearLessonsCache() async {
    await _lessonsBox?.clear();
    print('🗑️ Lessons cache cleared');
  }

  /// Get cache statistics
  Map<String, int> getCacheStats() {
    return {
      'questions': _questionsBox?.length ?? 0,
      'lessons': _lessonsBox?.length ?? 0,
      'metadata': _metadataBox?.length ?? 0,
    };
  }

  /// Close all boxes
  Future<void> dispose() async {
    await _questionsBox?.close();
    await _lessonsBox?.close();
    await _metadataBox?.close();
  }
}
