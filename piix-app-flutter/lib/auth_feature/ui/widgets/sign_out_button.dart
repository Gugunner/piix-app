import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/theme/button_theme/app_text_button_theme.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///An [AppTextSizedButton] that launches a dialog
///to sign out the user from the current app account.
class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  ///The icon used in the [AppTextSizedButton]
  IconData get _iconData => PiixIcons.logout;

  String _getSignOutMessage(BuildContext context) =>
      context.localeMessage.signOut;

  ///The [ButtonStyle] that replaces [TextButtonThemeData]
  ///[ButtonStyle].
  ButtonStyle? _getButtonStyle(BuildContext context) =>
      AppTextButtonTheme().style?.copyWith(
            textStyle: MaterialStatePropertyAll<TextStyle?>(
              context.accentTextTheme?.headlineLarge,
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return PiixColors.secondaryLight;
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return PiixColors.secondaryLight;
                }
                return PiixColors.space;
              },
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return PiixColors.secondaryLight;
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return PiixColors.secondaryLight.withOpacity(0.1);
                }
                return null;
              },
            ),
            iconColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return PiixColors.secondaryLight;
                }
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.selected)) {
                  return PiixColors.secondaryLight;
                }
                return PiixColors.space;
              },
            ),
          );

  ///Launches a dialog to alert the user that she is
  ///signing out and to confirm the action.
  void _onSignOut() {
    //TODO: Implement a SignOut Dialog
  }

  @override
  Widget build(BuildContext context) {
    return AppTextSizedButton(
      upperCase: false,
      iconData: _iconData,
      text: _getSignOutMessage(context),
      onPressed: _onSignOut,
      style: _getButtonStyle(context),
    );
  }
}
