import 'package:flutter/material.dart';

///This class contains all bussines logic for the notifications.
class NotificationBLoC extends ChangeNotifier {
  int _membershipNotifications = 0;
  int get membershipNotifications => _membershipNotifications;
  set membershipNotifications(int valor) {
    _membershipNotifications = valor;
    notifyListeners();
  }

  int _protectedNotifications = 0;
  int get protectedNotifications => _protectedNotifications;
  set protectedNotifications(int valor) {
    _protectedNotifications = valor;
    notifyListeners();
  }

  int _ticketNotifications = 0;
  int get ticketNotifications => _ticketNotifications;
  set ticketNotifications(int valor) {
    _ticketNotifications = valor;
    notifyListeners();
  }

  int _totalNotifications = 0;
  int get totalNotifications => _totalNotifications;
  set totalNotifications(int valor) {
    _totalNotifications = valor;
    notifyListeners();
  }

  AnimationController? _closeSnackController;

  AnimationController? get closeSnackController => _closeSnackController;

  set closeSnackController(AnimationController? controller) {
    _closeSnackController = controller;
  }

  void notificationSum() {
    _totalNotifications = _membershipNotifications + _protectedNotifications;
    notifyListeners();
  }

  void sumMembershipNotification(int notificationNumber) {
    _membershipNotifications += notificationNumber;
    notificationSum();
  }

  void decreaseMembershipsNotifications() {
    _membershipNotifications--;
    _totalNotifications--;
    notifyListeners();
  }

  void clearNotifications() {
    _membershipNotifications = 0;
    _totalNotifications = 0;
    _protectedNotifications = 0;
    notifyListeners();
  }
}
