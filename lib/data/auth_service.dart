import '../models/user.dart';

/// Simple authentication service for demonstration
/// In production, this would integrate with Firebase Auth or similar
abstract class AuthService {
  Future<User?> login(String username, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<User?> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  });
}

class InMemoryAuthService implements AuthService {
  final Map<String, User> _users = {};
  User? _currentUser;
  
  // Initialize with mock users
  void initializeWithUsers(List<User> users) {
    _users.clear();
    for (final user in users) {
      _users[user.username] = user;
    }
  }
  
  @override
  Future<User?> login(String username, String password) async {
    final user = _users[username];
    
    if (user == null) {
      throw Exception('Tên đăng nhập không tồn tại');
    }
    
    if (user.isLocked) {
      throw Exception('Tài khoản đã bị khóa');
    }
    
    // In real app, compare hashed passwords
    if (user.passwordHash != password) {
      throw Exception('Mật khẩu không đúng');
    }
    
    // Update last login
    final updatedUser = user.copyWith(lastLoginAt: DateTime.now());
    _users[username] = updatedUser;
    _currentUser = updatedUser;
    
    return updatedUser;
  }
  
  @override
  Future<void> logout() async {
    _currentUser = null;
  }
  
  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return _currentUser != null;
  }
  
  @override
  Future<User?> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    // Validate username doesn't exist
    if (_users.containsKey(username)) {
      throw Exception('Tên đăng nhập đã tồn tại');
    }
    
    // Validate email format
    final emailError = User.validateEmail(email);
    if (emailError != null) {
      throw Exception(emailError);
    }
    
    // Validate password strength
    final passwordError = User.validatePassword(password);
    if (passwordError != null) {
      throw Exception(passwordError);
    }
    
    // Validate username
    final usernameError = User.validateUsername(username);
    if (usernameError != null) {
      throw Exception(usernameError);
    }
    
    // Create new user
    final newUser = User(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      username: username,
      email: email,
      passwordHash: password, // In real app, hash this
      role: UserRole.student, // Default role
      fullName: fullName,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
    
    _users[username] = newUser;
    _currentUser = newUser;
    
    return newUser;
  }
  
  // ==========================================
  // ADMIN METHODS
  // ==========================================
  
  /// Get all users (admin only)
  Future<List<User>> getAllUsers() async {
    return _users.values.toList();
  }
  
  /// Lock/unlock user account (admin only)
  Future<void> toggleUserLock(String userId) async {
    final user = _users.values.firstWhere(
      (u) => u.id == userId,
      orElse: () => throw Exception('User not found'),
    );
    
    final updatedUser = user.copyWith(isLocked: !user.isLocked);
    _users[user.username] = updatedUser;
    
    // If current user is locked, log them out
    if (_currentUser?.id == userId && updatedUser.isLocked) {
      await logout();
    }
  }
  
  /// Get user by ID
  Future<User?> getUserById(String userId) async {
    try {
      return _users.values.firstWhere((u) => u.id == userId);
    } catch (e) {
      return null;
    }
  }
  
  /// Check if current user is admin
  Future<bool> isAdmin() async {
    final user = await getCurrentUser();
    return user?.role == UserRole.admin;
  }
  
  /// Clear all data
  void clearAll() {
    _users.clear();
    _currentUser = null;
  }
}
