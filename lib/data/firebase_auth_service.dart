import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirebaseAuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current Firebase user
  firebase_auth.User? get currentFirebaseUser => _auth.currentUser;

  // Get current app user
  Future<User?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    try {
      final doc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      
      // Parse role
      final roleStr = data['role'] as String? ?? 'student';
      final role = roleStr == 'admin' ? UserRole.admin : UserRole.student;
      
      // Get username - use 'username' field if exists, otherwise fall back to 'name' or email
      final username = data['username'] as String? ?? 
                      data['name'] as String? ?? 
                      firebaseUser.email?.split('@')[0] ?? 
                      'user';
      
      // Get fullName - use 'fullName' field if exists, otherwise fall back to 'name'
      final fullName = data['fullName'] as String? ?? data['name'] as String?;
      
      // Get dateOfBirth
      final dateOfBirth = data['dateOfBirth'] != null
          ? (data['dateOfBirth'] as Timestamp).toDate()
          : null;
      
      // Get phone
      final phone = data['phone'] as String?;
      
      // Get avatar - check 'avatar' field (emoji or URL)
      final avatar = data['avatar'] as String?;
      
      return User(
        id: firebaseUser.uid,
        username: username,
        email: data['email'] as String,
        passwordHash: '', // Not stored in Firestore for security
        role: role,
        createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        fullName: fullName,
        avatarUrl: avatar, // Use avatar field for avatarUrl
        dateOfBirth: dateOfBirth,
        phone: phone,
      );
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      print('🔐 Attempting to sign in with email: $email');
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ Firebase auth successful for: ${credential.user?.email}');
      
      final user = await getCurrentUser();
      print('✅ Got user from Firestore: ${user?.username}');
      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Firebase auth error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('❌ Unexpected error during sign in: $e');
      rethrow;
    }
  }

  // Sign up with email and password
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    required String username,
    DateTime? dateOfBirth,
    String? phone,
  }) async {
    try {
      print('📝 Creating new user with email: $email');
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ Firebase auth user created: ${credential.user?.uid}');

      // Create user document in Firestore
      final userId = credential.user!.uid;
      print('📄 Creating Firestore document for user: $userId');
      
      final userData = {
        'email': email,
        'username': username,  // Username field - cannot be changed
        'fullName': name,      // Full name field - can be updated
        'name': name,          // Keep for backward compatibility
        'role': 'student',
        'level': 'A1',
        'xp': 0,
        'streak': 0,
        'diamonds': 0,
        'createdAt': FieldValue.serverTimestamp(),
      };
      
      // Add optional fields if provided
      if (dateOfBirth != null) {
        userData['dateOfBirth'] = Timestamp.fromDate(dateOfBirth);
      }
      if (phone != null) {
        userData['phone'] = phone;
      }
      
      await _firestore.collection('users').doc(userId).set(userData);
      print('✅ Firestore document created successfully');

      return await getCurrentUser();
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Firebase auth error during sign up: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('❌ Unexpected error during sign up: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? level,
    String? avatar,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    print('📝 Updating profile for user: $uid');
    
    final updates = <String, dynamic>{};
    if (name != null) {
      updates['fullName'] = name;  // Update fullName field only
      updates['name'] = name;      // Keep 'name' for backward compatibility
    }
    if (level != null) updates['level'] = level;
    if (avatar != null) updates['avatar'] = avatar;

    if (updates.isNotEmpty) {
      print('🔄 Updates to apply: $updates');
      await _firestore.collection('users').doc(uid).update(updates);
      print('✅ Profile updated successfully');
    } else {
      print('⚠️ No updates to apply');
    }
  }

  // Check if username is available
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.trim())
          .limit(1)
          .get();
      
      return query.docs.isEmpty;
    } catch (e) {
      print('Error checking username availability: $e');
      return false;
    }
  }

  // Check if email is available
  Future<bool> isEmailAvailable(String email) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email.trim().toLowerCase())
          .limit(1)
          .get();
      
      return query.docs.isEmpty;
    } catch (e) {
      print('Error checking email availability: $e');
      return false;
    }
  }

  // Check if phone is available
  Future<bool> isPhoneAvailable(String phone) async {
    try {
      // Remove spaces and dashes for comparison
      final cleanPhone = phone.replaceAll(RegExp(r'[\s-]'), '');
      
      final query = await _firestore
          .collection('users')
          .where('phone', isEqualTo: cleanPhone)
          .limit(1)
          .get();
      
      return query.docs.isEmpty;
    } catch (e) {
      print('Error checking phone availability: $e');
      return false;
    }
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này';
      case 'wrong-password':
        return 'Mật khẩu không đúng';
      case 'email-already-in-use':
        return 'Email đã được sử dụng';
      case 'invalid-email':
        return 'Email không hợp lệ';
      case 'weak-password':
        return 'Mật khẩu quá yếu (tối thiểu 6 ký tự)';
      case 'user-disabled':
        return 'Tài khoản đã bị vô hiệu hóa';
      default:
        return 'Đã xảy ra lỗi: ${e.message}';
    }
  }

  // ============================================
  // EMAIL VERIFICATION & PASSWORD RESET
  // ============================================

  /// Send email verification to current user
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('❌ No current user to send verification email');
        throw Exception('No user logged in');
      }
      
      print('📧 Sending verification email to: ${user.email}');
      await user.sendEmailVerification();
      print('✅ Verification email sent successfully');
    } catch (e) {
      print('❌ Error sending verification email: $e');
      rethrow;
    }
  }

  /// Check if current user's email is verified
  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  /// Reload current user to get latest verification status
  Future<void> reloadUser() async {
    try {
      await _auth.currentUser?.reload();
    } catch (e) {
      print('Error reloading user: $e');
      rethrow;
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (e is firebase_auth.FirebaseAuthException) {
        throw _handleAuthException(e);
      }
      rethrow;
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  /// Confirm password reset with oobCode
  Future<void> confirmPasswordReset({
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      print('🔐 Confirming password reset...');
      await _auth.confirmPasswordReset(
        code: oobCode,
        newPassword: newPassword,
      );
      print('✅ Password reset successful');
    } catch (e) {
      print('❌ Error confirming password reset: $e');
      rethrow;
    }
  }
}
