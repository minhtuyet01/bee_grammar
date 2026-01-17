import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

class DeepLinkService {
  final _appLinks = AppLinks();
  StreamSubscription? _sub;
  
  /// Initialize deep link listening
  Future<void> initialize(BuildContext context) async {
    // Handle initial link if app was opened from link
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleLink(initialLink, context);
      }
    } catch (e) {
      print('Error getting initial link: $e');
    }

    // Listen for links while app is running
    _sub = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _handleLink(uri, context);
      },
      onError: (err) {
        print('Error listening to link stream: $err');
      },
    );
  }

  /// Handle incoming deep link
  void _handleLink(Uri uri, BuildContext context) {
    print('🔗 Deep link received: $uri');
    
    // Extract query parameters
    final mode = uri.queryParameters['mode'];
    final oobCode = uri.queryParameters['oobCode'];
    
    print('Mode: $mode, oobCode: ${oobCode?.substring(0, 10)}...');

    if (mode == 'resetPassword' && oobCode != null) {
      // Navigate to reset password screen
      Navigator.pushNamed(
        context,
        '/reset-password',
        arguments: oobCode,
      );
    } else if (mode == 'verifyEmail' && oobCode != null) {
      // Handle email verification if needed
      print('Email verification link detected');
    } else {
      print('Unknown link mode or missing oobCode');
    }
  }

  /// Dispose subscription
  void dispose() {
    _sub?.cancel();
  }
}
