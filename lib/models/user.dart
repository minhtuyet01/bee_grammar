enum UserRole {
  admin,
  student;

  String toJson() => name;

  static UserRole fromJson(String json) {
    return UserRole.values.firstWhere((e) => e.name == json);
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String passwordHash;
  final UserRole role;
  final bool isLocked;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  // Optional fields
  final String? fullName;
  final String? avatarUrl;
  final DateTime? dateOfBirth;
  final String? phone;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.role,
    this.isLocked = false,
    required this.createdAt,
    this.lastLoginAt,
    this.fullName,
    this.avatarUrl,
    this.dateOfBirth,
    this.phone,
  });

  // Validation methods
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email không được để trống';
    }
    if (!isValidEmail(email)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (password.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải có ít nhất 1 chữ hoa';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Mật khẩu phải có ít nhất 1 chữ thường';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải có ít nhất 1 số';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Tên đăng nhập không được để trống';
    }
    if (username.length < 3) {
      return 'Tên đăng nhập phải có ít nhất 3 ký tự';
    }
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(username)) {
      return 'Tên đăng nhập chỉ được chứa chữ, số và các ký tự . _ -';
    }
    return null;
  }

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'passwordHash': passwordHash,
      'role': role.toJson(),
      'isLocked': isLocked,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phone': phone,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      role: UserRole.fromJson(json['role'] as String),
      isLocked: json['isLocked'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      phone: json['phone'] as String?,
    );
  }

  // CopyWith method for updates
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? passwordHash,
    UserRole? role,
    bool? isLocked,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    String? fullName,
    String? avatarUrl,
    DateTime? dateOfBirth,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      isLocked: isLocked ?? this.isLocked,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
