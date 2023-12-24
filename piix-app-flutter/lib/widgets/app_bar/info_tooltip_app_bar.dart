import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_title.dart';
import 'package:piix_mobile/widgets/app_bar/defined_app_bar.dart';
import 'package:piix_mobile/widgets/tooltip/app_tooltip_barrel_file.dart';


///An [AppBar] that has a [title] and a tooltip.
final class InfoTooltipAppBar extends DefinedAppBar {
  InfoTooltipAppBar({
    super.key,
    required this.appBarTitle,
    required this.tooltipTitle,
    required this.tooltipDescription,
  }) : super(
          title: AppBarTitle(appBarTitle),
          actions: [
            SizedBox(width: 10.w),
            InfoIconTooltip(
                title: tooltipTitle, description: tooltipDescription)
          ],
        );

  final String appBarTitle;

  final String tooltipDescription;

  final String tooltipTitle;
}
