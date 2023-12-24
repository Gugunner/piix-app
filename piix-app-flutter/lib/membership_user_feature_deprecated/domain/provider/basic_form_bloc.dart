import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/data/repository/basic_form_repository.dart';

///This class is a logic component that manages the basic form module.
@Deprecated('Use instead AuthUserFormProvider')
class BasicFormBLoC with ChangeNotifier {
  BasicFormState _basicFormState = BasicFormState.idle;
  BasicFormState get basicFormState => _basicFormState;
  set basicFormState(BasicFormState state) {
    _basicFormState = state;
    notifyListeners();
  }

  /// Clear the current state of the basic form.
  void clearProvider([bool clearAll = false]) {
    basicFormState = BasicFormState.idle;
    notifyListeners();
  }
}
