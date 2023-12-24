import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';

///This provider contains all state, variables and methods for home screen
///
//TODO: Check implementation of Home provider
class HomeProvider with ChangeNotifier {
  HomeStateDeprecated _homeState = HomeStateDeprecated.idle;
  HomeStateDeprecated get homeState => _homeState;
  void setHomeState(HomeStateDeprecated state) {
    _homeState = state;
    notifyListeners();
  }
}
