import 'package:flutter/material.dart';

/// Custom page transitions for better UX
class PageTransitions {
  /// Horizontal slide transition (main navigation)
  /// Used for: Lessons, Practice, Tests
  /// Duration: 250-300ms
  static Route<T> slideRight<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 275),
      reverseTransitionDuration: const Duration(milliseconds: 275),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Slide up transition
  /// Used for: Starting test, showing results
  /// Duration: ~300ms
  static Route<T> slideUp<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Fade + slide transition
  /// Used for: Summary/Result screens
  /// Duration: 300-350ms
  static Route<T> fadeSlide<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 325),
      reverseTransitionDuration: const Duration(milliseconds: 325),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.05);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        var slideTween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
    );
  }

  /// Shared Axis transition (Material Motion)
  /// Used for: Tab/section changes
  /// Android standard
  static Route<T> sharedAxis<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutCubic;

        // Fade out old page
        var fadeOutTween = Tween(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: const Interval(0.0, 0.35, curve: curve)),
        );

        // Fade in new page
        var fadeInTween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: const Interval(0.35, 1.0, curve: curve)),
        );

        // Slide new page
        var slideTween = Tween(begin: const Offset(0.05, 0.0), end: Offset.zero).chain(
          CurveTween(curve: const Interval(0.35, 1.0, curve: curve)),
        );

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeInTween),
            child: FadeTransition(
              opacity: secondaryAnimation.drive(fadeOutTween),
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// Helper method to replace Navigator.push with custom transition
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    TransitionType type = TransitionType.slideRight,
  }) {
    Route<T> route;
    switch (type) {
      case TransitionType.slideRight:
        route = slideRight<T>(page);
        break;
      case TransitionType.slideUp:
        route = slideUp<T>(page);
        break;
      case TransitionType.fadeSlide:
        route = fadeSlide<T>(page);
        break;
      case TransitionType.sharedAxis:
        route = sharedAxis<T>(page);
        break;
    }
    return Navigator.push<T>(context, route);
  }

  /// Helper method to replace Navigator.pushReplacement with custom transition
  static Future<T?> pushReplacement<T, TO>(
    BuildContext context,
    Widget page, {
    TransitionType type = TransitionType.slideRight,
    TO? result,
  }) {
    Route<T> route;
    switch (type) {
      case TransitionType.slideRight:
        route = slideRight<T>(page);
        break;
      case TransitionType.slideUp:
        route = slideUp<T>(page);
        break;
      case TransitionType.fadeSlide:
        route = fadeSlide<T>(page);
        break;
      case TransitionType.sharedAxis:
        route = sharedAxis<T>(page);
        break;
    }
    return Navigator.pushReplacement<T, TO>(context, route, result: result);
  }
}

/// Transition types enum
enum TransitionType {
  slideRight,  // Lessons, Practice, Tests
  slideUp,     // Start test, Show results
  fadeSlide,   // Summary/Result screens
  sharedAxis,  // Tab/section changes
}
