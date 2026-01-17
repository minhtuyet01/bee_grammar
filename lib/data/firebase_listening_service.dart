import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listening_exercise.dart';
import '../models/listening_attempt.dart';

class FirebaseListeningService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all exercises
  Future<List<ListeningExercise>> getAllExercises() async {
    try {
      final snapshot = await _firestore
          .collection('listeningExercises')
          .orderBy('level')
          .get();

      return snapshot.docs
          .map((doc) => ListeningExercise.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      print('Error getting exercises: $e');
      return [];
    }
  }

  // Get exercises by level
  Future<List<ListeningExercise>> getExercisesByLevel(String level) async {
    try {
      final snapshot = await _firestore
          .collection('listeningExercises')
          .where('level', isEqualTo: level)
          .get();

      return snapshot.docs
          .map((doc) => ListeningExercise.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      print('Error getting exercises by level: $e');
      return [];
    }
  }

  // Get exercises by topic
  Future<List<ListeningExercise>> getExercisesByTopic(String topic) async {
    try {
      final snapshot = await _firestore
          .collection('listeningExercises')
          .where('topic', isEqualTo: topic)
          .get();

      return snapshot.docs
          .map((doc) => ListeningExercise.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      print('Error getting exercises by topic: $e');
      return [];
    }
  }

  // Get exercise by ID
  Future<ListeningExercise?> getExerciseById(String id) async {
    try {
      final doc = await _firestore
          .collection('listeningExercises')
          .doc(id)
          .get();

      if (!doc.exists) return null;

      return ListeningExercise.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      print('Error getting exercise by ID: $e');
      return null;
    }
  }

  // Save attempt
  Future<void> saveAttempt(ListeningAttempt attempt) async {
    try {
      await _firestore
          .collection('users')
          .doc(attempt.userId)
          .collection('listeningAttempts')
          .doc(attempt.id)
          .set(attempt.toJson());

      // Update user XP
      await _updateUserXP(attempt.userId, attempt.score * 10);
    } catch (e) {
      print('Error saving attempt: $e');
      rethrow;
    }
  }

  // Get attempt history
  Future<List<ListeningAttempt>> getAttemptHistory(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('listeningAttempts')
          .orderBy('completedAt', descending: true)
          .limit(50)
          .get();

      return snapshot.docs
          .map((doc) => ListeningAttempt.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting attempt history: $e');
      return [];
    }
  }

  // Update user XP
  Future<void> _updateUserXP(String userId, int xpToAdd) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'xp': FieldValue.increment(xpToAdd),
      });

      // Update leaderboard
      await _updateLeaderboard(userId);
    } catch (e) {
      print('Error updating user XP: $e');
    }
  }

  // Update leaderboard
  Future<void> _updateLeaderboard(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) return;

      final userData = userDoc.data()!;
      await _firestore.collection('leaderboard').doc(userId).set({
        'name': userData['name'],
        'xp': userData['xp'],
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating leaderboard: $e');
    }
  }
}
