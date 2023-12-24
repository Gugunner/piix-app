import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/stepper/app_stepper_barrel_file.dart';

///Use when working with multiple [AppBadgeStepper]s inside
///a screen or a [Dialog].
abstract mixin class StepperAppBadgeStepper {
  double get _bottomMargin => 16.h;

  int get _titleMaxLines => 2;

  @mustBeOverridden
  Map<int, List<String>> getSteps(BuildContext context);

  Widget getAppStepper(
      MapEntry<int, List<String>> entry, BuildContext context) {
    final value = entry.key;
    final title = entry.value[0];
    final description = entry.value[1];
    return Container(
      margin: EdgeInsets.only(bottom: _bottomMargin),
      child: AppBadgeStepper(
        badge: AppBadge(value),
        title: Text(
          title,
          style: context.primaryTextTheme?.titleSmall,
          maxLines: _titleMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
        description: Text(
          description,
          style: context.bodyMedium,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
