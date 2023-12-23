import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';

class PaymentsUiState {
  PaymentsUiState({required this.setState});
  final StateSetter setState;
  //Handles the mounted value of the stateful widget that calls this
  //controller class
  bool _mounted = false;
  void setMounted(bool mounted) {
    _mounted = mounted;
  }

  AlertStateDeprecated _paymentMethodAlertState = AlertStateDeprecated.show;
  AlertStateDeprecated get paymentMethodAlertState => _paymentMethodAlertState;
  set paymentMethodAlertState(AlertStateDeprecated value) {
    _paymentMethodAlertState = value;
    if (!_mounted) return;
    setState(() {});
  }

  ///This function is used for hide plan alert automatically
  ///
  void hidePaymentMethodAlert(bool mounted) {
    setMounted(mounted);
    paymentMethodAlertState = AlertStateDeprecated.hide;
  }

  void cleanState(bool mounted) {
    setMounted(mounted);
    paymentMethodAlertState = AlertStateDeprecated.show;
  }
}
