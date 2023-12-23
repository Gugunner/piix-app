import 'package:flutter/material.dart';

class AnimatorProvider with ChangeNotifier {
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
}
