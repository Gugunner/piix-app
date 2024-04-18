import 'package:flutter/material.dart';

/// An extension that provides a getter for the theme of the current context.
extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}