import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service to monitor network connectivity status
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();
  
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isOnline = true;

  /// Stream of connectivity status (true = online, false = offline)
  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  /// Current connectivity status
  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  /// Initialize the connectivity service
  Future<void> initialize() async {
    // Check initial connectivity
    await _updateConnectionStatus();
    
    // Emit initial status to stream
    _connectionStatusController.add(_isOnline);
    print('🌐 Initial connectivity emitted: ${_isOnline ? "ONLINE" : "OFFLINE"}');
    
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        _updateConnectionStatus();
      },
    );
  }

  /// Update connection status based on connectivity result
  Future<void> _updateConnectionStatus() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final wasOnline = _isOnline;
      
      // Check if any connection is available (not none)
      // Default to ONLINE if we get any connectivity result other than none
      final hasConnection = results.isNotEmpty && 
                           results.any((result) => result != ConnectivityResult.none);
      
      _isOnline = hasConnection;
      
      print('🌐 Connectivity check: ${_isOnline ? "ONLINE ✅" : "OFFLINE ❌"} (results: $results)');
      
      // Notify listeners if status changed
      if (wasOnline != _isOnline) {
        print('🌐 Status changed from ${wasOnline ? "ONLINE" : "OFFLINE"} to ${_isOnline ? "ONLINE" : "OFFLINE"}');
        _connectionStatusController.add(_isOnline);
      }
    } catch (e) {
      print('⚠️ Error checking connectivity: $e');
      // On error, assume ONLINE to avoid false offline warnings
      if (!_isOnline) {
        _isOnline = true;
        _connectionStatusController.add(true);
      }
    }
  }

  /// Manually check and update connectivity status
  Future<bool> checkConnectivity() async {
    await _updateConnectionStatus();
    return _isOnline;
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectionStatusController.close();
  }
}
