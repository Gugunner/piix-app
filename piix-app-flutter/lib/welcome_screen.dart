import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///TODO: Clean all states in this screen
final class WelcomeScreen extends StatelessWidget with ExitPrompt {
  static const routeName = '/welcome_screen';
  const WelcomeScreen({super.key});

  String get _piixSvgLogo => PiixAssets.piixSvgLogo;

  String get _piixSvgGroupHug => PiixAssets.piixGroupHugSvg;

  void _navigateToSignInScreen() {
    NavigatorKeyState().slideToLeftRoute(
      page: const SignInScreen(),
      routeName: SignInScreen.routeName,
    );
  }

  void _navigateToCreateAccountScreen() {
    NavigatorKeyState().slideToLeftRoute(
      page: const CreateAccountScreen(),
      routeName: CreateAccountScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await showExitAppPrompt(context) ?? false,
      child: Scaffold(
        backgroundColor: PiixColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    _piixSvgLogo,
                    color: PiixColors.space,
                    width: 108.w,
                    height: 60.h,
                  ),
                  SizedBox(height: 68.h),
                  SvgPicture.asset(
                    _piixSvgGroupHug,
                    width: 208.w,
                    height: 163.h,
                  ),
                  SizedBox(height: 62.h),
                  Text(
                    context.localeMessage.careForEveryoneYouLove,
                    style: context.headlineMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: 140.w,
                    height: 32.h,
                    child: FilledButton(
                      onPressed: _navigateToSignInScreen,
                      child: Text(
                        context.localeMessage.signIn.toUpperCase(),
                      ),
                      style: _filledStyle,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 93.w,
                    height: 23.h,
                    child: TextButton(
                      onPressed: _navigateToCreateAccountScreen,
                      child: Text(
                        context.localeMessage.register.toUpperCase(),
                      ),
                      style: _textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _ButtonStyles on WelcomeScreen {
  ButtonStyle? get _filledStyle => AppFilledButtonTheme().style?.copyWith(
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (states) {
            final titleMedium = PrimaryTextTheme().titleMedium;
            if (states.contains(MaterialState.disabled)) {
              return titleMedium.copyWith(
                color: PiixColors.inactive,
              );
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return titleMedium.copyWith(
                color: PiixColors.primary,
              );
            }
            return titleMedium.copyWith(
              color: PiixColors.active,
            );
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return ColorUtils.lighten(PiixColors.active, 0.3);
            }
            return PiixColors.space;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return PiixColors.primary;
            }
            return PiixColors.active;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return ColorUtils.lighten(PiixColors.active, 0.3);
            }
            return PiixColors.active;
          },
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(
                color: PiixColors.inactive,
              );
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return const BorderSide(color: PiixColors.primary);
            }
            return const BorderSide(color: PiixColors.active);
          },
        ),
      );

  ButtonStyle? get _textStyle => AppTextButtonTheme().style?.copyWith(
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (states) {
            final titleMedium = PrimaryTextTheme().titleMedium;
            if (states.contains(MaterialState.disabled)) {
              return titleMedium.copyWith(
                color: PiixColors.inactive,
              );
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return titleMedium.copyWith(
                color: PiixColors.active,
              );
            }
            return titleMedium.copyWith(
              color: PiixColors.space,
            );
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return PiixColors.inactive;
            }
            if (states.contains(MaterialState.pressed) ||
                states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.selected)) {
              return PiixColors.active;
            }
            return PiixColors.space;
          },
        ),
        minimumSize: MaterialStatePropertyAll(
          Size(8.w, 20.h),
        ),
      );
}
