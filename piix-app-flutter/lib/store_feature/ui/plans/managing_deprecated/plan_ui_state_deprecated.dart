import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';

@Deprecated('Will be removed in 4.0')
class PlanUiStateDeprecated {
  PlanUiStateDeprecated({required this.setState});
  final StateSetter setState;

  AlertStateDeprecated _planAlertState = AlertStateDeprecated.hide;
  AlertStateDeprecated get planAlertState => _planAlertState;
  set planAlertState(AlertStateDeprecated value) {
    _planAlertState = value;
    setState(() {});
  }

  AlertTypeDeprecated _planAlertType = AlertTypeDeprecated.none;
  AlertTypeDeprecated get planAlertType => _planAlertType;
  set planAlertType(AlertTypeDeprecated type) {
    _planAlertType = type;
    setState(() {});
  }

  ///This function is used for hide plan alert automatically
  ///
  void hidePlanAlert() {
    Future.delayed(const Duration(seconds: 3), () {
      planAlertState = AlertStateDeprecated.hide;
    });
  }

  void cleanState() {
    _planAlertState = AlertStateDeprecated.hide;
    _planAlertType = AlertTypeDeprecated.none;
  }
}
