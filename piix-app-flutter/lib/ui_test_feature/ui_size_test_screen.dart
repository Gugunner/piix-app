import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class UiSizeTestScreen extends StatelessWidget {
  const UiSizeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final screenHeight = context.height;
    return Scaffold(
      body: ColumnBox(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          color: Colors.pink,
          child: ColumnBox(
            screenHeight: screenHeight.fifteenSubtractionPercent,
            screenWidth: screenWidth.fifteenSubtractionPercent,
            color: Colors.green,
            child: ColumnBox(
              screenHeight: screenHeight.thirtySubtractionPercent,
              screenWidth: screenWidth.thirtySubtractionPercent,
              color: Colors.orange,
              child: ColumnBox(
                screenHeight: screenHeight.fortyFiveSubtractionPercent,
                screenWidth: screenWidth.fortyFiveSubtractionPercent,
                color: Colors.purple,
                child: ColumnBox(
                    screenHeight: screenHeight.sixtySubtractionPercent,
                    screenWidth: screenWidth.sixtySubtractionPercent,
                    color: Colors.blue,
                    child: ColumnBox(
                      screenHeight: screenHeight.seventyFiveSubtractionPercent,
                      screenWidth: screenWidth.seventyFiveSubtractionPercent,
                      color: Colors.yellow,
                      child: const SizedBox(),
                    )),
              ),
            ),
          )),
    );
  }
}

class ColumnBox extends StatelessWidget {
  const ColumnBox({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.color,
    required this.child,
  });

  final double screenHeight;
  final double screenWidth;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          color: color,
          child: Stack(
            children: [
              child,
              Positioned(
                top: 0,
                right: 0,
                child: Transform(
                  alignment: Alignment.bottomRight, //origin: Offset(100, 100)
                  transform: Matrix4.rotationZ(-1.57),
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      'H-> ${screenHeight.toStringAsFixed(2)}, '
                      'W-> ${screenWidth.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              RowButtons(screenHeight: screenHeight, screenWidth: screenWidth),
              Positioned(
                  bottom: screenHeight * 0.11,
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      'BH-> ${(screenHeight * 0.10).toStringAsFixed(2)},'
                      'BW-> ${(screenWidth * 0.20).toStringAsFixed(2)}',
                    ),
                  )),
              Positioned(
                  bottom: screenHeight * 0.11 + 18,
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      'BHSP-> ${20.h.toStringAsFixed(2)},'
                      'BWSP-> ${40.w.toStringAsFixed(2)}',
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class RowButtons extends StatelessWidget {
  const RowButtons({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: screenHeight * 0.10,
            width: screenWidth * 0.20,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Botón elevado 12',
                  style: TextStyle(fontSize: 12.sp),
                )),
          ),
          SizedBox(
            height: 20.h,
            width: 40.w,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Botón elevado 12',
                  style: TextStyle(fontSize: 12.sp),
                )),
          ),
        ],
      ),
    );
  }
}

extension PercentSubtractionExtended on double {
  double get fifteenSubtractionPercent {
    return this - (this * 0.15);
  }

  double get thirtySubtractionPercent {
    return this - (this * 0.30);
  }

  double get fortyFiveSubtractionPercent {
    return this - (this * 0.45);
  }

  double get sixtySubtractionPercent {
    return this - (this * 0.60);
  }

  double get seventyFiveSubtractionPercent {
    return this - (this * 0.75);
  }
}
