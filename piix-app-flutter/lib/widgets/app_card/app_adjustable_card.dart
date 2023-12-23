import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
// import 'package:piix_mobile/widgets/widget/app_calculated_widget.dart';

///An adjustable [Card] Widget that based on the [parent]
///[parentWidth] and [parentHeight] determines the custom padding needed.
///
///It can also determine if the [child] should be wrapped inside a
///[SingleChildScrollView] by passing [scroll] set as true.
final class AppAdjustableCard extends StatelessWidget {
  const AppAdjustableCard({
    super.key,
    required this.child,
    required this.parentHeight,
    required this.parentWidth,
    this.scroll = false,
    this.color,
  });

  final Widget child;

  final double parentHeight;

  final double parentWidth;

  ///Pass [true] if the [child] should be wrapped
  ///inside a [SingleChildScrollView].
  final bool scroll;

  final Color? color;

  @protected
  double get _radius => 8.w;

  ///Returns a specific [padding] based on the W x H dimensions of the [parent]
  ///Widget.
  @protected
  double get _currentPadding {
    if (parentWidth < 68.w && parentHeight <= 32.h) return 4.w;
    if (parentWidth < 141.w && parentHeight <= 32.h) return 8.w;
    if (parentWidth >= 141.w && parentHeight <= 160.h) return 12.w;
    return 16.w;
  }

  @protected
  Color get _shadowColor => PiixColors.shadowCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shadowColor: _shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(_currentPadding),
        child: Builder(builder: (context) {
          if (scroll)
            return SingleChildScrollView(
              child: child,
            );
          return child;
        }),
      ),
    );
  }
}
