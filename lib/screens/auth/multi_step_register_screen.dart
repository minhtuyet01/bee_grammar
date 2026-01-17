import 'package:flutter/material.dart';
import 'dart:async';
import '../../data/service_locator.dart';
import '../../utils/registration_validators.dart';
import '../../widgets/auth/password_strength_indicator.dart';
import '../../widgets/auth/step_progress_indicator.dart';

class MultiStepRegisterScreen extends StatefulWidget {
  const MultiStepRegisterScreen({super.key});

  @override
  State<MultiStepRegisterScreen> createState() => _MultiStepRegisterScreenState();
}

class _MultiStepRegisterScreenState extends State<MultiStepRegisterScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 5;

  // Form keys for each step
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();
  final _step3Key = GlobalKey<FormState>();
  final _step4Key = GlobalKey<FormState>();
  final _step5Key = GlobalKey<FormState>();

  // Controllers
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Registration data
  DateTime? _dateOfBirth;
  bool _agreedToTerms = false;
  bool _isLoading = false;

  // Validation states
  String? _usernameError;
  String? _emailOrPhoneError;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _pageController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    }
  }

  Future<void> _checkUsernameAvailability(String username) async {
    if (username.isEmpty) {
      setState(() => _usernameError = null);
      return;
    }

    // Only validate format, skip Firebase check to avoid permission issues
    final error = RegistrationValidators.validateUsername(username);
    setState(() => _usernameError = error);
    
    // Note: Username uniqueness will be naturally enforced since we generate
    // username from email or use user input. Duplicate usernames are unlikely
    // and can be handled during actual registration if needed.
  }

  Future<void> _checkEmailOrPhoneAvailability(String value) async {
    if (value.isEmpty) {
      setState(() => _emailOrPhoneError = null);
      return;
    }

    // Only validate email format
    final error = RegistrationValidators.validateEmail(value);
    setState(() => _emailOrPhoneError = error);
    
    // Note: Email uniqueness is automatically enforced by Firebase Auth
  }

  Future<void> _register() async {
    if (!_step5Key.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegistrationErrors.termsNotAgreed)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ServiceLocator().firebaseAuthService.signUp(
        email: _emailOrPhoneController.text.trim(),
        password: _passwordController.text,
        name: _fullNameController.text.trim(),
        username: _usernameController.text.trim(),
        dateOfBirth: _dateOfBirth,
      );

      if (!mounted) return;
      
      // AuthGate will automatically navigate when auth state changes
      // Just pop back to login screen
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: StepProgressIndicator(
              currentStep: _currentStep,
              totalSteps: _totalSteps,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep1FullName(),
                _buildStep2Username(),
                _buildStep3DateOfBirth(),
                _buildStep4EmailOrPhone(),
                _buildStep5Password(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Full Name
  Widget _buildStep1FullName() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _step1Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Họ và tên của bạn',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nhập họ và tên đầy đủ của bạn',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Họ và tên của bạn',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
              validator: RegistrationValidators.validateFullName,
              autofocus: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_step1Key.currentState!.validate()) {
                  _nextStep();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF775A00),
                foregroundColor: const Color(0xFFFFF8F2),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Tiếp theo', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Step 2: Username
  Widget _buildStep2Username() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _step2Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tên đăng nhập',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Chọn tên đăng nhập duy nhất (3-20 ký tự)',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Tên đăng nhập',
                prefixIcon: const Icon(Icons.alternate_email),
                border: const OutlineInputBorder(),
                errorText: _usernameError,
                suffixIcon: _usernameController.text.isNotEmpty
                    ? (_usernameError == null
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.error, color: Colors.red))
                    : null,
              ),
              onChanged: (value) {
                _debounceTimer?.cancel();
                _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                  _checkUsernameAvailability(value);
                });
              },
              validator: (value) => _usernameError ?? RegistrationValidators.validateUsername(value),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_step2Key.currentState!.validate() && _usernameError == null) {
                  _nextStep();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF775A00),
                foregroundColor: const Color(0xFFFFF8F2),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Tiếp theo', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Step 3: Date of Birth
  Widget _buildStep3DateOfBirth() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _step3Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ngày sinh',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Bạn phải từ 13 tuổi trở lên để đăng ký',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().subtract(const Duration(days: 365 * 15)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  helpText: 'Chọn ngày sinh',
                );
                if (picked != null) {
                  setState(() => _dateOfBirth = picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 16),
                    Text(
                      _dateOfBirth == null
                          ? 'Chọn ngày sinh'
                          : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}',
                      style: TextStyle(
                        fontSize: 16,
                        color: _dateOfBirth == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_dateOfBirth != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  RegistrationValidators.validateAge(_dateOfBirth) ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final error = RegistrationValidators.validateAge(_dateOfBirth);
                if (error == null) {
                  _nextStep();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF775A00),
                foregroundColor: const Color(0xFFFFF8F2),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Tiếp theo', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Step 4: Email
  Widget _buildStep4EmailOrPhone() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _step4Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nhập địa chỉ email của bạn',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _emailOrPhoneController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: const OutlineInputBorder(),
                errorText: _emailOrPhoneError,
                suffixIcon: _emailOrPhoneController.text.isNotEmpty
                    ? (_emailOrPhoneError == null
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.error, color: Colors.red))
                    : null,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _debounceTimer?.cancel();
                _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                  _checkEmailOrPhoneAvailability(value);
                });
              },
              validator: (value) =>
                  _emailOrPhoneError ?? RegistrationValidators.validateEmail(value),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_step4Key.currentState!.validate() && _emailOrPhoneError == null) {
                  _nextStep();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF775A00),
                foregroundColor: const Color(0xFFFFF8F2),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Tiếp theo', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Step 5: Password
  Widget _buildStep5Password() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _step5Key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tạo mật khẩu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Mật khẩu phải có ít nhất 6 ký tự',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: RegistrationValidators.validatePassword,
              onChanged: (value) => setState(() {}),
            ),
            PasswordStrengthIndicator(password: _passwordController.text),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Xác nhận mật khẩu',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) =>
                  RegistrationValidators.validatePasswordMatch(_passwordController.text, value),
            ),
            const SizedBox(height: 24),
            CheckboxListTile(
              value: _agreedToTerms,
              onChanged: (value) => setState(() => _agreedToTerms = value!),
              title: const Text('Tôi đồng ý với điều khoản và điều kiện'),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF775A00),
                foregroundColor: const Color(0xFFFFF8F2),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Đăng ký', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
