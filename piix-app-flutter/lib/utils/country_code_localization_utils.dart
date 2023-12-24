import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


///Contains all the methods use to parse and read country codes.
class CountryCodeLocalizationUtils {
  ///Returns a map where the key is the country code and the value
  ///is the country phone code.
  static Map<String, String> get countryCodesMap => {
        'MX': '+52',
        'US': '+1',
      };

  ///Reads the a ISO 3166-1 alpha-2 two-letter [countryCode] 
  ///and then converts it to an  ascii code 
  ///which later adds the html regional indicator symbol '127397' [https://en.wikipedia.org/wiki/Regional_indicator_symbol]
  ///to obtain the emoji flag unicode.
  static String toEmojiFlagUnicode(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) {
      if (match.group(0) != null) {
        return String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397);
      }
      return 'NA';
    });
  }

  ///Returns the country code by passing an emoji [flagUnicode]
  ///passing the value to ascii and then substracting the 
  ///html regional indicator symbol '127397' [https://en.wikipedia.org/wiki/Regional_indicator_symbol].
  static String toCountryCode(String flagUnicode) {
    return flagUnicode.runes.map((c) {
      //Checks for spaces
      if (c == 32) return '';
      return String.fromCharCode(c - 127397);
    }).join();
  }

  ///Returns the [countryCodesMap] filtered by the [supportedLocales]
  ///found in [AppLocalizations].
  static List<MapEntry<String, String>> get _selectedCountryCodes {
    final countryCodesMap = CountryCodeLocalizationUtils.countryCodesMap;
    final localesWithCountryCodes = AppLocalizations.supportedLocales
        .map((locale) => locale.countryCode)
        .whereNotNull()
        .toList();
    return countryCodesMap.entries
        .where((map) => localesWithCountryCodes.contains(map.key))
        .toList();
  }

  ///Returns a list of values conformed by the 'flagEmoji' and the
  ///'countryPhoneCode'.
 static List<String> get countryPhoneCodesWithIndicator {
    
    return _selectedCountryCodes.map((entry) {
      final flagEmoji =
          CountryCodeLocalizationUtils.toEmojiFlagUnicode(entry.key);
      final countryPhoneCode = entry.value;
      return '$flagEmoji $countryPhoneCode';
    }).toList();
  }
}
