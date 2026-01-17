import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/friend_activity.dart';

class FirebaseSocialService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get friend activities
  Future<List<FriendActivity>> getFriendActivities({int limit = 10}) async {
    try {
      final snapshot = await _firestore
          .collection('friendActivities')
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return FriendActivity(
          friendId: data['friendId'] as String,
          friendName: data['friendName'] as String,
          friendAvatar: data['friendAvatar'] as String,
          type: _parseActivityType(data['type'] as String),
          description: data['description'] as String,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        );
      }).toList();
    } catch (e) {
      print('Error fetching friend activities: $e');
      return [];
    }
  }

  /// Get leaderboard
  Future<List<Map<String, dynamic>>> getLeaderboard({
    String period = 'all',
    int limit = 50,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('leaderboard')
          .orderBy('xp', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.asMap().entries.map((entry) {
        final index = entry.key;
        final doc = entry.value;
        final data = doc.data();
        
        return {
          'userId': doc.id,
          'name': data['name'],
          'xp': data['xp'],
          'avatar': data['avatar'],
          'flag': data['flag'] ?? '',
          'isOnline': data['isOnline'] ?? false,
          'rank': index + 1,
          'hasGreenDot': data['isOnline'] ?? false,
          'isCurrentUser': false, // Will be set by UI
        };
      }).toList();
    } catch (e) {
      print('Error fetching leaderboard: $e');
      return [];
    }
  }

  /// Update user XP and leaderboard
  Future<void> updateUserXP(String userId, int xp) async {
    try {
      await _firestore.collection('leaderboard').doc(userId).set({
        'xp': xp,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating user XP: $e');
      rethrow;
    }
  }

  /// Add friend activity
  Future<void> addFriendActivity({
    required String friendId,
    required String friendName,
    required String friendAvatar,
    required ActivityType type,
    required String description,
  }) async {
    try {
      await _firestore.collection('friendActivities').add({
        'friendId': friendId,
        'friendName': friendName,
        'friendAvatar': friendAvatar,
        'type': _activityTypeToString(type),
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding friend activity: $e');
      rethrow;
    }
  }

  /// Stream leaderboard (realtime updates)
  Stream<List<Map<String, dynamic>>> streamLeaderboard({int limit = 50}) {
    return _firestore
        .collection('leaderboard')
        .orderBy('xp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.asMap().entries.map((entry) {
        final index = entry.key;
        final doc = entry.value;
        final data = doc.data();
        
        return {
          'userId': doc.id,
          'name': data['name'],
          'xp': data['xp'],
          'avatar': data['avatar'],
          'flag': data['flag'] ?? '',
          'isOnline': data['isOnline'] ?? false,
          'rank': index + 1,
          'hasGreenDot': data['isOnline'] ?? false,
          'isCurrentUser': false,
        };
      }).toList();
    });
  }

  /// Parse activity type from string
  ActivityType _parseActivityType(String type) {
    switch (type) {
      case 'lessonCompleted':
        return ActivityType.lessonCompleted;
      case 'achievementUnlocked':
        return ActivityType.achievementUnlocked;
      case 'streakMilestone':
        return ActivityType.streakMilestone;
      case 'quizPassed':
        return ActivityType.quizPassed;
      default:
        return ActivityType.lessonCompleted;
    }
  }

  /// Convert activity type to string
  String _activityTypeToString(ActivityType type) {
    switch (type) {
      case ActivityType.lessonCompleted:
        return 'lessonCompleted';
      case ActivityType.achievementUnlocked:
        return 'achievementUnlocked';
      case ActivityType.streakMilestone:
        return 'streakMilestone';
      case ActivityType.quizPassed:
        return 'quizPassed';
    }
  }
}
