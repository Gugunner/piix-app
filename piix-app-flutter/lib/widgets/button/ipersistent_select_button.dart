import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///An interface used for the buttons that can store
///a [select] property and keep the [selected] color
///even after the button is no longer pressed.
abstract interface class IPersistentSelectButton {
  ///Receives a [buttonStyle] and changes the [backgroundColor]
  ///and [foregroundColor] of the [buttonStyle].
  ///
  ///Use deep copy to avoid any errors and change the colors
  ///using [MaterialStateProperty] instantiation.
  ButtonStyle? onSelected(
    ButtonStyle? buttonStyle, {
    Color backgroundColor = PiixColors.primary,
    Color foregroundColor = PiixColors.space,
  });
}
