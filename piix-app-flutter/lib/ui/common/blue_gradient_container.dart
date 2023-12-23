import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';

@Deprecated('No longer in use in 4.0')
class BlueGradientContainerDeprecated extends StatelessWidget {
  const BlueGradientContainerDeprecated({
    Key? key,
    this.isLogin = false,
    this.hasHeightSpacer = true,
  }) : super(key: key);

  final bool isLogin;
  final bool hasHeightSpacer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [PiixColors.softBlue, PiixColors.twilightBlue],
        ),
      ),
      child: Column(
        children: [
          if (hasHeightSpacer)
            SizedBox(
              height: size.height * (isLogin ? 0.132 : 0.126),
            ),
          SizedBox(
              height: ScreenUtil().setHeight(isLogin ? 72 : 52),
              child: Image.asset(
                PiixAssets.piixMembershipLogo,
              )),
        ],
      ),
    );
  }
}
