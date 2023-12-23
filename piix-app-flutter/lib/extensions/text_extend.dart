import 'package:flutter/cupertino.dart';

/// Extensions for [Text] widget to shorten properties and functionalities.
extension TextExtend on Text {
  /// Returns a [Text] widget with the given color.
  Text color(Color color) {
    return Text(data!,
        style: style != null
            ? style!.copyWith(color: color)
            : TextStyle(color: color));
  }
}
