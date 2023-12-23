import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

class UiBLoC with ChangeNotifier {
  String _fromRoute = '';
  String get fromRoute => _fromRoute;
  set fromRoute(String value) {
    _fromRoute = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _loadText = ConstantsDeprecated.placeHolderString;
  String get loadText => _loadText;
  set loadText(String value) {
    _loadText = value;
    notifyListeners();
  }

  bool _isHeightUp = false;
  bool get isHeightUp => _isHeightUp;
  set isHeightUp(bool value) {
    _isHeightUp = value;
    notifyListeners();
  }

  bool _isLargeContainer = false;
  bool get isLargeContainer => _isLargeContainer;
  set isLargeContainer(bool value) {
    _isLargeContainer = value;
    notifyListeners();
  }

  bool _isOpenTopAlert = true;
  bool get isOpenTopAlert => _isOpenTopAlert;
  set isOpenTopAlert(bool value) {
    _isOpenTopAlert = value;
    notifyListeners();
  }

  /// Clear the current state of the BLoC.
  void clearProvider() {
    _fromRoute = '';
    _isLoading = false;
    _loadText = '';
    _isHeightUp = false;
    _isLargeContainer = false;
    _isOpenTopAlert = false;
    notifyListeners();
  }
}
