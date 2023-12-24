import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

//TODO: Analyze and refactor for 4.0
///This class is responsible for using a freehand tool to draw the discount
///ribbon for the detail of combos
///
class DiscountRibbonDetailDrawing extends CustomClipper<Path> {
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  double get smallPadding => ConstantsDeprecated.minPadding;
  double get verticalPadding => 3;
  double get zero => 0;
  double get heigthFactor => 0.5;

  @override
  Path getClip(Size size) {
    final path = Path();
    //We move the pencil to the initial position in x and y
    path.moveTo(size.width - mediumPadding.w, zero);
    //We lower the pencil three pixels in y
    path.lineTo(size.width - mediumPadding.w, verticalPadding.h);
    //In that same x position we move the pencil to the width of the figure
    path.lineTo(size.width, verticalPadding.h);
    //We generate a diagonal to the middle of y
    path.lineTo(size.width - smallPadding.w, size.height * heigthFactor);
    //We return the diagonal to the maximum point in y
    path.lineTo(size.width, size.height);
    //We draw on axis x 16 pixels
    path.lineTo(size.width - mediumPadding.w, size.height);
    //We go up 3 pixels on and to generate a small step
    path.lineTo(size.width - mediumPadding.w, size.height - verticalPadding.h);
    //We draw a react line from this point, up to 16 pixels from the beginning
    path.lineTo(mediumPadding.w, size.height - verticalPadding.h);
    //We go up 3 pixels on and to generate a small step
    path.lineTo(mediumPadding.w, size.height);
    //We draw a line to position 0 in x and y
    path.lineTo(zero, size.height);
    //We generate a diagonal to the middle of y
    path.lineTo(smallPadding.w, size.height * heigthFactor);
    //We return the diagonal to the maximum point in y
    path.lineTo(zero, verticalPadding.h);
    //We draw on axis x 16 pixels
    path.lineTo(mediumPadding.w, verticalPadding.h);
    //We go down 3 pixels on and to generate a small step
    path.lineTo(mediumPadding.w, zero);
    //We clos de trace
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
