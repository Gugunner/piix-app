import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/features/authentication/presentation/mobile_tablet/welcome_actions.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';
import 'package:piix_mobile/src/utils/app_assets.dart';
import 'package:piix_mobile/src/utils/size_context.dart';


/// A Widget that displays the welcome page in landscape orientation
/// for tablet devices.
class LandscapeOrientationWelcome extends StatelessWidget {
  const LandscapeOrientationWelcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight,
      width: context.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 4,
            child: Container(
              height: context.screenHeight,
              width: context.screenWidth,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.familyImagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              color: PiixColors.primary,
              padding: EdgeInsets.symmetric(
                vertical: Sizes.p32.h,
                horizontal: Sizes.p32.w,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: PiixColors.space,
                  borderRadius: BorderRadius.circular(Sizes.p16),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.p16.w,
                  vertical: Sizes.p64.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const AppLogo(),
                      gapH16,
                      const WelcomeActions(
                        textScaleFactor: tabletTextScaleFactor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
