import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///Declares the countour of a tag shape, padding and radius.
abstract base class TagCountour extends StatelessWidget {
  const TagCountour(
    this.color, {
    super.key,
    required this.minWidth,
    required this.maxWidth,
    required this.child,
  });

  ///The content of the tag.
  final Widget child;

  ///The background color of a tag.
  final Color color;
  final double minWidth;
  final double maxWidth;

  ///The universal height of a tag
  @protected
  double get height => 16.h;
  @protected
  double get radius => 4.w;
  @protected
  double get xPadding => 8.w;
  @protected
  double get yPadding => 0.h;
}

///A simple tag that shows a colored container with a bordered
///radius and the [child] content.
final class SimpleTagCountour extends TagCountour {
  const SimpleTagCountour(
    super.color, {
    super.key,
    required super.minWidth,
    required super.maxWidth,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: height,
        maxHeight: height,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: xPadding,
        vertical: yPadding,
      ),
      child: child,
    );
  }
}

final class ActionableTagCountour extends TagCountour {
  const ActionableTagCountour(
    super.color, {
    super.key,
    required super.child,
    required super.minWidth,
    required super.maxWidth,
    this.action,
  });

  ///The callback to execute when the tag is pressed.
  final VoidCallback? action;

  ///The color that appears as an inksplash when
  ///pressing the tag.
  @protected
  Color get _splashColor => PiixColors.primary;

  @override
  Widget build(BuildContext context) {
    ///When there is no callback function [this] behaves as a simple tag
    if (action == null)
      return SimpleTagCountour(color,
          minWidth: minWidth, maxWidth: maxWidth, child: child);

    return Material(
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: InkWell(
          onTap: action,
          splashColor: _splashColor,
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            constraints: BoxConstraints(
              minWidth: minWidth,
              maxWidth: maxWidth,
              minHeight: height,
              maxHeight: height,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: xPadding,
              vertical: yPadding,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
