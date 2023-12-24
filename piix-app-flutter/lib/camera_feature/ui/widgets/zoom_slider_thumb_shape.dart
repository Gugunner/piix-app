
import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

import 'package:piix_mobile/utils/utils_barrel_file.dart';

///Draws a rounded thumb shape for the [Slider] with 
///the inner [value] also drawn as a [TextSpan].
final class ZoomSliderThumbShape extends SliderComponentShape {
  const ZoomSliderThumbShape({
    required this.buildContext,
    this.radius = 10,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
    this.min = 1,
    this.max = 1,
  });

  ///The context where this thumb is drawn into.
  final BuildContext buildContext;

  ///The size of the thumb.
  final double radius;

  final double elevation;

  final double pressedElevation;

  ///The minimum value allowed in the [Slider].
  final int min;

  ///The maximum value allowed in the [Slider].
  final int max;
  
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(radius);

  ///Returns the [String] value normalized to the number of zeros
  ///represented in the [min] and [max] values. For example
  ///```
  ///1 + (10-1)*0.5 = 5.5
  ///5.5.round() = 6
  ///6.toString() = '6'
  ///'6' + 'x' = '6x'
  ///return '6x'
  ///```
  String _getValue(double value) {
    return (min + (max - min) * value).round().toString() + 'x';
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;

    final paint = Paint()
      ..color =
          ColorUtils.lighten(PiixColors.contrast, 0.1) //Thumb Background Color
      ..style = PaintingStyle.fill;
    
    //Creates the text which is to be drawn in the canvas
    final span = TextSpan(
      style: buildContext.labelLarge?.copyWith(
        color: PiixColors.space,
      ),
      text: _getValue(value),
    );

    //Using a special painter it transforms the
    //span into an SVG.
    final tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    //Computes the visual position of the painter and its content.
    tp.layout();
    //Centers the text by using its computed width and computed height
    //and the context center drawing this shape.
    final textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));
    
    canvas.drawCircle(center, radius * .9, paint);
    //Draws the paint with the computed position into the canvas and 
    //positions it at the center.
    tp.paint(canvas, textCenter);
  }
}
 