

import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/modal/modal_barrel_file.dart';

///A modal used to alert that going back will result in the loss
///of progress in the current screen.
final class ExitProgreessPromptModal extends StatelessWidget {
  const ExitProgreessPromptModal({super.key});
    ///Closes the modal and returns true.
  void _onAccept(BuildContext context) {
    Navigator.pop(context, true);
  }

  ///Closes the modal and returns false.
  void _onCancel(BuildContext context) {
    Navigator.pop(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: Text(
        context.localeMessage.doYouWantToGoBack,
        style: context.headlineSmall?.copyWith(
          color: PiixColors.primary,
        ),
        textAlign: TextAlign.center,
      ),
      child: Text(
        context.localeMessage.byPressingAcceptYouLooseProgress,
        style: context.bodyLarge?.copyWith(
          color: PiixColors.infoDefault,
        ),
        textAlign: TextAlign.center,
      ),
      onAccept: () => _onAccept(context),
      onCancel: () => _onCancel(context),
    );
  }
}