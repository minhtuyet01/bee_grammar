import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../data/service_locator.dart';
import '../../l10n/app_localizations.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _isLoading = true;
  
  // Notification settings
  Map<String, bool> _settings = {};
  TimeOfDay _dailyReminderTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    
    try {
      final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;
      
      final prefs = await ServiceLocator().firebaseUserPreferencesService.getUserPreferences(userId);
      final notificationSettings = prefs['notificationSettings'] as Map<String, dynamic>? ?? {};
      
      setState(() {
        _settings = notificationSettings.map((key, value) => MapEntry(key, value as bool));
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading notification settings: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    try {
      final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;
      
      await ServiceLocator().firebaseUserPreferencesService.updateNotificationSettings(userId, _settings);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.settingsSaved),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error saving notification settings: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lỗi khi lưu cài đặt'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleAllNotifications(bool value) async {
    // Request permission if enabling
    if (value) {
      final granted = await ServiceLocator().firebaseMessagingService.requestPermission();
      if (!granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('⚠️ Quyền thông báo bị từ chối'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      
      // Get and save FCM token
      final token = await ServiceLocator().firebaseMessagingService.getToken();
      if (token != null) {
        final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await ServiceLocator().firebaseUserPreferencesService.saveFCMToken(userId, token);
        }
      }
    }
    
    setState(() {
      _settings['allNotifications'] = value;
      if (!value) {
        // Turn off all notifications
        _settings['dailyReminder'] = false;
        _settings['streakReminder'] = false;
        _settings['streakMilestone'] = false;
        _settings['lessonComplete'] = false;
        _settings['categoryComplete'] = false;
        _settings['systemUpdates'] = false;
      } else {
        // Turn on recommended notifications
        _settings['dailyReminder'] = true;
        _settings['streakReminder'] = true;
        _settings['streakMilestone'] = true;
        _settings['lessonComplete'] = true;
        _settings['systemUpdates'] = true;
      }
    });
    await _saveSettings();
  }

  void _updateNotificationSetting(String key, bool value) {
    setState(() {
      _settings[key] = value;
      
      // Update all notifications toggle
      _settings['allNotifications'] = _settings['dailyReminder']! ||
          _settings['streakReminder']! ||
          _settings['streakMilestone']! ||
          _settings['lessonComplete']! ||
          _settings['categoryComplete']! ||
          _settings['systemUpdates']!;
    });
    _saveSettings();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _dailyReminderTime,
    );
    if (picked != null) {
      setState(() {
        _dailyReminderTime = picked;
      });
      // Save time to preferences
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cài đặt Thông báo')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    
    final allNotifications = _settings['allNotifications'] ?? true;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt Thông báo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Master toggle
          Card(
            elevation: 2,
            child: SwitchListTile(
              value: allNotifications,
              onChanged: _toggleAllNotifications,
              title: const Text(
                'Bật tất cả thông báo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                allNotifications ? 'Nhận tất cả thông báo' : 'Tắt tất cả thông báo',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              secondary: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: allNotifications
                      ? const Color(0xFFD4A574).withOpacity(0.2)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  allNotifications ? Icons.notifications_active : Icons.notifications_off,
                  color: allNotifications
                      ? const Color(0xFFD4A574)
                      : Colors.grey[600],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section: Daily Reminders
          _buildSectionHeader('Nhắc học hàng ngày', Icons.alarm),
          const SizedBox(height: 8),
          _buildNotificationTile(
            title: 'Nhắc học mỗi ngày',
            subtitle: 'Nhắc bạn học để duy trì streak',
            icon: Icons.notifications,
            value: _settings['dailyReminder'] ?? true,
            onChanged: (value) => _updateNotificationSetting('dailyReminder', value),
            enabled: allNotifications,
          ),
          if (_settings['dailyReminder'] == true)
            Card(
              margin: const EdgeInsets.only(bottom: 8, left: 16),
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Giờ nhắc'),
                subtitle: Text(_dailyReminderTime.format(context)),
                trailing: const Icon(Icons.chevron_right),
                onTap: allNotifications ? _selectTime : null,
                enabled: allNotifications,
              ),
            ),
          const SizedBox(height: 16),

          // Section: Streak
          _buildSectionHeader('Thông báo Streak', Icons.local_fire_department),
          const SizedBox(height: 8),
          _buildNotificationTile(
            title: 'Nhắc duy trì streak',
            subtitle: 'Nhắc khi chưa học trong ngày',
            icon: Icons.warning_amber,
            value: _settings['streakReminder'] ?? true,
            onChanged: (value) => _updateNotificationSetting('streakReminder', value),
            enabled: allNotifications,
          ),
          _buildNotificationTile(
            title: 'Milestone streak',
            subtitle: 'Thông báo khi đạt 7, 30, 100 ngày',
            icon: Icons.emoji_events,
            value: _settings['streakMilestone'] ?? true,
            onChanged: (value) => _updateNotificationSetting('streakMilestone', value),
            enabled: allNotifications,
          ),
          const SizedBox(height: 16),

          // Section: Progress
          _buildSectionHeader('Thông báo Tiến độ', Icons.trending_up),
          const SizedBox(height: 8),
          _buildNotificationTile(
            title: 'Hoàn thành bài học',
            subtitle: 'Thông báo khi hoàn thành bài học',
            icon: Icons.check_circle,
            value: _settings['lessonComplete'] ?? true,
            onChanged: (value) => _updateNotificationSetting('lessonComplete', value),
            enabled: allNotifications,
          ),
          _buildNotificationTile(
            title: 'Hoàn thành chủ đề',
            subtitle: 'Thông báo khi đạt 100% một chủ đề',
            icon: Icons.stars,
            value: _settings['categoryComplete'] ?? false,
            onChanged: (value) => _updateNotificationSetting('categoryComplete', value),
            enabled: allNotifications,
          ),
          const SizedBox(height: 16),

          // Section: System
          _buildSectionHeader('Thông báo Hệ thống', Icons.settings),
          const SizedBox(height: 8),
          _buildNotificationTile(
            title: 'Cập nhật & Bảo trì',
            subtitle: 'Nội dung mới, cập nhật hệ thống',
            icon: Icons.system_update,
            value: _settings['systemUpdates'] ?? true,
            onChanged: (value) => _updateNotificationSetting('systemUpdates', value),
            enabled: allNotifications,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFFD4A574)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool enabled,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        value: value,
        onChanged: enabled ? onChanged : null,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: enabled 
                ? (isDark ? Colors.white : Colors.black87)
                : Colors.grey[400],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: enabled 
                ? (isDark ? Colors.grey[400] : Colors.grey[600])
                : Colors.grey[400],
          ),
        ),
        secondary: Icon(
          icon,
          color: enabled
              ? (value ? const Color(0xFFD4A574) : Colors.grey[600])
              : Colors.grey[400],
        ),
      ),
    );
  }
}
