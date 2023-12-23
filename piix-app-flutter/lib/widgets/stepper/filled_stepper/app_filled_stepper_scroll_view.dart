import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///A [CustomScrollView] that has a list of [slivers] as its children.
final class AppFilledStepperScrollView extends StatelessWidget {
  const AppFilledStepperScrollView({
    super.key,
    this.totalSteps = 1,
    this.currentStep = 0,
    this.slivers,
    this.toolbarHeight,
    this.expandedHeight,
    this.collapsedHeight,
  });

  ///The total number of [AppFilledStep] the [AppFilledStepper] will show.
  final int totalSteps;

  ///The total number of [AppFilledStep] will be [filled].
  final int currentStep;

  ///Content should be passed as [RenderSliver]
  final List<Widget>? slivers;

  final double? toolbarHeight;

  final double? expandedHeight;

  final double? collapsedHeight;

  ///The background color of the [SliverAppBar].
  Color get _backgroundColor => PiixColors.space;

  ///The foreground color of the [SliverAppBar].
  Color get _foregroundColor => PiixColors.primary;

  ///The height of the [SliverAppBar].
  double get _toolbarHeight => 65.h;

  ///The padding of the [background] property of the [FlexibleSpaceBar].
  EdgeInsets get _padding => EdgeInsets.fromLTRB(16.w, 50.h, 16.w, 0);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      //Builds a fixed AppBar that allows for backward navigation
      //and shows an AppFilledStepper.
      SliverAppBar(
        backgroundColor: _backgroundColor,
        foregroundColor: _foregroundColor,
        toolbarHeight: toolbarHeight ?? _toolbarHeight,
        expandedHeight: expandedHeight,
        collapsedHeight: collapsedHeight,
        leading: null,
        pinned: true,
        actions: [AppBarLogo(color: _foregroundColor), SizedBox(width: 16.w)],
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: _padding,
            child: AppFilledStepper(
              totalSteps: totalSteps,
              currentStep: currentStep,
            ),
          ),
        ),
      ),
      //Only shows the slivers if not null or not empty.
      if (slivers.isNotNullOrEmpty) ...slivers!,
    ]);
  }
}
