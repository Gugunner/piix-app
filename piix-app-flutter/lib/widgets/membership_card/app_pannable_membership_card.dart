import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///Base class that builds an empty membership card that can be panned
///to the left or to the right.
///
///Use it inside a [Stack].
base class AppPannableMembershipCard extends StatefulWidget {
  const AppPannableMembershipCard({
    super.key,
    required this.child,
    required this.color,
    this.logoColor,
  });

  ///The content of the card
  final Widget child;

  ///The background color of the card
  final Color color;

  ///The color of the logo.
  final Color? logoColor;

  @override
  State<AppPannableMembershipCard> createState() =>
      _AppPannableMembershipCardState();
}

///The full implementation of the pannable membership card.
final class _AppPannableMembershipCardState
    extends State<AppPannableMembershipCard> {
  ///The x coordinate value the card has moved to the left
  ///or to the right
  double _leftPan = 170.w;

  ///A margin error used to decrease the value of [_leftPan]
  ///when checking if it is less than negative [_maximumLeftPanPosition]
  double get _panErrorMargin => -1.w;

  //The minimum width of the membership card, this width
  //limits how much the card can move to the right.
  double get _minWidth => 70.w;

  ///The original size of the membership card.
  double get _maxWidth => 244.w;

  //The height of the card.
  double get _height => 150.h;

  //The url path where the card logo is.
  String get _cardLogo => PiixAssets.piixSvgLogo;

  Color get _logoColor => widget.logoColor ?? PiixColors.space;

  ///The maximum position [_leftPan] can be moved to its left side.
  double get _maximumLeftPanPosition => _minWidth - _maxWidth;

  //Checks if the current membership card position plus an error margin
  //is less or equal to the negative maximum position.
  bool get _reachedMinimumPosition =>
      (_leftPan + _panErrorMargin) <= _maximumLeftPanPosition;

  //The top margin of the logo inside the membership card.
  double get _top => 16.h;
  //The right margin of the logo inside the membership card.
  double get _right => 8.w;

  //The padding of the membership card.
  EdgeInsets get _padding =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h);

  //Shows a curved rightmost edge for the membership card.
  BorderRadius get _borderRadius => const BorderRadius.only(
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
      );
  //Shows a shadow in the membership card.
  BoxShadow get _boxShadow => BoxShadow(
        color: PiixColors.contrast30,
        spreadRadius: 0,
        blurRadius: 10,
        offset: const Offset(0, 6),
        blurStyle: BlurStyle.inner,
      );

  @override
  void initState() {
    _leftPan = _maximumLeftPanPosition;
    super.initState();
  }

  ///Moves the card to the right most side or to the left most side.
  void _onTap() {
    setState(() {
      if (_reachedMinimumPosition) {
        //Move the card all the way to the right.
        _leftPan = 0;
        return;
      }
      //Move the card all the way to the left.
      _leftPan = _maximumLeftPanPosition;
    });
  }

  ///Updates the x value of [_leftPan] by checking the [delta] dx
  ///value
  void _onPanUpdate(DragUpdateDetails details) {
    //Obtain the new pan value which is the current [_leftPan] plus
    //its dx delta offset.
    final newLeftPan = _leftPan + details.delta.dx;

    ///Blocks moving the card beyond any limit.
    if (newLeftPan <= _maximumLeftPanPosition || newLeftPan >= 0) return;
    //Update current [_leftPan] with the new position.
    setState(() {
      _leftPan = newLeftPan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 10),
      left: _leftPan,
      top: _top,
      child: GestureDetector(
        onTap: _onTap,
        onPanUpdate: _onPanUpdate,
        child: Stack(
          children: [
            Container(
              width: _maxWidth,
              height: _height,
              padding: _padding,
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
                boxShadow: [_boxShadow],
                color: widget.color,
              ),
              child: widget.child,
            ),
            Positioned(
              top: _top,
              right: _right,
              child: SvgPicture.asset(
                _cardLogo,
                color: _logoColor,
                placeholderBuilder: (context) => const Placeholder(),
                width: 48.w,
              ),
            ),
            Positioned(
              right: 2.w,
              top: (_height / 2),
              child: AnimatedCrossFade(
                firstChild: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: _logoColor,
                  size: 20.sp,
                ),
                secondChild: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: _logoColor,
                  size: 20.sp,
                ),
                crossFadeState: _reachedMinimumPosition
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
