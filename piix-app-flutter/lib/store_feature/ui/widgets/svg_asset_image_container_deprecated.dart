import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a svg image
///
class SvgAssetImageContainerDeprecated extends StatelessWidget {
  const SvgAssetImageContainerDeprecated(
    this.assetImage, {
    Key? key,
    this.borderRadius = 0,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  }) : super(key: key);
  final String assetImage;
  final double borderRadius;
  final BoxFit fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SvgPicture.asset(
        assetImage,
        fit: fit,
        width: width,
        height: height,
      ),
    );
  }
}
