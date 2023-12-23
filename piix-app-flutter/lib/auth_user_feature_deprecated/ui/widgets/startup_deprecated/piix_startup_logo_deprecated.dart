import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('Remove in 4.0')
class PiixStartupLogoDeprecated extends StatelessWidget {
  const PiixStartupLogoDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.5,
      height: context.height * 0.155,
      child: SvgPicture.asset(
        PiixAssets.piixSvgLogo,
        color: PiixColors.twilightBlue,
      ),
    );
  }
}
