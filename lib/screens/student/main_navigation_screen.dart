import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/service_locator.dart';
import 'new_home_screen.dart';
import 'practice_screen.dart';
import 'test_screen.dart';
import 'profile_screen.dart';
import 'learning_history_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/theme_icon_helper.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  // 4-tab structure: Home, Practice, Tests, Profile
  final List<Widget> _screens = const [
    NewHomeScreen(),
    PracticeScreen(),
    TestScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define titles for each tab
    final titles = ['Trang chủ', 'Luyện Tập', 'Kiểm tra', 'Hồ sơ'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          // History button (only on Test tab)
          if (_currentIndex == 2)
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'Lịch sử làm bài',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LearningHistoryScreen(),
                  ),
                );
              },
            ),
          // Persistent streak indicator (hidden on Profile tab)
          if (_currentIndex != 3)
            StreamBuilder<Map<String, dynamic>>(
              stream: ServiceLocator().firebaseUserProgressService.streamUserProgress(
                FirebaseAuth.instance.currentUser?.uid ?? '',
              ),
              builder: (context, snapshot) {
                final progress = snapshot.data ?? {'streak': 0};
                
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '${progress['streak']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(context, 'home_icon.png', Icons.home_outlined, false),
            activeIcon: _buildIcon(context, 'home_icon.png', Icons.home_outlined, true),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(context, 'practive_icon.png', Icons.fitness_center_outlined, false),
            activeIcon: _buildIcon(context, 'practive_icon.png', Icons.fitness_center_outlined, true),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(context, 'test_icon.png', Icons.quiz_outlined, false),
            activeIcon: _buildIcon(context, 'test_icon.png', Icons.quiz_outlined, true),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(context, 'profile_icon.png', Icons.person_outline, false),
            activeIcon: _buildIcon(context, 'profile_icon.png', Icons.person_outline, true),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, String iconName, IconData fallbackIcon, bool isSelected) {
    Widget iconWidget;
    
    try {
      iconWidget = Image.asset(
        ThemeIconHelper.getIconPath(context, iconName),
        width: 45,
        height: 45,
        errorBuilder: (context, error, stackTrace) {
          return Icon(fallbackIcon, size: 45);
        },
      );
    } catch (e) {
      iconWidget = Icon(fallbackIcon, size: 45);
    }

    // Wrap with circular background if selected
    if (isSelected) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFD4A574), // Brown pastel color
          shape: BoxShape.circle,
        ),
        child: iconWidget,
      );
    }
    
    return iconWidget;
  }
}
