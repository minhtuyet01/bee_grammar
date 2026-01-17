import 'package:uuid/uuid.dart';
import '../models/topic.dart';
import '../models/lesson.dart';

/// Service for managing content (Topics and Lessons)
/// In-memory implementation for demonstration
/// Can be replaced with Firebase or SQLite in production
abstract class ContentService {
  // Topic operations
  Future<List<Topic>> getAllTopics();
  Future<Topic?> getTopicById(String id);
  Future<Topic> createTopic(Topic topic);
  Future<Topic> updateTopic(Topic topic);
  Future<void> deleteTopic(String id);
  
  // Lesson operations
  Future<List<Lesson>> getAllLessons();
  Future<List<Lesson>> getLessonsByTopic(String topicId);
  Future<Lesson?> getLessonById(String id);
  Future<Lesson> createLesson(Lesson lesson);
  Future<Lesson> updateLesson(Lesson lesson);
  Future<void> deleteLesson(String id);
}

class InMemoryContentService implements ContentService {
  final Map<String, Topic> _topics = {};
  final Map<String, Lesson> _lessons = {};
  final _uuid = const Uuid();
  
  // Initialize with data
  void initializeWithData(List<Topic> topics, List<Lesson> lessons) {
    _topics.clear();
    _lessons.clear();
    
    for (final topic in topics) {
      _topics[topic.id] = topic;
    }
    
    for (final lesson in lessons) {
      _lessons[lesson.id] = lesson;
    }
  }
  
  // ==========================================
  // TOPIC OPERATIONS
  // ==========================================
  
  @override
  Future<List<Topic>> getAllTopics() async {
    return _topics.values.toList().sortByOrderIndex();
  }
  
  @override
  Future<Topic?> getTopicById(String id) async {
    return _topics[id];
  }
  
  @override
  Future<Topic> createTopic(Topic topic) async {
    // Ensure unique ID
    final newTopic = topic.copyWith(
      id: topic.id.isEmpty ? _uuid.v4() : topic.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _topics[newTopic.id] = newTopic;
    return newTopic;
  }
  
  @override
  Future<Topic> updateTopic(Topic topic) async {
    if (!_topics.containsKey(topic.id)) {
      throw Exception('Topic not found: ${topic.id}');
    }
    
    final updatedTopic = topic.copyWith(
      updatedAt: DateTime.now(),
    );
    
    _topics[topic.id] = updatedTopic;
    return updatedTopic;
  }
  
  @override
  Future<void> deleteTopic(String id) async {
    if (!_topics.containsKey(id)) {
      throw Exception('Topic not found: $id');
    }
    
    // Check if topic has lessons
    final lessons = await getLessonsByTopic(id);
    if (lessons.isNotEmpty) {
      throw Exception('Cannot delete topic with existing lessons. Delete lessons first.');
    }
    
    _topics.remove(id);
  }
  
  // ==========================================
  // LESSON OPERATIONS
  // ==========================================
  
  @override
  Future<List<Lesson>> getAllLessons() async {
    return _lessons.values.toList().sortByOrderIndex();
  }
  
  @override
  Future<List<Lesson>> getLessonsByTopic(String topicId) async {
    return _lessons.values
        .where((lesson) => lesson.topicId == topicId)
        .toList()
        .sortByOrderIndex();
  }
  
  @override
  Future<Lesson?> getLessonById(String id) async {
    return _lessons[id];
  }
  
  @override
  Future<Lesson> createLesson(Lesson lesson) async {
    // Validate topic exists
    if (!_topics.containsKey(lesson.topicId)) {
      throw Exception('Topic not found: ${lesson.topicId}');
    }
    
    // Ensure unique ID
    final newLesson = lesson.copyWith(
      id: lesson.id.isEmpty ? _uuid.v4() : lesson.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _lessons[newLesson.id] = newLesson;
    return newLesson;
  }
  
  @override
  Future<Lesson> updateLesson(Lesson lesson) async {
    if (!_lessons.containsKey(lesson.id)) {
      throw Exception('Lesson not found: ${lesson.id}');
    }
    
    // Validate topic exists
    if (!_topics.containsKey(lesson.topicId)) {
      throw Exception('Topic not found: ${lesson.topicId}');
    }
    
    final updatedLesson = lesson.copyWith(
      updatedAt: DateTime.now(),
    );
    
    _lessons[lesson.id] = updatedLesson;
    return updatedLesson;
  }
  
  @override
  Future<void> deleteLesson(String id) async {
    if (!_lessons.containsKey(id)) {
      throw Exception('Lesson not found: $id');
    }
    
    _lessons.remove(id);
  }
  
  // ==========================================
  // UTILITY METHODS
  // ==========================================
  
  /// Get topic count
  int get topicCount => _topics.length;
  
  /// Get lesson count
  int get lessonCount => _lessons.length;
  
  /// Get lesson count for a specific topic
  Future<int> getLessonCountForTopic(String topicId) async {
    final lessons = await getLessonsByTopic(topicId);
    return lessons.length;
  }
  
  /// Clear all data
  void clearAll() {
    _topics.clear();
    _lessons.clear();
  }
}
