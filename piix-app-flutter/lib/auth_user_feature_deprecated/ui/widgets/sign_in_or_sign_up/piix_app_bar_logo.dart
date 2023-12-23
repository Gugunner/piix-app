import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

class PiixAppBarLogo extends StatelessWidget {
  const PiixAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 36,
      child: SvgPicture.asset(
        PiixAssets.piixSvgLogo,
        color: PiixColors.white,
        placeholderBuilder: (context) => const Placeholder(),
      ),
    );
  }
}
