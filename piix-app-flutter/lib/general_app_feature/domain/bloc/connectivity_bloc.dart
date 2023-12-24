import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// This BLoC is used to check the internet connection.
class ConnectivityBLoC extends ChangeNotifier {
  ConnectivityBLoC() {
    init();
  }

  bool _fullConnection = false;
  bool get fullConnection => _fullConnection;
  set fullConnection(bool value) {
    _fullConnection = value;
    notifyListeners();
  }

  bool _isConnectionAvailable = true;
  bool get isConnectionAvailable => _isConnectionAvailable;
  set isConnectionAvailable(bool value) {
    _isConnectionAvailable = value;
    notifyListeners();
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  ConnectivityResult get connectivityResult => _connectivityResult;
  set connectivityResult(ConnectivityResult value) {
    _connectivityResult = value;
    notifyListeners();
  }

  late StreamSubscription<ConnectivityResult> _subscription;
  Future<void> init() async {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      debugPrint('Result changed - $result');
      _connectivityResult = result;
      final hasConnection = await InternetConnectionChecker().hasConnection;
      fullConnection =
          hasConnection && connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
