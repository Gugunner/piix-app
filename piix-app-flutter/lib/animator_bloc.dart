import 'package:flutter/cupertino.dart';

/// This BLoC is used to manage animations in the app.
class AnimatorBLoC with ChangeNotifier {
  bool _expandAddress = false;
  bool _expandEmergencyContact = false;

  bool get expandAddress => _expandAddress;
  bool get expandEmergencyContact => _expandEmergencyContact;

  set expandAddress(bool value) {
    _expandAddress = value;
    notifyListeners();
  }

  set expandEmergencyContact(bool value) {
    _expandEmergencyContact = value;
    notifyListeners();
  }

  /// Clear the current state of the BLoC.
  void clear() {
    _expandAddress = false;
    _expandEmergencyContact = false;
    notifyListeners();
  }
}
