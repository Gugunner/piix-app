import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';

///A mixin that calls all exit prompts when
///trying to go back to a previous screen.
mixin ExitPrompt {
  Future<bool?> showExitAppPrompt(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (buildContext) => const ExitAppPromptModal(),
    );
  }

  Future<bool?> showExitProgressPrompt(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (buildContext) => const ExitProgreessPromptModal(),
    );
  }

  ///A specific method that is used to show a [SnackBar]
  ///explaining why the user cannot go back while the app
  ///is requesting or submitting data.
  bool showBlockedBackPrompt(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: PiixColors.primary,
        content: Text(
          context.localeMessage.preventBackWhileRequesting,
          maxLines: 5,
        ),
      ),
    );
    return false;
  }
}
