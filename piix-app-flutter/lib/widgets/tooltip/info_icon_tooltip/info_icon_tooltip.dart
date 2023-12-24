import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/widgets/app_bar/app_bar_icon.dart';
import 'package:piix_mobile/widgets/tooltip/app_tooltip_barrel_file.dart';
import 'package:super_tooltip/super_tooltip.dart';

///A specific information icon [GestureDetector] that
///triggers an [AppTooltip].
final class InfoIconTooltip extends StatefulWidget {
  const InfoIconTooltip({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;

  final String description;

  @override
  State<InfoIconTooltip> createState() => _InfoIconTooltipState();
}

class _InfoIconTooltipState extends State<InfoIconTooltip> {
  ///The controller which handles showing and hiding the tooltip.
  final SuperTooltipController _controller = SuperTooltipController();

  ///The width of the [SizedBox] for the [AppBarIcon].
  @protected
  double get _width => 40.w;
  ///The height of the [SizedBox] for the [AppBarIcon].
  @protected
  double get _height => 40.h;
  ///The direction offset where the [AppTooltip] will appear from
  ///the [AppBarIcon].
  @protected
  TooltipDirection get _direction => TooltipDirection.down;

  ///Handles showing the tooltip
  void _onPressed() {
    _controller.showTooltip();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: AppTooltip(
        popupDirection: _direction,
        controller: _controller,
        //The tooltip content
        content: AppTooltipContent(
          widget.description,
          title: widget.title,
        ),
        //The child containint the tooltip
        child: SizedBox(
          width: _width,
          height: _height,
          child: AppBarIcon(Icons.info_outline),
        ),
      ),
    );
  }
}
