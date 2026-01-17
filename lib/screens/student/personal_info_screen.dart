import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/service_locator.dart';
import '../../models/user.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  User? _currentUser;
  bool _isLoading = true;
  bool _isEditing = false;
  bool _isSaving = false;
  String _selectedAvatar = '';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    
    try {
      // Get user from Firebase
      final user = await ServiceLocator().firebaseAuthService.getCurrentUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
          _fullNameController.text = user.fullName ?? '';
          _emailController.text = user.email;
          _usernameController.text = user.username;
          
          // Load avatar from Firebase if exists, otherwise use first letter
          if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
            _selectedAvatar = user.avatarUrl!;
          } else {
            _selectedAvatar = user.fullName?.substring(0, 1).toUpperCase() ?? 
                             user.username.substring(0, 1).toUpperCase();
          }
          
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _showAvatarPicker() async {
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn ảnh đại diện'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Chọn từ thư viện'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('Chọn emoji'),
              onTap: () => Navigator.pop(context, 'emoji'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
        ],
      ),
    );

    if (choice == 'gallery') {
      await _pickImageFromGallery();
    } else if (choice == 'emoji') {
      await _pickEmoji();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _selectedAvatar = ''; // Clear emoji when image is selected
      });
    }
  }

  Future<void> _pickEmoji() async {
    final emojis = ['😀', '😎', '🤓', '🥳', '😇', '🤩', '🦸', '🧑‍💻', '👨‍🎓', '👩‍🎓', 
                    '🐝', '🦁', '🐯', '🦊', '🐼', '🐨', '🦄', '🌟', '⭐', '🎯'];
    
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn emoji'),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: emojis.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.pop(context, emojis[index]),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      emojis[index],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
        ],
      ),
    );

    if (selected != null) {
      setState(() {
        _selectedAvatar = selected;
        _selectedImage = null; // Clear image when emoji is selected
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      String? avatarToSave;
      
      // Determine what to save as avatar
      if (_selectedImage != null) {
        // TODO: Upload image to Firebase Storage and get URL
        // For now, we'll save a placeholder or skip image upload
        avatarToSave = 'image:${_selectedImage!.path}'; // Temporary placeholder
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ Upload ảnh chưa được hỗ trợ. Vui lòng chọn emoji.'),
            backgroundColor: Colors.orange,
          ),
        );
        setState(() => _isSaving = false);
        return;
      } else if (_selectedAvatar.isNotEmpty) {
        // Save emoji directly
        avatarToSave = _selectedAvatar;
      }

      // Update profile in Firebase
      await ServiceLocator().firebaseAuthService.updateProfile(
        name: _fullNameController.text.trim(),
        avatar: avatarToSave,
      );

      // Reload user data to reflect changes
      await _loadUserData();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Đã lưu thông tin thành công'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        _isEditing = false;
        _isSaving = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Thông tin cá nhân')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Thông tin cá nhân')),
        body: const Center(child: Text('Không tìm thấy thông tin người dùng')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() => _isEditing = true);
              },
              tooltip: 'Chỉnh sửa',
            )
          else ...[
            // Cancel button
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _isSaving
                  ? null
                  : () {
                      setState(() {
                        _isEditing = false;
                        // Reset form
                        _fullNameController.text = _currentUser!.fullName ?? '';
                        _emailController.text = _currentUser!.email;
                        _phoneController.text = '';
                        
                        // Restore avatar from user object
                        if (_currentUser!.avatarUrl != null && _currentUser!.avatarUrl!.isNotEmpty) {
                          _selectedAvatar = _currentUser!.avatarUrl!;
                        } else {
                          _selectedAvatar = _currentUser!.fullName?.substring(0, 1).toUpperCase() ?? 
                                           _currentUser!.username.substring(0, 1).toUpperCase();
                        }
                        _selectedImage = null;
                      });
                    },
              tooltip: 'Hủy',
            ),
            // Save button
            IconButton(
              icon: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.check),
              onPressed: _isSaving ? null : _saveChanges,
              tooltip: 'Lưu',
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar section
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _selectedImage != null
                          ? ClipOval(
                              child: Image.file(
                                _selectedImage!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Text(
                                _selectedAvatar,
                                style: TextStyle(
                                  fontSize: _selectedAvatar.length == 1 ? 56 : 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                            onPressed: _showAvatarPicker,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Form fields
              _buildInfoSection(
                title: 'Thông tin tài khoản',
                children: [
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Tên đăng nhập',
                    icon: Icons.person,
                    enabled: false, // Username không thể đổi
                    helperText: 'Tên đăng nhập không thể thay đổi',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _fullNameController,
                    label: 'Họ và tên',
                    icon: Icons.badge,
                    enabled: _isEditing,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ và tên';
                      }
                      if (value.length < 2) {
                        return 'Họ và tên phải có ít nhất 2 ký tự';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                    validator: User.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Số điện thoại',
                    icon: Icons.phone,
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        // Simple phone validation
                        if (value.length < 10) {
                          return 'Số điện thoại phải có ít nhất 10 số';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Số điện thoại chỉ chứa chữ số';
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildInfoSection(
                title: 'Thông tin khác',
                children: [
                  _buildInfoRow('Ngày tham gia', _formatDate(_currentUser!.createdAt)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    String? helperText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        helperText: helperText,
        border: const OutlineInputBorder(),
        filled: !enabled,
        fillColor: enabled 
            ? null 
            : Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[100],
      ),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
      ),
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Chưa có';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} phút trước';
      }
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
