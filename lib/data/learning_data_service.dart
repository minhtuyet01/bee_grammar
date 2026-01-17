import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../models/cefr_lesson.dart';
import '../models/cefr_exercise.dart';
import '../models/vocabulary_item.dart';
import '../models/user_lesson_progress.dart';

class LearningDataService {
  static final LearningDataService _instance = LearningDataService._internal();
  factory LearningDataService() => _instance;
  LearningDataService._internal();

  /// Get all units for a specific CEFR level
  Future<List<Unit>> getUnits(String level) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (level == 'A1') {
      return _getA1Units();
    }
    // TODO: Add A2, B1, B2 units
    return [];
  }

  /// Get A1 level units
  List<Unit> _getA1Units() {
    return [
      Unit(
        id: 'unit_1',
        title: 'Greetings & Introductions',
        description: 'Chào hỏi và giới thiệu bản thân',
        order: 1,
        level: 'A1',
        vocabulary: ['hello', 'hi', 'goodbye', 'name', 'my', 'your', 'from', 'where', 'nice', 'meet', 'old', 'years'],
        grammar: ['To be: I am, You are', 'Wh-questions: What, Where', 'Possessive: my, your'],
        iconUrl: '👋',
        color: Colors.blue,
        isLocked: false,
        totalLessons: 6,
        completedLessons: 0,
      ),
      Unit(
        id: 'unit_2',
        title: 'Daily Routines',
        description: 'Sinh hoạt hàng ngày',
        order: 2,
        level: 'A1',
        vocabulary: ['wake up', 'get up', 'brush teeth', 'eat', 'breakfast', 'go', 'work', 'school', 'lunch', 'dinner', 'sleep', 'watch TV'],
        grammar: ['Present Simple', 'Time expressions: at, in', 'Daily activities verbs'],
        iconUrl: '⏰',
        color: Colors.green,
        isLocked: true,
        totalLessons: 6,
        completedLessons: 0,
      ),
      Unit(
        id: 'unit_3',
        title: 'Food & Drinks',
        description: 'Đồ ăn và thức uống',
        order: 3,
        level: 'A1',
        vocabulary: ['food', 'drink', 'like', 'want', 'rice', 'noodles', 'bread', 'water', 'coffee', 'tea', 'juice', 'milk'],
        grammar: ['I like/don\'t like', 'I want/would like', 'How much is it?'],
        iconUrl: '🍔',
        color: Colors.orange,
        isLocked: true,
        totalLessons: 6,
        completedLessons: 0,
      ),
      Unit(
        id: 'unit_4',
        title: 'Family & Friends',
        description: 'Gia đình và bạn bè',
        order: 4,
        level: 'A1',
        vocabulary: ['family', 'father', 'mother', 'brother', 'sister', 'friend', 'have', 'this is', 'he', 'she', 'tall', 'short'],
        grammar: ['This is my...', 'He/She is...', 'I have...', 'Possessive adjectives'],
        iconUrl: '👨‍👩‍👧‍👦',
        color: Colors.pink,
        isLocked: true,
        totalLessons: 6,
        completedLessons: 0,
      ),
      Unit(
        id: 'unit_5',
        title: 'Shopping',
        description: 'Mua sắm',
        order: 5,
        level: 'A1',
        vocabulary: ['shop', 'buy', 'sell', 'price', 'money', 'shirt', 'pants', 'shoes', 'dress', 'bag', 'expensive', 'cheap'],
        grammar: ['How much is/are...?', 'I want to buy...', 'Numbers 20-100'],
        iconUrl: '🛍️',
        color: Colors.purple,
        isLocked: true,
        totalLessons: 6,
        completedLessons: 0,
      ),
      Unit(
        id: 'unit_6',
        title: 'Places & Directions',
        description: 'Địa điểm và chỉ đường',
        order: 6,
        level: 'A1',
        vocabulary: ['where', 'here', 'there', 'near', 'far', 'go', 'turn', 'left', 'right', 'straight', 'street', 'park'],
        grammar: ['Where is...?', 'Go straight, turn left/right', 'Prepositions of place'],
        iconUrl: '🗺️',
        color: Colors.teal,
        isLocked: true,
        totalLessons: 6,
        completedLessons: 0,
      ),
      Unit(
        id: 'unit_7',
        title: 'Hobbies & Free Time',
        description: 'Sở thích và thời gian rảnh',
        order: 7,
        level: 'A1',
        vocabulary: ['hobby', 'like', 'love', 'enjoy', 'play', 'read', 'watch', 'listen', 'music', 'movie', 'book', 'sport'],
        grammar: ['I like/love + V-ing', 'What do you like to do?', 'Gerunds'],
        iconUrl: '⚽',
        color: Colors.red,
        isLocked: true,
        totalLessons: 6,
        completedLessons: 0,
      ),
    ];
  }

  /// Get lessons for a specific unit
  Future<List<CEFRLesson>> getLessonsForUnit(String unitId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (unitId == 'unit_1') {
      return _getUnit1Lessons();
    }
    // TODO: Add lessons for other units
    return [];
  }

  /// Get Unit 1 lessons (Greetings & Introductions)
  List<CEFRLesson> _getUnit1Lessons() {
    return [
      CEFRLesson(
        id: 'lesson_1_1',
        unitId: 'unit_1',
        title: 'Hello!',
        objective: 'Học cách chào hỏi cơ bản',
        order: 1,
        estimatedMinutes: 5,
        exercises: _getLesson1_1Exercises(),
        xpReward: 50,
        diamondReward: 10,
        isLocked: false,
      ),
      CEFRLesson(
        id: 'lesson_1_2',
        unitId: 'unit_1',
        title: 'What\'s your name?',
        objective: 'Hỏi và trả lời về tên',
        order: 2,
        estimatedMinutes: 5,
        exercises: [],
        xpReward: 60,
        diamondReward: 10,
        isLocked: true,
      ),
      CEFRLesson(
        id: 'lesson_1_3',
        unitId: 'unit_1',
        title: 'Nice to meet you!',
        objective: 'Học cách đáp lại lời giới thiệu',
        order: 3,
        estimatedMinutes: 5,
        exercises: [],
        xpReward: 70,
        diamondReward: 10,
        isLocked: true,
      ),
      CEFRLesson(
        id: 'lesson_1_4',
        unitId: 'unit_1',
        title: 'Where are you from?',
        objective: 'Hỏi và trả lời về quốc tịch',
        order: 4,
        estimatedMinutes: 6,
        exercises: [],
        xpReward: 80,
        diamondReward: 10,
        isLocked: true,
      ),
      CEFRLesson(
        id: 'lesson_1_5',
        unitId: 'unit_1',
        title: 'How old are you?',
        objective: 'Hỏi và trả lời về tuổi',
        order: 5,
        estimatedMinutes: 6,
        exercises: [],
        xpReward: 90,
        diamondReward: 10,
        isLocked: true,
      ),
      CEFRLesson(
        id: 'lesson_1_6',
        unitId: 'unit_1',
        title: 'Unit 1 Review',
        objective: 'Ôn tập tổng hợp Unit 1',
        order: 6,
        estimatedMinutes: 7,
        exercises: [],
        xpReward: 150,
        diamondReward: 20,
        isLocked: true,
      ),
    ];
  }

  /// Get exercises for Lesson 1.1 (Hello!)
  List<CEFRExercise> _getLesson1_1Exercises() {
    return [
      // Warm-up: Image Matching
      CEFRExercise(
        id: 'ex_1_1_1',
        type: CEFRExerciseType.warmup,
        questionType: CEFRQuestionType.imageMatching,
        instruction: 'Ghép hình ảnh với từ đúng',
        content: {
          'pairs': [
            {'image': '👋', 'word': 'Hello'},
            {'image': '🙋', 'word': 'Hi'},
            {'image': '👋😊', 'word': 'Goodbye'},
            {'image': '✋', 'word': 'Bye'},
          ]
        },
        options: ['Hello', 'Hi', 'Goodbye', 'Bye'],
        correctAnswer: {'👋': 'Hello', '🙋': 'Hi', '👋😊': 'Goodbye', '✋': 'Bye'},
        points: 10,
      ),

      // Input: Dialogue
      CEFRExercise(
        id: 'ex_1_1_2',
        type: CEFRExerciseType.input,
        questionType: CEFRQuestionType.listening,
        instruction: 'Nghe và đọc theo đoạn hội thoại',
        content: {
          'dialogue': [
            {'speaker': 'A', 'text': 'Hello! 👋'},
            {'speaker': 'B', 'text': 'Hi! 😊'},
            {'speaker': 'A', 'text': 'Goodbye! 👋'},
            {'speaker': 'B', 'text': 'Bye! See you! ✋'},
          ]
        },
        options: [],
        correctAnswer: null,
        audioUrl: 'https://example.com/audio/lesson_1_1_dialogue.mp3',
        points: 0,
      ),

      // Practice 1: Multiple Choice
      CEFRExercise(
        id: 'ex_1_1_3',
        type: CEFRExerciseType.practice,
        questionType: CEFRQuestionType.multipleChoice,
        instruction: 'Chọn đáp án đúng',
        content: 'When you meet someone, you say:',
        options: ['Goodbye', 'Hello', 'Bye', 'See you'],
        correctAnswer: 'Hello',
        explanation: '"Hello" hoặc "Hi" dùng khi gặp người khác',
        points: 15,
      ),

      // Practice 2: Drag & Drop
      CEFRExercise(
        id: 'ex_1_1_4',
        type: CEFRExerciseType.practice,
        questionType: CEFRQuestionType.dragAndDrop,
        instruction: 'Sắp xếp cuộc hội thoại đúng thứ tự',
        content: {
          'items': ['Bye!', 'Hi!', 'Hello!', 'Goodbye!']
        },
        options: [],
        correctAnswer: ['Hello!', 'Hi!', 'Goodbye!', 'Bye!'],
        explanation: 'Thứ tự: Chào → Đáp lại → Tạm biệt → Đáp lại',
        points: 20,
      ),

      // Practice 3: Fill in the blank
      CEFRExercise(
        id: 'ex_1_1_5',
        type: CEFRExerciseType.practice,
        questionType: CEFRQuestionType.fillInBlank,
        instruction: 'Điền từ thích hợp vào chỗ trống',
        content: 'A: _____, John!\nB: Hi, Mary!',
        options: ['Hello', 'Hi', 'Goodbye', 'Bye'],
        correctAnswer: ['Hello', 'Hi'],
        explanation: 'Cả "Hello" và "Hi" đều đúng',
        points: 15,
      ),

      // Production: Speaking
      CEFRExercise(
        id: 'ex_1_1_6',
        type: CEFRExerciseType.production,
        questionType: CEFRQuestionType.speaking,
        instruction: 'Ghi âm 2 câu sau',
        content: {
          'sentences': [
            'Hello! My name is [your name]',
            'Goodbye! See you!',
          ]
        },
        options: [],
        correctAnswer: null,
        points: 30,
      ),

      // Review
      CEFRExercise(
        id: 'ex_1_1_7',
        type: CEFRExerciseType.review,
        questionType: CEFRQuestionType.multipleChoice,
        instruction: 'Ôn tập: Từ nào dùng khi tạm biệt?',
        content: 'Which word is used when leaving?',
        options: ['Hello', 'Hi', 'Goodbye', 'Nice'],
        correctAnswer: 'Goodbye',
        points: 10,
      ),
    ];
  }

  /// Get vocabulary for a unit
  Future<List<VocabularyItem>> getVocabularyForUnit(String unitId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (unitId == 'unit_1') {
      return _getUnit1Vocabulary();
    }
    return [];
  }

  List<VocabularyItem> _getUnit1Vocabulary() {
    return [
      VocabularyItem(
        id: 'vocab_1_1',
        word: 'hello',
        translation: 'xin chào',
        phonetic: '/həˈloʊ/',
        audioUrl: 'https://example.com/audio/hello.mp3',
        exampleSentence: 'Hello! How are you?',
        exampleTranslation: 'Xin chào! Bạn khỏe không?',
        unitId: 'unit_1',
      ),
      VocabularyItem(
        id: 'vocab_1_2',
        word: 'goodbye',
        translation: 'tạm biệt',
        phonetic: '/ˌɡʊdˈbaɪ/',
        audioUrl: 'https://example.com/audio/goodbye.mp3',
        exampleSentence: 'Goodbye! See you tomorrow!',
        exampleTranslation: 'Tạm biệt! Hẹn gặp lại ngày mai!',
        unitId: 'unit_1',
      ),
      VocabularyItem(
        id: 'vocab_1_3',
        word: 'name',
        translation: 'tên',
        phonetic: '/neɪm/',
        audioUrl: 'https://example.com/audio/name.mp3',
        exampleSentence: 'What\'s your name?',
        exampleTranslation: 'Tên bạn là gì?',
        unitId: 'unit_1',
      ),
    ];
  }

  /// Get user progress for a lesson
  Future<UserLessonProgress?> getProgress(String userId, String lessonId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // TODO: Implement actual storage
    return null;
  }

  /// Save user progress
  Future<void> saveProgress(UserLessonProgress progress) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // TODO: Implement actual storage
  }

  /// Get unit progress percentage
  Future<double> getUnitProgress(String userId, String unitId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // TODO: Calculate from actual progress
    return 0.0;
  }
}
