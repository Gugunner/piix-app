import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';


///Allows any [Widget]with defined [height] and [width] be wrapped 
///inside a [Container] that acts as a [RenderBox] and show a shimmer
///effect while inside the [Shimmer]
class ShimmerWrap extends StatelessWidget {
  const ShimmerWrap({
    super.key,
    this.child,
    this.shape,
    this.color,
  });

  final Widget? child;
  final BoxShape? shape;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isCircleShape = shape == BoxShape.circle;
    return Container(
      decoration: BoxDecoration(
        borderRadius: isCircleShape
            ? null
            : BorderRadius.circular(
                4.0,
              ),
        shape: shape ?? BoxShape.rectangle,
        color: color ?? PiixColors.space,
      ),
      child: child,
    );
  }
}
