import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/widgets/tooltip/app_tooltip_barrel_file.dart';

///The base class that internally builds the different kinds of tooltips
///either a tooltip with [title] and/or [action] callback execution but it always
///contains a [description].
final class AppTooltipContent extends StatelessWidget {
  const AppTooltipContent(
    this.description, {
    super.key,
    this.title,
    this.action,
  });

  final String description;

  final String? title;

  final VoidCallback? action;

  ///The maximum width of the tooltip.
  @protected
  double get _width => 236.w;

  ///The minimum height of the tooltip.
  @protected
  double get _minHeight => 52.h;

  ///The maximum height of the tooltip.
  @protected
  double get _maxHeight => 400.h;

  ///The vertical margin between each element
  ///in the tooltip.
  @protected
  double get _space => 8.h;

  ///The vertical padding of the tooltip container.
  @protected
  double get _yPadding => 10.h;

  ///The horizontal padding of the tooltip container.
  @protected
  double get _xPadding => 6.w;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: _minHeight,
        maxHeight: _maxHeight,
      ),
      padding: EdgeInsets.fromLTRB(_xPadding, 0, _xPadding, _yPadding),
      width: _width,
      //If any overflow occurs this will prevent the tooltip
      //from showing an overflow ui error.
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Only shows the Tooltip title if it is not null
            if (title.isNotNullEmpty) ...[
              AppTooltipTitle(title!),
              SizedBox(
                height: _space,
              )
            ],
            //Always shows the Tooltip description
            AppTooltipDescription(description),
            //Only adds an action button if [action] is not null
            if (action != null) ...[
              SizedBox(
                height: _space,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppTooltipAction(action!, text: PiixCopiesDeprecated.view),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
