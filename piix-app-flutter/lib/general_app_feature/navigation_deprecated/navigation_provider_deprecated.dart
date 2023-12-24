import 'package:flutter/material.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';

///This class contains all methods and variables for navigation
///
@Deprecated('Use instead BottomNavigationPod')
class NavigationProviderDeprecated with ChangeNotifier {
  int _currentNavigationBottomTab = 0;
  int get currentNavigationBottomTab => _currentNavigationBottomTab;
  void setCurrentNavigationBottomTab(int tab) {
    _currentNavigationBottomTab = tab;
    notifyListeners();
  }

  void navigatesToProtectedTab() {
    setCurrentNavigationBottomTab(1);
    NavigatorKeyState().navigateToHomeRoute();
  }

  void clearProvider() {
    _currentNavigationBottomTab = 0;
    notifyListeners();
  }
}
