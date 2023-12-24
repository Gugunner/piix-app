import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';

class MembershipAlertUiProvider with ChangeNotifier {
  bool _isOpenTopAlert = false;
  bool get isOpenTopAlert => _isOpenTopAlert;

  bool _isOpenFormsAlert = false;
  bool get isOpenFormsAlert => _isOpenFormsAlert;

  bool _isOpenTicketAlert = false;
  bool get isOpenTicketAlert => _isOpenTicketAlert;

  void closeMembershipAlertByType(MembershipAlert alertType) {
    switch (alertType) {
      case MembershipAlert.additionalForms:
        _isOpenFormsAlert = false;
        break;
      case MembershipAlert.emptyBasicForm:
      case MembershipAlert.basicInformation:
        _isOpenTopAlert = false;
        break;
      case MembershipAlert.ticketsFound:
        _isOpenTicketAlert = false;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void openAllMembershipAlerts() {
    _isOpenFormsAlert = true;
    _isOpenTicketAlert = true;
    _isOpenTopAlert = true;
    notifyListeners();
  }
}
