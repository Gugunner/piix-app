import 'package:flutter/material.dart';

mixin class AppRegex {
  bool validEmail(String email) => RegExp(emailRegex).hasMatch(email);
  bool validPhone(String phone) => RegExp(noLadaPhoneRegex).hasMatch(phone);
  bool validPassword(String password) =>
      RegExp(passwordRegex).hasMatch(password);
  bool validInvitationCode(String code) =>
      RegExp(alphanumericRegex).hasMatch(code);

  bool validName(String name) =>
      RegExp(nameRegex).hasMatch(name) && name.characters.length < 50;
}

const String emailRegex =
    r"^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$";

const String noLadaPhoneRegex = r'^\d{10}$';

const String passwordRegex =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{1,}$';

const String twoDecimalsRegex = r'^(\d+)?\.?\d{0,2}';

const String integerRegex = r'^[0-9]{1,}';

const String integerPercentageRegex = r'^(\d{0,3})';

const String twoDecimalsPercentageRegex = r'^(\d{0,3})(\.\d{0,2})?';

const String alphanumericRegex = r'^[a-zA-Z0-9]*$';

const String nameRegex = r'^[A-zÀ-ú]{2,}(?: [A-zÀ-ú]*)*$';
