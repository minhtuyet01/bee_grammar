import 'package:flutter/foundation.dart';
import '../services/connectivity_service.dart';

/// Provider for connectivity status
class ConnectivityProvider extends ChangeNotifier {
  final ConnectivityService _connectivityService;
  bool _isOnline = true;

  ConnectivityProvider(this._connectivityService) {
    // Get initial status from service
    _isOnline = _connectivityService.isOnline;
    print('📱 ConnectivityProvider initialized: ${_isOnline ? "ONLINE" : "OFFLINE"}');
    
    // Listen to connectivity changes
    _connectivityService.connectionStatus.listen((isOnline) {
      print('📱 ConnectivityProvider received update: ${isOnline ? "ONLINE" : "OFFLINE"}');
      if (_isOnline != isOnline) {
        _isOnline = isOnline;
        print('📱 ConnectivityProvider notifying widgets: ${_isOnline ? "ONLINE" : "OFFLINE"}');
        notifyListeners();
      }
    });
  }

  /// Current connectivity status
  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  /// Manually check connectivity
  Future<bool> checkConnectivity() async {
    final isOnline = await _connectivityService.checkConnectivity();
    if (_isOnline != isOnline) {
      _isOnline = isOnline;
      notifyListeners();
    }
    return isOnline;
  }
}
