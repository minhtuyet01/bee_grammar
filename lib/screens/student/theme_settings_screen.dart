import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  String _selectedTheme = 'system'; // 'light', 'dark', 'system'

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTheme = prefs.getString('theme_mode') ?? 'system';
    });
  }

  Future<void> _saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme);
    setState(() {
      _selectedTheme = theme;
    });
    
    // Apply theme immediately using ThemeProvider
    if (mounted) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      switch (theme) {
        case 'light':
          themeProvider.setThemeMode(ThemeMode.light);
          break;
        case 'dark':
          themeProvider.setThemeMode(ThemeMode.dark);
          break;
        case 'system':
          themeProvider.setThemeMode(ThemeMode.system);
          break;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã chuyển sang chế độ ${_getThemeName(theme)}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  String _getThemeName(String theme) {
    switch (theme) {
      case 'light':
        return 'Sáng';
      case 'dark':
        return 'Tối';
      case 'system':
        return 'Theo hệ thống';
      default:
        return 'Theo hệ thống';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao diện'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Light Mode
          _buildThemeOption(
            'light',
            'Sáng',
            'Giao diện sáng, dễ nhìn ban ngày',
            Icons.wb_sunny,
            Colors.orange,
          ),
          const SizedBox(height: 12),

          // Dark Mode
          _buildThemeOption(
            'dark',
            'Tối',
            'Giao diện tối, dễ chịu cho mắt',
            Icons.nightlight_round,
            Colors.indigo,
          ),
          const SizedBox(height: 12),

          // System Mode
          _buildThemeOption(
            'system',
            'Theo hệ thống',
            'Tự động theo cài đặt thiết bị',
            Icons.settings_suggest,
            Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    String value,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final isSelected = _selectedTheme == value;
    
    return InkWell(
      onTap: () => _saveThemePreference(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
