import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/grammar_lesson.dart';
import 'firebase_grammar_content_service.dart';

/// Service to manage grammar content with caching
/// Loads from Firebase and caches locally for offline use
class GrammarContentService {
  final FirebaseGrammarContentService _firebaseService = FirebaseGrammarContentService();
  
  // In-memory cache for ultra-fast access
  static List<GrammarCategory>? _memoryCategories;
  static List<GrammarLesson>? _memoryLessons;
  static DateTime? _memoryCacheTime;
  
  // Cache keys
  static const String _categoriesCacheKey = 'cached_grammar_categories';
  static const String _lessonsCacheKey = 'cached_grammar_lessons';
  static const String _lastUpdateKey = 'grammar_last_update';
  
  // Cache duration (24 hours)
  static const Duration _cacheDuration = Duration(hours: 24);

  // ==================== CATEGORIES ====================

  /// Get all categories (with caching)
  Future<List<GrammarCategory>> getCategories({bool forceRefresh = false}) async {
    try {
      // 1. Check in-memory cache first (ultra-fast)
      if (!forceRefresh && _memoryCategories != null && !_isMemoryCacheExpired()) {
        print('✅ Loaded ${_memoryCategories!.length} categories from MEMORY cache');
        return _memoryCategories!;
      }

      // 2. Check SharedPreferences cache
      if (!forceRefresh) {
        final cached = await _getCachedCategories();
        if (cached != null && cached.isNotEmpty) {
          _memoryCategories = cached; // Store in memory
          _memoryCacheTime = DateTime.now();
          print('✅ Loaded ${cached.length} categories from disk cache');
          return cached;
        }
      }

      // 3. Fetch from Firebase
      print('📡 Fetching categories from Firebase...');
      final categories = await _firebaseService.getCategories();
      
      if (categories.isNotEmpty) {
        // Cache the data
        await _cacheCategories(categories);
        _memoryCategories = categories; // Store in memory
        _memoryCacheTime = DateTime.now();
        print('✅ Loaded ${categories.length} categories from Firebase');
      }
      
      return categories;
    } catch (e) {
      print('❌ Error loading categories: $e');
      
      // Try to return cached data as fallback
      if (_memoryCategories != null) {
        print('⚠️  Using memory cache as fallback');
        return _memoryCategories!;
      }
      
      final cached = await _getCachedCategories();
      if (cached != null && cached.isNotEmpty) {
        print('⚠️  Using disk cache as fallback');
        return cached;
      }
      
      return [];
    }
  }

