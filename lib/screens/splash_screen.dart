import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/service_locator.dart';
import 'student/main_navigation_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    // Wait a bit for splash effect
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      // Auto login with demo student account
      final authService = ServiceLocator().authService;
      final user = await authService.login('nguyenvana', 'Student123');

      if (!mounted) return;

      if (user != null) {
        // Check if user has completed onboarding
        final prefs = await SharedPreferences.getInstance();
        final hasCompletedOnboarding = prefs.getBool('has_completed_onboarding') ?? false;

        if (!hasCompletedOnboarding) {
          // First time user - show onboarding
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        } else {
          // Returning user - go to main screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
          );
        }
      } else {
        // If auto login fails, go to login screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      // If error, go to login screen
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App icon/logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.school,
                size: 80,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 24),
            
            // App name
            const Text(
              'BeeGrammar',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            
            // Tagline
            const Text(
              'Học ngữ pháp tiếng Anh dễ dàng',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),
            
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 16),
            
            // Loading text
            const Text(
              'Đang tải...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
