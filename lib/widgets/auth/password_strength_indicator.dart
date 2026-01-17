import 'package:flutter/material.dart';
import '../../utils/registration_validators.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = RegistrationValidators.getPasswordStrength(password);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: _getProgressValue(strength),
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(_getColor(strength)),
                minHeight: 4,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _getLabel(strength),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _getColor(strength),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _getHint(strength),
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  double _getProgressValue(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 0.33;
      case PasswordStrength.medium:
        return 0.66;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  Color _getColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
    }
  }

  String _getLabel(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Yếu';
      case PasswordStrength.medium:
        return 'Trung bình';
      case PasswordStrength.strong:
        return 'Mạnh';
    }
  }

  String _getHint(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Thêm chữ hoa, số và ký tự đặc biệt để tăng độ mạnh';
      case PasswordStrength.medium:
        return 'Mật khẩu khá tốt, có thể thêm ký tự đặc biệt';
      case PasswordStrength.strong:
        return 'Mật khẩu rất mạnh!';
    }
  }
}
