import 'package:intl/intl.dart';

extension CurrencyExtend on double {
  String get currencyFormat {
    final currency = NumberFormat('#,##0.00', 'es_MX');
    return currency.format(this);
  }
}
