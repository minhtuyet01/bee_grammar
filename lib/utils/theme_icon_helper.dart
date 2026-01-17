import 'package:flutter/material.dart';

/// Helper class to load theme-aware icons
class ThemeIconHelper {
  /// Get icon path based on current theme
  static String getIconPath(BuildContext context, String iconName) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final folder = isDark ? 'dark_mode' : 'light_mode';
    return 'assets/icons/$folder/$iconName';
  }

  /// Create Image widget for navigation icon
  static Widget buildNavigationIcon(BuildContext context, String iconName, {
    double size = 24,
    bool isSelected = false,
  }) {
    return Image.asset(
      getIconPath(context, iconName),
      width: size,
      height: size,
      color: isSelected 
          ? Theme.of(context).colorScheme.primary 
          : Colors.grey[600],
      colorBlendMode: BlendMode.srcIn,
    );
  }
}
