import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserPreferencesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get user preferences
  Future<Map<String, dynamic>> getUserPreferences(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      
      if (!doc.exists) {
        return _getDefaultPreferences();
      }
      
      final data = doc.data()!;
      return {
        'language': data['language'] as String? ?? 'vi',
        'fcmToken': data['fcmToken'] as String?,
        'notificationSettings': data['notificationSettings'] as Map<String, dynamic>? ?? _getDefaultNotificationSettings(),
      };
    } catch (e) {
      print('Error getting user preferences: $e');
      return _getDefaultPreferences();
    }
  }

  /// Stream user preferences (realtime updates)
  Stream<Map<String, dynamic>> streamUserPreferences(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return _getDefaultPreferences();
      }
      
      final data = snapshot.data()!;
      return {
        'language': data['language'] as String? ?? 'vi',
        'fcmToken': data['fcmToken'] as String?,
        'notificationSettings': data['notificationSettings'] as Map<String, dynamic>? ?? _getDefaultNotificationSettings(),
      };
    });
  }

  /// Update language preference
  Future<void> updateLanguage(String userId, String languageCode) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'language': languageCode,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Updated language to $languageCode for user $userId');
    } catch (e) {
      print('Error updating language: $e');
      rethrow;
    }
  }

  /// Update notification settings
  Future<void> updateNotificationSettings(
    String userId,
    Map<String, bool> settings,
  ) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'notificationSettings': settings,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Updated notification settings for user $userId');
    } catch (e) {
      print('Error updating notification settings: $e');
      rethrow;
    }
  }

  /// Save FCM token
  Future<void> saveFCMToken(String userId, String token) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': token,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Saved FCM token for user $userId');
    } catch (e) {
      print('Error saving FCM token: $e');
      rethrow;
    }
  }

  /// Initialize user preferences on first login
  Future<void> initializeUserPreferences(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      
      if (!doc.exists) return;
      
      final data = doc.data()!;
      
      // Only initialize if not already set
      if (!data.containsKey('language') || !data.containsKey('notificationSettings')) {
        await _firestore.collection('users').doc(userId).update({
          'language': data['language'] ?? 'vi',
          'notificationSettings': data['notificationSettings'] ?? _getDefaultNotificationSettings(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        print('✅ Initialized preferences for user $userId');
      }
    } catch (e) {
      print('Error initializing user preferences: $e');
    }
  }

  Map<String, dynamic> _getDefaultPreferences() {
    return {
      'language': 'vi',
      'fcmToken': null,
      'notificationSettings': _getDefaultNotificationSettings(),
    };
  }

  Map<String, bool> _getDefaultNotificationSettings() {
    return {
      'allNotifications': true,
      'learningReminders': true,
      'achievementNotifications': true,
      'quizResults': true,
      'leaderboardUpdates': false,
      'newContent': true,
      'systemUpdates': true,
    };
  }
}
