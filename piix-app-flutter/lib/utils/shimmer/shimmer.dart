import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///This widget is the main shimmer, it encompasses all the loading shimmers
///to generate a more uniform animation
///
class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    //set de shimmer controller with animation
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(milliseconds: 1000),
      );
  }

  @override
  void dispose() {
    //dispose the shimmer controller .
    _shimmerController.dispose();
    super.dispose();
  }

  //Get the gradient for shimmer
  Gradient get gradient => LinearGradient(
        colors: [
          PiixColors.gradientOne,
          PiixColors.gradientTwo,
          PiixColors.gradientOne,
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: const Alignment(-1.0, -0.3),
        end: const Alignment(1.0, 0.3),
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized {
    if (context.findRenderObject() != null) {
      return (context.findRenderObject() as RenderBox).hasSize;
    }
    return false;
  }

  Size get size => (context.findRenderObject() as RenderBox).size;

  //Convert the direction of shimmer in a global direction for all shimmer
  // loading items
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

///This class called _SlidingGradientTransform is that implements
/// GradientTransform to achieve the appearance of horizontal sliding.
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
