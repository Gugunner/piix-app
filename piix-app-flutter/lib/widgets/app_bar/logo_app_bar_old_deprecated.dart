import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/widgets/app_bar/static_app_bar_deprecated.dart';


@Deprecated('Use instead LogoAppBar')
class LogoAppBarOld extends StaticAppBar {
  const LogoAppBarOld({
    super.key,
    super.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaticAppBarBuilder(
      title: title,
      actions: [
        SizedBox(
          width: 48,
          height: 36,
          child: SvgPicture.asset(
            PiixAssets.piixSvgLogo,
            color: PiixColors.white,
            placeholderBuilder: (context) => const Placeholder(),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
