import 'package:flutter/material.dart';

class ValidatorProvider with ChangeNotifier {
  bool _error = false;
  String _user = '';
  String _password = '';
  bool _tapUser = false;
  bool _tapPassword = false;
  bool _isVisible = false;

  bool get error => _error;
  String get user => _user;
  String get password => _password;
  bool get tapUser => _tapUser;
  bool get tapPassword => _tapPassword;
  bool get isVisible => _isVisible;

  void clearProvider() {
    _error = false;
    _user = '';
    _password = '';
    _tapUser = false;
    _tapPassword = false;
    notifyListeners();
  }

  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  set user(String value) {
    _user = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set tapUser(bool value) {
    _tapUser = value;
    notifyListeners();
  }

  set tapPassword(bool value) {
    _tapPassword = value;
    notifyListeners();
  }

  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }
}
