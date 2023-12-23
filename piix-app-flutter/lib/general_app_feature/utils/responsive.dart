import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class Responsive {
  Responsive({required this.width, required this.height, required this.inch});

  factory Responsive.of(BuildContext context) {
    final data = MediaQuery.of(context);
    final size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  final double width, height, inch;

  double wp(double percent) => width * percent / 100;

  double hp(double percent) => height * percent / 100;

  double ip(double percent) => inch * percent / 100;
}
