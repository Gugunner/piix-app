import 'package:flutter/cupertino.dart';

/// Extensions for [Widget] class to shorten features that are too long to implement natively.
extension WidgetExtend on Widget {
  /// Returns a [Widget] with a padding in all directions.
  Widget padAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Returns a [Widget] with horizontal padding.
  Widget padHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  /// Returns a [Widget] with vertical padding.
  Widget padVertical(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  /// Returns a [Widget] with either vertical padding, horizontal padding, or both.
  Widget padSymmetric({required double horizontal, required double vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Returns a [Widget] with top padding.
  Widget padTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  /// Returns a [Widget] with bottom padding.
  Widget padBottom(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  /// Returns a [Widget] with left padding.
  Widget padLeft(double value) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  /// Returns a [Widget] with right padding.
  Widget padRight(double value) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  /// Returns a [Widget] with padding only in the given values.
  Widget padOnly({double? top, double? bottom, double? left, double? right}) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        left: left ?? 0,
        right: right ?? 0,
      ),
      child: this,
    );
  }

  /// Returns a list of [length] times the [Widget].
  List<Widget> operator *(int length) {
    return List.generate(length, (index) => this);
  }

  ///Center a widget
  Widget center() => Center(
        child: this,
      );
}
