// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';


@Deprecated('Use instead AppPannableMembershipCard')
///Base class that allows a membership card can be moved to
///the left side border of the parent widget.
///
///Use it inside a [Stack] widget
abstract class AppPannableMembershipCardOld extends StatefulWidget {
  const AppPannableMembershipCardOld({
    super.key,
    this.maxWidth,
    this.minWidth = 80,
    this.height = 184,
    this.color,
    this.logoColor,
    this.child,
  });

  ///Controls the max limit the card can be moved
  ///to the middle
  final double? maxWidth;

  ///Controls the min limit the card can be moved
  ///outside the left side border
  final double minWidth;

  ///The height of the card
  final double height;

  ///The background color of the card
  final Color? color;

  //The color of the Piix logo
  final Color? logoColor;

  ///The content of the card, it is positioned
  ///relative to the card with top 0 and left 0
  final Widget? child;
}

abstract class AppPannableMembershipCardOldState<
    T extends AppPannableMembershipCardOld> extends State<T> {
  ///The x coordinate value the card has moved to the left
  ///or to the right
  double pan = -170.w;

  ///A margin error used to decrease the value of [pan]
  ///when checking if it is less than negative [maximumPanPosition]
  final panErrorMargin = -1.w;

  ///Moves the card to the right most side or to the left most side
  void _onTap(bool reachMinimumPosition) {
    setState(() {
      if (reachMinimumPosition) {
        //Return to 0 to move the card to the right
        pan = 0;
        return;
      }
      //Moves the card to the left maximum position
      //outside the widget border
      pan = -maximumPanPosition;
      return;
    });
  }

  ///Updates the x value of [pan] by checking the [delta] dx
  ///value
  void _onPanUpdate(DragUpdateDetails details) {
    final newPan = pan + details.delta.dx;

    ///Blocks moving beyond any limit of the border
    if (newPan <= -maximumPanPosition || newPan >= 0) return;
    setState(() {
      pan = newPan;
    });
  }

  double get maxWidth => widget.maxWidth ?? context.width * 0.78;

  bool get reachMinimumPosition =>
      (pan + panErrorMargin) <= -maximumPanPosition;

  ///The maximum position [pan] can be updated to the left side of the border
  double get maximumPanPosition => (maxWidth - widget.minWidth.w);

  @override
  Widget build(BuildContext context) {
    return _AnimatedMembershipCard(
      left: pan,
      maxWidth: maxWidth,
      reachMinimumPosition: reachMinimumPosition,
      color: widget.color,
      logoColor: widget.logoColor,
      child: widget.child,
      onTap: () => _onTap(reachMinimumPosition),
      onPanUpdate: _onPanUpdate,
    );
  }
}

///Contains the [GestureDetector] that has the [dx] value
///when the card is panned or when is tapped.
class _AnimatedMembershipCard extends StatelessWidget {
  const _AnimatedMembershipCard({
    required this.left,
    required this.maxWidth,
    required this.reachMinimumPosition,
    this.color,
    this.logoColor,
    this.child,
    this.onTap,
    this.onPanUpdate,
  });

  final double left;
  final double maxWidth;
  final bool reachMinimumPosition;
  final Color? color;
  final Color? logoColor;
  final Widget? child;
  final VoidCallback? onTap;
  final Function(DragUpdateDetails)? onPanUpdate;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topRight: Radius.circular(24),
      bottomRight: Radius.circular(24),
    );
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 10),
      top: 16.h,
      left: left,
      child: GestureDetector(
        onTap: onTap,
        onPanUpdate: onPanUpdate,
        child: _MembershipCard(
          maxWidth: maxWidth,
          borderRadius: borderRadius,
          color: color,
          child: child,
          reachMinimumPosition: reachMinimumPosition,
          logoColor: logoColor,
        ),
      ),
    );
  }
}

///Membership card background decoration and
///call to calculate height based on the [child]
class _MembershipCard extends StatelessWidget {
  const _MembershipCard({
    super.key,
    required this.maxWidth,
    required this.borderRadius,
    required this.color,
    required this.child,
    required this.reachMinimumPosition,
    required this.logoColor,
  });

  final double maxWidth;
  final BorderRadius borderRadius;
  final Color? color;
  final Widget? child;
  final bool reachMinimumPosition;
  final Color? logoColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: PiixColors.contrast30,
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 6),
                blurStyle: BlurStyle.inner,
              ),
            ],
            color: color,
          ),
          child: _IntrinsicHeightCard(
            child: child,
            borderRadius: borderRadius,
            reachMinimumPosition: reachMinimumPosition,
          ),
        ),
        Positioned(
          top: 16.h,
          right: 8.w,
          child: SvgPicture.asset(
            PiixAssets.piixSvgLogo,
            color: logoColor ?? PiixColors.white,
            placeholderBuilder: (context) => const Placeholder(),
            width: 48.w,
          ),
        ),
      ],
    );
  }
}

///Special widget that calculates the height of the
///[child] and sets the height for the whole card
class _IntrinsicHeightCard extends ConsumerWidget {
  const _IntrinsicHeightCard({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.reachMinimumPosition,
  });

  final Widget? child;
  final BorderRadius borderRadius;
  final bool reachMinimumPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMembership = ref.read(isMembershipProvider);
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 14,
            child: child!,
          ),
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Builder(builder: (context) {
                    if (!isMembership) {
                      return const _SimpleWedge();
                    }
                    return _AnimatedArrow(
                        reachMinimumPosition: reachMinimumPosition);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///A simple wedge that shows a space in the card
class _SimpleWedge extends StatelessWidget {
  const _SimpleWedge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.w),
      width: 4.w,
      height: 20.h,
      decoration: BoxDecoration(
          color: PiixColors.contrast, borderRadius: BorderRadius.circular(8)),
    );
  }
}

///A simple arrow that changes direction depending
///if the card is moved outside the border or inside the border
///limits
class _AnimatedArrow extends StatelessWidget {
  const _AnimatedArrow({
    super.key,
    required this.reachMinimumPosition,
  });

  final bool reachMinimumPosition;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: reachMinimumPosition
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: Icon(
        Icons.arrow_forward_ios_rounded,
        color: PiixColors.white,
        size: 28.sp,
      ),
      secondChild: Icon(
        Icons.arrow_back_ios_rounded,
        color: PiixColors.white,
        size: 28.sp,
      ),
      duration: const Duration(milliseconds: 180),
    );
  }
}
