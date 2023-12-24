/// Provides constant regular expressions to validate inputs.
// ignore_for_file: prefer_single_quotes

class Validators {
  static const String emailValidator =
      r"^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?$";

  static const String passwordValidator =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&#.$($)$-$_])[A-Za-z\d$@$!%*?&#.$($)$-$_]{8,100}$";

  static const String nameValidator = r"^[A-zÀ-ú]{2,}(?: [A-zÀ-ú]*)*$";
  static const String phoneValidator = r"^\+\d{10,13}$";

  static const String noLadaPhoneValidator = r"^\d{10,13}$";
}
