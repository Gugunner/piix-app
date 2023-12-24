import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///A [Row] element that shows a [badge] and a [title] with a
///possible [description].
final class AppBadgeStepper extends StatelessWidget {
  const AppBadgeStepper({
    super.key,
    required this.badge,
    required this.title,
    this.description,
    this.color,
    this.valueColor,
  });

  ///Normally an element that shows the number of the step shown
  final Widget badge;

  final Widget title;

  final Widget? description;

  final Color? color;

  final Color? valueColor;

  double get _gap => 16.w;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(flex: 1, child: badge),
        SizedBox(width: _gap),
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              if (description != null) description!,
            ],
          ),
        )
      ],
    );
  }
}
