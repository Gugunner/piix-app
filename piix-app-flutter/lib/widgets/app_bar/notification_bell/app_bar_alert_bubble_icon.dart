import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/alert_bubble/alert_bubble.dart';

///Wraps an [Icon] inside a [Stack] and positions and [AlertBubble]
///with a [count] value inside the bubble.
class AlertBubbleIcon extends StatelessWidget {
  const AlertBubbleIcon(this.icon, {super.key, this.count = 0});

  final Icon icon;

  ///The value inside the [AlertBubble].
  final int count;

  ///The default right [Offset] of the [AlertBubble].
  @protected
  double get _right => 0;

  ///The default top [Offset] of the [AlertBubble].
  @protected
  double get _top => 0;

  ///The widht of the [Container].
  @protected
  double get _width => 40.w;

  ///The height of the [Container].
  @protected
  double get _height => 40.h;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            icon,
            Positioned(
              right: _right,
              top: _top,
              child: AlertBubble(count),
            ),
          ],
        ),
      ),
    );
  }
}
