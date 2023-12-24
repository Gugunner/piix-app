import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/theme/app_theme_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

///A Riverpod Notifier Provider that handles 
///the [ThemeData] inside the [AppThemeData] singleton.
///
///To change the [ThemeData] use [set] and pass the new [ThemeData].
///To revert any change call [restore].
@Riverpod(keepAlive: true)
final class ThemePod extends _$ThemePod {
  @override
  ThemeData build() {
    AppThemeData();
    return AppThemeData().currentThemeData;
  }

  ///Changes the [themeData] of the [AppThemeData]
  ///singleton and of this.
  void set(ThemeData themeData) {
    AppThemeData().setThemeData(themeData);
    state = AppThemeData().currentThemeData;
  }

  ///Reverts any changes and resets the [themeData]
  ///of [AppThemeData] and this.
  void restore() {
    AppThemeData()..resetThemeData();
    state = AppThemeData().currentThemeData;
  }
}
