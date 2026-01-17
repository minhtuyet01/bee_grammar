class RegistrationErrors {
  // Uniqueness errors
  static const emailInUse = 'Email đã được đăng ký';
  static const phoneInUse = 'SĐT đã được đăng ký';
  static const usernameInUse = 'Tên đăng nhập đã được sử dụng';
  
  // Format errors
  static const invalidEmail = 'Email không đúng định dạng';
  static const invalidPhone = 'Số điện thoại không đúng định dạng (10-11 số)';
  
  // Password errors
  static const weakPassword = 'Mật khẩu không đủ mạnh';
  static const shortPassword = 'Mật khẩu quá ngắn (tối thiểu 6 ký tự)';
  static const passwordMismatch = 'Mật khẩu và xác nhận mật khẩu không khớp';
  
  // Other errors
  static const termsNotAgreed = 'Vui lòng đồng ý với điều khoản';
  static const invalidAge = 'Bạn phải từ 13 tuổi trở lên để đăng ký';
  static const requiredField = 'Trường này là bắt buộc';
  static const nameTooShort = 'Họ và tên phải có ít nhất 2 ký tự';
  static const usernameTooShort = 'Tên đăng nhập phải có ít nhất 3 ký tự';
  static const usernameTooLong = 'Tên đăng nhập không được quá 20 ký tự';
  static const usernameInvalidChars = 'Tên đăng nhập chỉ được chứa chữ, số và các ký tự . _ -';
}

enum PasswordStrength {
  weak,
  medium,
  strong,
}

class RegistrationValidators {
  // Validate full name
  static String? validateFullName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return RegistrationErrors.requiredField;
    }
    if (name.trim().length < 2) {
      return RegistrationErrors.nameTooShort;
    }
    return null;
  }

  // Validate username
  static String? validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return RegistrationErrors.requiredField;
    }
    
    final trimmed = username.trim();
    
    if (trimmed.length < 3) {
      return RegistrationErrors.usernameTooShort;
    }
    
    if (trimmed.length > 20) {
      return RegistrationErrors.usernameTooLong;
    }
    
    // Allow alphanumeric and common special characters (. _ -)
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(trimmed)) {
      return RegistrationErrors.usernameInvalidChars;
    }
    
    return null;
  }

  // Validate email
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return RegistrationErrors.requiredField;
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(email.trim())) {
      return RegistrationErrors.invalidEmail;
    }
    
    return null;
  }

  // Validate phone number (Vietnamese format)
  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return RegistrationErrors.requiredField;
    }
    
    // Remove spaces and dashes
    final cleaned = phone.replaceAll(RegExp(r'[\s-]'), '');
    
    // Vietnamese phone: 10-11 digits, starts with 0
    if (!RegExp(r'^0[0-9]{9,10}$').hasMatch(cleaned)) {
      return RegistrationErrors.invalidPhone;
    }
    
    return null;
  }

  // Validate password
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return RegistrationErrors.requiredField;
    }
    
    if (password.length < 6) {
      return RegistrationErrors.shortPassword;
    }
    
    return null;
  }

  // Validate password match
  static String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return RegistrationErrors.requiredField;
    }
    
    if (password != confirmPassword) {
      return RegistrationErrors.passwordMismatch;
    }
    
    return null;
  }

  // Validate age (must be 13+)
  static String? validateAge(DateTime? dateOfBirth) {
    if (dateOfBirth == null) {
      return RegistrationErrors.requiredField;
    }
    
    final now = DateTime.now();
    final age = now.year - dateOfBirth.year;
    final hasHadBirthdayThisYear = now.month > dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day >= dateOfBirth.day);
    
    final actualAge = hasHadBirthdayThisYear ? age : age - 1;
    
    if (actualAge < 13) {
      return RegistrationErrors.invalidAge;
    }
    
    return null;
  }

  // Get password strength
  static PasswordStrength getPasswordStrength(String password) {
    if (password.length < 6) return PasswordStrength.weak;
    
    int score = 0;
    
    // Length bonus
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Has uppercase
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    
    // Has lowercase
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    
    // Has numbers
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    
    // Has special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;
    
    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }
}
