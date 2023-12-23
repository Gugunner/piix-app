import 'package:flutter/material.dart';

@Deprecated('Will be removed in 4.0')
enum AnimationStatesDeprecated { IDLE, LOADING, FINISH }

@Deprecated('Will be removed in 4.0')

///This class contains a states for app animations
///
class AnimationBLoCDeprecated with ChangeNotifier {
  AnimationStatesDeprecated _quotationAnimatedState =
      AnimationStatesDeprecated.IDLE;
  AnimationStatesDeprecated get quotationAnimatedState =>
      _quotationAnimatedState;
  set quotationAnimatedState(AnimationStatesDeprecated state) {
    _quotationAnimatedState = state;
    notifyListeners();
  }
}
