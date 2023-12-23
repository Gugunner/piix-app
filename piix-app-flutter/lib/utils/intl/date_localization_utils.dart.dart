import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///A utility class that works with [DateTime] conversion based
///on the [locale].
final class DateLocalizationUtils {
  ///Reads the current [Locale] value from stored context.
  static Locale getLocale(BuildContext context) =>
      Localizations.localeOf(context);
  
  ///Returns a 'dd/MM/y' format if the [countryCode] is 'MX'.
  ///If not returns a 'MM/dd/y' format.
  static DateFormat getDYMFormat(BuildContext context) {
    final countryCode = getLocale(context).countryCode;
    if (countryCode == 'MX') return DateFormat('dd/MM/y');
    return DateFormat('MM/dd/y');
  }

  ///Returns the passed on [date] 'dd/MM/y' format if the [countryCode] is 'MX'.
  ///If not returns a 'MM/dd/y' format.
  static String getDYM(BuildContext context, DateTime date) =>
      getDYMFormat(context).format(date);
}
