import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_user_form_feature_deprecated/utils/auth_step_state.dart';

class AuthUserFormUiProvider extends ChangeNotifier {
  ///State that handles the status of the user while filling
  ///and submitting the forms and updates ui widgets
  AuthStepState _stepState = AuthStepState.idle;
  AuthStepState get stepState => _stepState;
  void setStepState(AuthStepState state) {
    _stepState = state;
    notifyListeners();
  }

  ///Cleans all the states handled by this provider.
  void clearProvider() {
    _stepState = AuthStepState.idle;
    notifyListeners();
  }
}
