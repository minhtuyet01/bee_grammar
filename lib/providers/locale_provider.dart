import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../data/firebase_user_preferences_service.dart';
import '../data/service_locator.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('vi');
  final FirebaseUserPreferencesService _preferencesService = ServiceLocator().firebaseUserPreferencesService;
  
  Locale get locale => _locale;
  
  LocaleProvider() {
    _loadLocale();
  }
  
  Future<void> _loadLocale() async {
    try {
      final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;
      
      final prefs = await _preferencesService.getUserPreferences(userId);
      final languageCode = prefs['language'] as String? ?? 'vi';
      
      _locale = Locale(languageCode);
      notifyListeners();
    } catch (e) {
      print('Error loading locale: $e');
    }
  }
  
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    
    _locale = locale;
    notifyListeners();
    
    // Save to Firebase
    try {
      final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await _preferencesService.updateLanguage(userId, locale.languageCode);
      }
    } catch (e) {
      print('Error saving locale: $e');
    }
  }
  
  void clearLocale() {
    _locale = const Locale('vi');
    notifyListeners();
  }
}
