import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///Builds a series of [AppFilledStep] that can either be
///[filled] or [empty] separated by [SizedBox].
///
///The total number of [AppFilledStep] can be determined by the [totalSteps], 
///where the decision of being [filled] or [empty] 
///is based on the [currentStep].
///
///To determine the correct width of each [AppFilledStep] the [_availableWidth]
///is divided by the [totalSteps] and substracted the [_gap] which is the space
///between each [AppFilledStep].
///
///To determine the [_totalGaps] is just substracting one to the 
///[totalSteps].
final class AppFilledStepper extends StatelessWidget {
  const AppFilledStepper({
    super.key,
    this.totalSteps = 1,
    this.currentStep = 0,
  }) : assert(totalSteps <= 10);

  ///The number of [AppFilledStep] that must be 
  ///built.
  final int totalSteps;
  ///The maximum number of [AppFilledStep] that are
  ///to be filled.
  final int currentStep;

  ///The total width that can be covered by the [AppFilledStep]s
  ///and the [SizedBox]es gaps.
  double get _availableWidth => 288.w;

  ///The width of the [SizedBox] gap.
  double get _gap => 2.w;

  ///The width of each [AppFilledStep].
  double get _width => (_availableWidth / totalSteps) - _gap;

  ///The number of [SizedBox]es gaps.
  int get _totalGaps => totalSteps - 1;

  @override
  Widget build(BuildContext context) {
    //Always restart the number of [AppFilledStep]
    //at one.
    var remainingSteps = 1;
    return Row(
      children: [
        //Generates a list of Widgets that alternate between
        //an AppFilledStep and a SizedBox.
        ...List.generate(
          totalSteps + _totalGaps,
          (index) {
            //Every odd value returns a SizedBox gap
            if (index % 2 == 1) {
              return SizedBox(width: _gap);
            } 
            //Checks if the AppFilledStep should be filled or not.
            final filled = currentStep - remainingSteps >= 0;
            //Increas in one the remainingSteps until it reaches currentStep.
            remainingSteps++;
            return Flexible(
              child: AppFilledStep(
                width: _width,
                filled: filled,
              ),
            );
          },
        ),
      ],
    );
  }
}
