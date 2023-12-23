import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

///A sized SVG logo image used for the [AppBar]
final class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
    this.color,
    this.size,
  });

  final Color? color;

  final Size? size;

  ///The width of the logo image.
  @protected
  double get _width => size?.width ?? 32.w;

  ///The height of the logo image.
  @protected
  double get _height => size?.height ?? 18.h;

  ///The path used to load the logo image.
  @protected
  String get _assetPath => PiixAssets.piixSvgLogo;

  ///The color for the logo image.
  @protected
  Color get _svgColor => color ?? PiixColors.space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: SvgPicture.asset(
        _assetPath,
        color: _svgColor,
        placeholderBuilder: (context) => const Placeholder(),
      ),
    );
  }
}
