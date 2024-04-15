import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/routing/app_router.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/utils/size_context.dart';

///A widget that displays the buttons to navigate to the signUp and signIn 
///pages.
class WelcomeActions extends ConsumerWidget {
  const WelcomeActions({
    super.key,
    this.textColor = PiixColors.primary,
    this.textScaleFactor = mobileTextScaleFactor,
  });
  
  final Color textColor;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Protect the ones you love'.hardcoded,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: textColor,
                  ),
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(textScaleFactor),
            ),
            gapH32,
            SizedBox(
              width: context.screenWidth,
              // height: context.getAdjustedHeightTo(0.07),
              child: TextScaledElevatedButton(
                onPressed: () {
                  ref.read(goRouterProvider).goNamed(AppRoute.signUp.name);
                },
                text: 'Create account'.hardcoded,
                textScaleFactor: textScaleFactor,
              ),
            ),
            gapH20,
            SizedBox(
              width: context.screenWidth,
              // height: context.getAdjustedHeightTo(0.07),
              child: TextScaledOutlinedButton(
                onPressed: () {
                  ref.read(goRouterProvider).goNamed(AppRoute.signIn.name);
                },
                text: 'Login'.hardcoded,
                textScaleFactor: textScaleFactor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
