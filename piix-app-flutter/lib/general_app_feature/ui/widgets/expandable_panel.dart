import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This widget render a expandable animated panel
///receives a panel header, and panel body.
///
class ExpandablePanel extends StatefulWidget {
  const ExpandablePanel(
      {super.key,
      required this.panelHeader,
      required this.panelBody,
      this.hasRowIcon = false,
      this.buttonExpandsWithPanel = true,
      this.horizontalPadding,
      this.verticalPadding,
      this.backgroundColor,
      this.buttonStyle,
      this.elevation = 0});
  final Widget panelHeader;
  final Widget panelBody;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? backgroundColor;
  final TextStyle? buttonStyle;
  //This property is to know if the texts to see more and see less should be
  //accompanied by the arrows below and above
  final bool hasRowIcon;
  //This property is to know if we want to show a button to see less at the
  // bottom of the panel or only have the button at the top
  final bool buttonExpandsWithPanel;
  final double elevation;

  @override
  State<ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {
  bool showPanelBody = false;
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  String get upButtonText => !showPanelBody
      ? PiixCopiesDeprecated.viewMoreText
      : PiixCopiesDeprecated.viewLessText;
  IconData get upButtonIcon => !showPanelBody
      ? Icons.keyboard_arrow_down_rounded
      : Icons.keyboard_arrow_up_rounded;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: widget.elevation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.h),
          child: Stack(
            children: [
              ExpansionPanelList(
                elevation: widget.elevation,
                animationDuration: const Duration(milliseconds: 350),
                expandedHeaderPadding: EdgeInsets.zero,
                children: [
                  ExpansionPanel(
                      backgroundColor:
                          widget.backgroundColor ?? PiixColors.actualStroke,
                      isExpanded: showPanelBody,
                      headerBuilder: (_, __) => widget.panelHeader,
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                widget.horizontalPadding ?? mediumPadding.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            widget.panelBody,
                            if (showPanelBody && widget.buttonExpandsWithPanel)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.verticalPadding ??
                                        mediumPadding.h),
                                child: GestureDetector(
                                  onTap: toggleExpanded,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        upButtonText,
                                        style: widget.buttonStyle ??
                                            context
                                                .accentTextTheme?.headlineLarge
                                                ?.copyWith(
                                              color: PiixColors.active,
                                            ),
                                      ),
                                      if (widget.hasRowIcon)
                                        Icon(
                                          upButtonIcon,
                                          color: PiixColors.activeButton,
                                        )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ))
                ],
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: toggleExpanded,
                  child: Container(
                    height: kMinInteractiveDimension,
                    color: widget.backgroundColor ?? PiixColors.actualStroke,
                    padding:
                        EdgeInsets.only(right: widget.horizontalPadding ?? 16),
                    child: Center(
                        child: Row(
                      children: [
                        Text(
                          upButtonText,
                          style: widget.buttonStyle ??
                              context.accentTextTheme?.headlineLarge?.copyWith(
                                color: PiixColors.active,
                              ),
                        ),
                        if (widget.hasRowIcon)
                          Icon(
                            upButtonIcon,
                            color: PiixColors.activeButton,
                          )
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleExpanded() {
    setState(() {
      showPanelBody = !showPanelBody;
    });
  }
}
