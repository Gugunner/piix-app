import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/banner/banner_barrel_file.dart';

///A sealed class that allows building specific banners
///like an enum by using the switch pattern configuration.
///
///```
///var record = (title, action, actionText);
///switch (record) {
///	 (var t?, var i?, var a?, var at?) && addIcon => BannerTypeTwo(...)
///	 (_, var i?, var a?, var at?) && addIcon => BannerTypeTwo(...)
///	 (_, _, _, _ ) => BannerTypeThree(...)
///}
///```
abstract interface class BannerType {
  ///The minimum height of the banner.
  @protected
  double get minHeight;

  ///The maximum height of the banner.
  @protected
  double get maxHeight;

  ///The padding at the top of the banner.
  @protected
  double get topPadding;

  ///The padding at the bottom of the banner.
  @protected
  double get bottomPadding;

  ///The padding along the x axis.
  @protected
  double get xPadding;
}

///A simple banner that has a [description] and a call to [action] button to
///execute a callback function.
class BannerTypeOne extends StatelessWidget implements BannerType {
  const BannerTypeOne({
    super.key,
    required this.description,
    required this.icon,
    required this.action,
    required this.actionText,
    required this.color,
  });

  ///The message inside the banner.
  final String description;

  ///An icon that helps show what cause the banner is.
  final IconData icon;

  ///The callback to execute if the button is pressed.
  final VoidCallback action;

  ///The text shown in the button.
  final String actionText;

  ///The background color of the banner.
  final Color color;

  @override
  double get minHeight => 64.h;
  @override
  double get maxHeight => 124.h;
  @override
  double get topPadding => 12.h;
  @override
  double get bottomPadding => 8.h;
  @override
  double get xPadding => 12.w;

  @override
  Widget build(BuildContext context) {
    final constraints = (
      minHeight,
      maxHeight,
      xPadding,
      topPadding,
      bottomPadding,
    );
    return _BannerTypeConstrainedBox(
      constraints,
      backgroundColor: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BannerIcon(icon),
          SizedBox(width: 8.w),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerDescription(description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BannerAction(action, text: actionText),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}

class BannerTypeTwo extends StatelessWidget implements BannerType {
  const BannerTypeTwo({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.action,
    required this.actionText,
    required this.color,
  });

  ///The header inside the banner.
  final String title;

  ///The message inside the banner.
  final String description;

  ///An icon that helps show what cause the banner is.
  final IconData icon;

  ///The callback to execute if the button is pressed.
  final VoidCallback action;

  ///The text shown in the button.
  final String actionText;

  ///The background color of the banner.
  final Color color;

  @override
  double get minHeight => 32.h;

  @override
  double get maxHeight => 140.h;

  @override
  double get topPadding => 12.h;

  @override
  double get bottomPadding => 8.h;

  @override
  double get xPadding => 12.w;

  @override
  Widget build(BuildContext context) {
    final constraints = (
      minHeight,
      maxHeight,
      xPadding,
      topPadding,
      bottomPadding,
    );
    return _BannerTypeConstrainedBox(
      constraints,
      backgroundColor: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BannerIcon(icon),
          SizedBox(width: 8.w),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerTitle(title),
                SizedBox(height: 4.h),
                BannerDescription(description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BannerAction(action, text: actionText),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}

///A more customizable banner that has a [description] but
///may be presented without an [icon] or [action].
class BannerTypeThree extends StatelessWidget implements BannerType {
  const BannerTypeThree({
    super.key,
    required this.description,
    required this.color,
    this.icon,
    this.action,
    this.actionText,
  });

  ///The message inside the banner.
  final String description;

  ///The background color of the banner.
  final Color color;

  ///An icon that helps show what cause the banner is.
  final IconData? icon;

  ///The callback to execute if the button is pressed.
  final VoidCallback? action;

  ///The text shown in the button.
  final String? actionText;

  @override
  double get minHeight => 48.h;
  @override
  double get maxHeight => 120.h;
  @override
  double get topPadding => 12.h;
  @override
  double get bottomPadding => 8.h;
  @override
  double get xPadding => 12.w;

  @override
  Widget build(BuildContext context) {
    final constraints = (
      minHeight,
      maxHeight,
      xPadding,
      topPadding,
      bottomPadding,
    );
    return _BannerTypeConstrainedBox(
      constraints,
      backgroundColor: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            BannerIcon(icon!),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BannerDescription(description),
                if (action != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BannerAction(action!, text: actionText),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}

///A composition Widget that behaves exactly as the [constraints]
///passed dictate and wraps the [child] content.
class _BannerTypeConstrainedBox extends StatelessWidget {
  const _BannerTypeConstrainedBox(
    this.constraints, {
    required this.child,
    required this.backgroundColor,
  });

  ///The content inside the banner.
  final Widget child;

  ///A simple record (tuple) to encapsulate all constrain
  ///values inside.
  final (
    double minHeight,
    double maxHeight,
    double xPadding,
    double topPadding,
    double bottomPadding,
  ) constraints;

  ///The background color for the banner.
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final (
      double minHeight,
      double maxHeight,
      double xPadding,
      double topPadding,
      double bottomPadding,
    ) = constraints;
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight,
        maxHeight: maxHeight,
        minWidth: context.width,
        maxWidth: context.width,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: PiixColors.contrast30,
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 1.2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        xPadding,
        topPadding,
        xPadding,
        bottomPadding,
      ),
      child: child,
    );
  }
}