  /// Get a specific category
  Future<GrammarCategory?> getCategory(String categoryId) async {
    final categories = await getCategories();
    try {
      return categories.firstWhere((c) => c.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  // ==================== LESSONS ====================

  /// Get all lessons (with caching)
  Future<List<GrammarLesson>> getAllLessons({bool forceRefresh = false}) async {
    try {
      // 1. Check in-memory cache first (ultra-fast)
      if (!forceRefresh && _memoryLessons != null && !_isMemoryCacheExpired()) {
        print('✅ Loaded ${_memoryLessons!.length} lessons from MEMORY cache');
        return _memoryLessons!;
      }

      // 2. Check SharedPreferences cache
      if (!forceRefresh) {
        final cached = await _getCachedLessons();
        if (cached != null && cached.isNotEmpty) {
          _memoryLessons = cached; // Store in memory
          _memoryCacheTime = DateTime.now();
          print('✅ Loaded ${cached.length} lessons from disk cache');
          return cached;
        }
      }

      // 3. Fetch from Firebase
      print('📡 Fetching lessons from Firebase...');
      final lessons = await _firebaseService.getAllLessons();
      
      if (lessons.isNotEmpty) {
        // Cache the data
        await _cacheLessons(lessons);
        _memoryLessons = lessons; // Store in memory
        _memoryCacheTime = DateTime.now();
        print('✅ Loaded ${lessons.length} lessons from Firebase');
      }
      
      return lessons;
    } catch (e) {
      print('❌ Error loading lessons: $e');
      
      // Try to return cached data as fallback
      if (_memoryLessons != null) {
        print('⚠️  Using memory cache as fallback');
        return _memoryLessons!;
      }
      
      final cached = await _getCachedLessons();
      if (cached != null && cached.isNotEmpty) {
        print('⚠️  Using disk cache as fallback');
        return cached;
      }
      
      return [];
    }
  }

  /// Get lessons by category (with lazy loading and caching)
  /// This is MUCH faster than getAllLessons() - only fetches lessons for one category
  Future<List<GrammarLesson>> getLessonsByCategory(
    String categoryId, {
    bool forceRefresh = false,
  }) async {
    try {
      // 1. Check in-memory cache first
      if (!forceRefresh && _memoryLessons != null && !_isMemoryCacheExpired()) {
        final filtered = _memoryLessons!.where((l) => l.categoryId == categoryId).toList();
        if (filtered.isNotEmpty) {
          print('✅ Loaded ${filtered.length} lessons for $categoryId from MEMORY cache');
          return filtered;
        }
      }

      // 2. Check disk cache
      if (!forceRefresh) {
        final cached = await _getCachedLessons();
        if (cached != null && cached.isNotEmpty) {
          final filtered = cached.where((l) => l.categoryId == categoryId).toList();
          if (filtered.isNotEmpty) {
            // Store in memory for next time
            _memoryLessons ??= [];
            for (final lesson in filtered) {
              if (!_memoryLessons!.any((l) => l.id == lesson.id)) {
                _memoryLessons!.add(lesson);
              }
            }
            print('✅ Loaded ${filtered.length} lessons for $categoryId from disk cache');
            return filtered;
          }
        }
      }

      // 3. Fetch from Firebase (ONLY for this category - LAZY LOAD!)
      print('📡 Fetching lessons for category $categoryId from Firebase...');
      final lessons = await _firebaseService.getLessonsByCategory(categoryId);
      
      if (lessons.isNotEmpty) {
        // Update memory cache (add to existing lessons)
        _memoryLessons ??= [];
        for (final lesson in lessons) {
          // Remove old version if exists
          _memoryLessons!.removeWhere((l) => l.id == lesson.id);
          _memoryLessons!.add(lesson);
        }
        _memoryCacheTime = DateTime.now();
        
        // Update disk cache (merge with existing)
        await _mergeLessonsToCache(lessons);
        
        print('✅ Loaded ${lessons.length} lessons for $categoryId from Firebase');
      }
      
      return lessons;
    } catch (e) {
      print('❌ Error loading lessons for $categoryId: $e');
      
      // Try memory cache as fallback
      if (_memoryLessons != null) {
        final filtered = _memoryLessons!.where((l) => l.categoryId == categoryId).toList();
        if (filtered.isNotEmpty) {
          print('⚠️  Using memory cache as fallback');
          return filtered;
        }
      }
      
      // Try disk cache as fallback
      final cached = await _getCachedLessons();
      if (cached != null) {
        final filtered = cached.where((l) => l.categoryId == categoryId).toList();
        if (filtered.isNotEmpty) {
          print('⚠️  Using disk cache as fallback');
          return filtered;
        }
      }
      
      return [];
    }
  }

  /// Get a specific lesson
  Future<GrammarLesson?> getLesson(String lessonId) async {
    final lessons = await getAllLessons();
    try {
      return lessons.firstWhere((l) => l.id == lessonId);
    } catch (e) {
      return null;
    }
  }

  // ==================== CACHE MANAGEMENT ====================

  /// Cache categories
  Future<void> _cacheCategories(List<GrammarCategory> categories) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = categories.map((c) => c.toJson()).toList();
      await prefs.setString(_categoriesCacheKey, json.encode(jsonList));
      await prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('❌ Error caching categories: $e');
    }
  }

  /// Get cached categories
  Future<List<GrammarCategory>?> _getCachedCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if cache is expired
      if (_isCacheExpired(prefs)) {
        return null;
      }
      
      final jsonString = prefs.getString(_categoriesCacheKey);
      if (jsonString == null) return null;
      
      final jsonList = json.decode(jsonString) as List;
      return jsonList.map((j) => GrammarCategory.fromJson(j)).toList();
    } catch (e) {
      print('❌ Error reading cached categories: $e');
      return null;
    }
  }

  /// Cache lessons
  Future<void> _cacheLessons(List<GrammarLesson> lessons) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = lessons.map((l) => l.toJson()).toList();
      await prefs.setString(_lessonsCacheKey, json.encode(jsonList));
      await prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('❌ Error caching lessons: $e');
    }
  }

  /// Get cached lessons
  Future<List<GrammarLesson>?> _getCachedLessons() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if cache is expired
      if (_isCacheExpired(prefs)) {
        return null;
      }
      
      final jsonString = prefs.getString(_lessonsCacheKey);
      if (jsonString == null) return null;
      
      final jsonList = json.decode(jsonString) as List;
      return jsonList.map((j) => GrammarLesson.fromJson(j)).toList();
    } catch (e) {
      print('❌ Error reading cached lessons: $e');
      return null;
    }
  }

  /// Merge new lessons into cache (for lazy loading)
  Future<void> _mergeLessonsToCache(List<GrammarLesson> newLessons) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Get existing cached lessons
      List<GrammarLesson> existingLessons = [];
      final jsonString = prefs.getString(_lessonsCacheKey);
      if (jsonString != null) {
        final jsonList = json.decode(jsonString) as List;
        existingLessons = jsonList.map((j) => GrammarLesson.fromJson(j)).toList();
      }
      
      // Merge: remove old versions, add new ones
      for (final newLesson in newLessons) {
        existingLessons.removeWhere((l) => l.id == newLesson.id);
        existingLessons.add(newLesson);
      }
      
      // Save merged list
      final jsonList = existingLessons.map((l) => l.toJson()).toList();
      await prefs.setString(_lessonsCacheKey, json.encode(jsonList));
      await prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('❌ Error merging lessons to cache: $e');
    }
  }

  /// Check if cache is expired
  bool _isCacheExpired(SharedPreferences prefs) {
    final lastUpdate = prefs.getInt(_lastUpdateKey);
    if (lastUpdate == null) return true;
    
    final lastUpdateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
    final now = DateTime.now();
    
    return now.difference(lastUpdateTime) > _cacheDuration;
  }

  /// Check if memory cache is expired
  bool _isMemoryCacheExpired() {
    if (_memoryCacheTime == null) return true;
    final now = DateTime.now();
    return now.difference(_memoryCacheTime!) > _cacheDuration;
  }

  /// Clear all cache (both memory and disk)
  Future<void> clearCache() async {
    try {
      // Clear memory cache
      _memoryCategories = null;
      _memoryLessons = null;
      _memoryCacheTime = null;
      
      // Clear disk cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_categoriesCacheKey);
      await prefs.remove(_lessonsCacheKey);
      await prefs.remove(_lastUpdateKey);
      print('✅ Cache cleared (memory + disk)');
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  /// Force refresh data from Firebase
  Future<void> refreshData() async {
    await clearCache();
    await getCategories(forceRefresh: true);
    await getAllLessons(forceRefresh: true);
  }

  /// Check if data is cached
  Future<bool> hasCachedData() async {
    final categories = await _getCachedCategories();
    final lessons = await _getCachedLessons();
    return categories != null && lessons != null;
  }

  /// Get cache info
  Future<Map<String, dynamic>> getCacheInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastUpdate = prefs.getInt(_lastUpdateKey);
      final hasCached = await hasCachedData();
      
      return {
        'hasCachedData': hasCached,
        'lastUpdate': lastUpdate != null 
            ? DateTime.fromMillisecondsSinceEpoch(lastUpdate)
            : null,
        'isExpired': _isCacheExpired(prefs),
      };
    } catch (e) {
      return {
        'hasCachedData': false,
        'lastUpdate': null,
        'isExpired': true,
      };
    }
  }
}
