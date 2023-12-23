import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

extension BuildContextMediaQuery on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  ///Context height without the top and bottom padding
  double get remainingHeight =>
      height -
      MediaQuery.of(this).viewPadding.top -
      MediaQuery.of(this).viewPadding.bottom -
      MediaQuery.of(this).viewInsets.top -
      MediaQuery.of(this).viewInsets.bottom;

  TextTheme? get textTheme => Theme.of(this).textTheme;
  TextTheme? get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ///Additional theme not found in [ThemeData]
  TextTheme? get accentTextTheme => AccentTextTheme().textTheme;

  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
}

extension BuildContextTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
}

///A [BuildContext] extension used to call the [AppLocalizations]
///short methods variants.
extension LocalizationContext on BuildContext {
  ///Returns an [AppLocalizations] of (context).
  ///
  ///It should always have a [BuildContext] and [AppLocalizations]
  ///needs to be declared in [MaterialApp].
  AppLocalizations get localeMessage => AppLocalizations.of(this)!;
}