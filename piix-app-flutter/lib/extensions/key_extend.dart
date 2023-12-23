import 'package:flutter/material.dart';

/// Extensions for GlobalKey class to make it easier to work with keys.
extension KeyExtend on GlobalKey {
  /// Get [Offset] from a [Widget] by its [Key].
  Offset get offset {
    final box = currentContext!.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }
}
