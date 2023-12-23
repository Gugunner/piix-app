import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/app_card/app_card_barrel_file.dart';

enum VariantColor {
  sky(PiixColors.sky),
  space(PiixColors.space);

  const VariantColor(this.color);

  final Color color;
}

///Calls for an [AppAdjustableCard] that sets it height
///and width based on the [child] dimensions and then returns
///the values to it's parent [AppCard] so that
///the parents can update it's size in the initialization state.
///
///The height and width passed to the [AppAdjustableCard] can determine
///if a [SingleChildScrollView] is required for the [child] and what padding
///values it should have. To read more about the scoll behavior check
///[AppAdjustableCard].
///
///It has a special way of updating dynamically it's own height
///and width so it can update the values for the [AppAdjustableCard]
///this method can be quite expensive to utilize and affect performance
///so tread lightly (currently it rebuilds three times). It is also
///imperative that a good [rebuild] management
///state is done to avoid triggering [_rebuildCard] infinitely.
///
///The [rebuild] feature was designed to make a dynamic scrollable [AppCard].
///
///Do not use [rebuild] if the children is an innfinite scroll widget. In this
///case pass the width and height directly.
///Use it when an asynchronous call will resize one or more elements once it is
///loaded once.
///
///If a [maxHeight] is passed it will create an [AppCard] of height equal
///to [maxHeight].
///
///If you need to set a specific height or width wrap the [AppCard] with a
///[SizedBox] and define its dimensions. Do not wrap [AppCard] inside a
///[SizedBox]and set height if a [maxHeight] is passed, as [maxHeight] will
///supercede the height of the [SizedBox] this is due to the rule of Flutter
///"Parents pass constraints, Children set sizes and position".
///
final class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variantColor = VariantColor.space,
    this.forceScroll = false,
    this.rebuild = false,
    this.maxHeight,
    this.color,
    this.resizeCard,
  }) : assert(!rebuild || resizeCard != null);

  final Widget child;

  final VariantColor variantColor;

  final bool forceScroll;

  ///Set to true when this needs to dynamically change it's height
  ///based on new content being added.
  ///
  ///If this is set to true, a [resizeCard] callback
  ///must be provided.
  ///
  final bool rebuild;

  final double? maxHeight;

  final Color? color;

  ///The action that is triggered when resizing the card.
  ///
  ///If [rebuild] is set to true, then this property
  ///cannot be null.
  final void Function(bool resized)? resizeCard;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  ///A key used to identify and obtain information
  ///about the context of [this].
  final GlobalKey _widgetKey = GlobalKey();

  double _height = 0.0;

  double _width = 0.0;

  int _safeRebuildCount = 0;

  ///Flag that alerts [this] that the [_height]
  ///has reached or pass the [_maxHeight].
  bool _maxHeightReached = false;

  Color? get currentColor => widget.color ?? widget.variantColor.color;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _height = _widgetKey.currentContext?.size?.height ?? 0;
        _width = _widgetKey.currentContext?.size?.width ?? 0;
      });
    });
    super.initState();
  }

  ///When the [parent] Widget passes [rebuild] set to true
  ///it triggers this method inside [build].
  ///
  ///To avoid an infinite loop a [_safeRebuildCount] is implemented;
  ///The count does not reset unless [rebuild] is set to false.
  void _rebuildCard() {
    //Protects that the Widget does not rebuild eternally
    //if the parent widget does not set [rebuild] to false
    //after finishing the resize action.
    if (_safeRebuildCount > 4) return;
    Future.microtask(
      () => setState(() {
        _height = _widgetKey.currentContext?.size?.height ?? _height;
        //Checks if maximum height has been reached either set by this or by
        //the context.
        if (!_maxHeightReached &&
            (_height > _maxHeight || _height > context.height)) {
          _maxHeightReached = true;
        }
        _width = _widgetKey.currentContext?.size?.width ?? _width;
        widget.resizeCard?.call(true);
        _safeRebuildCount++;
      }),
    );
  }

  ///Returns [_safeRebuildCount] to zero.
  void _resetSafeCount() => Future.microtask(() => setState(() {
        _safeRebuildCount = 0;
      }));

  ///The minimum width for the [child] size.
  @protected
  double get _minWidth => 68.w;

  ///The maximum width for the [child] size.
  @protected
  double get _maxWidth => 288.w;

  ///The minimum height for the [child] size.
  @protected
  double get _minHeight => 32.h;

  double get _maxHeight => widget.maxHeight ?? 0;

  ///Checks if the [child] can be wrapped in a [SingleChildScrollView] by
  ///checking on multiple conditions.
  @protected
  bool get _scroll {
    if (widget.forceScroll || _maxHeightReached) return true;
    if (_maxHeight == 0) return false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //Calls a [rebuild] action for this only if maximum height
    //has not been reached.
    if (!_maxHeightReached && widget.rebuild) _rebuildCard();

    ///Resets safe count only once and only if the parent widget
    ///sets to false the [rebuild]
    if (!widget.rebuild && _safeRebuildCount > 0) _resetSafeCount();

    return Container(
      key: _widgetKey,
      //Sets the height of the [AppCard] to it's maxHeight
      height: _maxHeightReached ? _maxHeight : null,
      constraints: BoxConstraints(
        minWidth: _minWidth,
        maxWidth: _maxWidth,
        minHeight: _minHeight,
      ),
      child: AppAdjustableCard(
        parentHeight: _height,
        parentWidth: _width,
        scroll: _scroll,
        color: currentColor,
        child: widget.child,
      ),
    );
  }
}
