import 'package:flutter/material.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a card image with a gesture detector
///
class ImageCardButtonDeprecated extends StatelessWidget {
  const ImageCardButtonDeprecated(this.asset,
      {super.key, this.height, this.width, this.onTap});
  final String asset;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(asset),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
