import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseUserProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  /// Award XP to user
  Future<void> awardXP(String userId, int xp, String reason) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        if (!snapshot.exists) return;
        
        final currentXP = snapshot.data()?['xp'] as int? ?? 0;
        final newXP = currentXP + xp;
        
        transaction.update(userRef, {
          'xp': newXP,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        // Also update leaderboard
        await _updateLeaderboard(userId, newXP);
      });
      
      print('✅ Awarded $xp XP to $userId for: $reason');
    } catch (e) {
      print('Error awarding XP: $e');
      rethrow;
    }
  }

  /// Check and update streak
  Future<int> checkAndUpdateStreak(String userId) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      final doc = await userRef.get();
      
      if (!doc.exists) return 0;
      
      final data = doc.data()!;
      final currentStreak = data['streak'] as int? ?? 0;
      final lastActiveDate = (data['lastActiveDate'] as Timestamp?)?.toDate();
      final now = DateTime.now();
      
      int newStreak = currentStreak;
      
      if (lastActiveDate == null) {
        // First time
        newStreak = 1;
      } else {
        // FIX: Compare dates only, not hours
        final lastDate = DateTime(
          lastActiveDate.year,
          lastActiveDate.month,
          lastActiveDate.day,
        );
        final today = DateTime(now.year, now.month, now.day);
        final daysSinceLastActive = today.difference(lastDate).inDays;
        
        if (daysSinceLastActive == 0) {
          // Same day, no change
          return currentStreak;
        } else if (daysSinceLastActive == 1) {
          // Next day, increment
          newStreak = currentStreak + 1;
        } else if (daysSinceLastActive == 2 && currentStreak >= 7) {
          // Grace period: Allow 1 missed day if streak >= 7
          newStreak = currentStreak;
          print('⚠️ Grace period applied - streak maintained: $currentStreak days');
        } else {
          // Streak broken
          newStreak = 1;
          print('💔 Streak broken - reset to 1 day');
        }
      }
      
      await userRef.update({
        'streak': newStreak,
        'lastActiveDate': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      print('✅ Streak updated: $newStreak days');
      
      return newStreak;
    } catch (e) {
      print('Error checking streak: $e');
      return 0;
    }
  }

  /// Award diamonds to user
  Future<void> awardDiamonds(String userId, int amount, String reason) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        if (!snapshot.exists) return;
        
        final currentDiamonds = snapshot.data()?['diamonds'] as int? ?? 0;
        final newDiamonds = currentDiamonds + amount;
        
        transaction.update(userRef, {
          'diamonds': newDiamonds,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });
      
      print('✅ Awarded $amount diamonds to $userId for: $reason');
    } catch (e) {
      print('Error awarding diamonds: $e');
      rethrow;
    }
  }

  /// Get user progress summary
  Future<Map<String, dynamic>> getUserProgress(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      
      if (!doc.exists) {
        return {'xp': 0, 'streak': 0, 'diamonds': 0};
      }
      
      final data = doc.data()!;
      return {
        'xp': data['xp'] as int? ?? 0,
        'streak': data['streak'] as int? ?? 0,
        'diamonds': data['diamonds'] as int? ?? 0,
        'level': data['level'] as String? ?? 'A1',
      };
    } catch (e) {
      print('Error getting user progress: $e');
      return {'xp': 0, 'streak': 0, 'diamonds': 0};
    }
  }

  /// Stream user progress (realtime updates)
  Stream<Map<String, dynamic>> streamUserProgress(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return {'xp': 0, 'streak': 0, 'diamonds': 0};
      }
      
      final data = snapshot.data()!;
      return {
        'xp': data['xp'] as int? ?? 0,
        'streak': data['streak'] as int? ?? 0,
        'diamonds': data['diamonds'] as int? ?? 0,
        'level': data['level'] as String? ?? 'A1',
      };
    });
  }

  /// Update leaderboard when XP changes
  Future<void> _updateLeaderboard(String userId, int xp) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) return;
      
      final userData = userDoc.data()!;
      
      await _firestore.collection('leaderboard').doc(userId).set({
        'name': userData['fullName'] ?? userData['username'] ?? 'User',
        'xp': xp,
        'avatar': (userData['username'] as String?)?.substring(0, 1).toUpperCase() ?? 'U',
        'flag': '🇻🇳',
        'isOnline': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating leaderboard: $e');
    }
  }

  /// Award XP for completing listening exercise
  Future<void> awardListeningXP(String userId, int score, int totalQuestions) async {
    final percentage = (score / totalQuestions * 100).round();
    int xp = 0;
    
    if (percentage == 100) {
      xp = 100; // Perfect score
      await awardDiamonds(userId, 5, 'Perfect score on listening');
    } else if (percentage >= 80) {
      xp = 50;
    } else if (percentage >= 60) {
      xp = 30;
    } else {
      xp = 10;
    }
    
    await awardXP(userId, xp, 'Completed listening exercise ($percentage%)');
  }

  /// Check daily goal and award diamonds
  Future<void> checkDailyGoal(String userId) async {
    // TODO: Implement daily goal tracking
    // For now, just award diamonds
    await awardDiamonds(userId, 10, 'Daily goal completed');
  }
}
