import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/app_text_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';

@Deprecated('Will be removed in 4.0')
class PreviewImageSelectionButtonsDeprecated extends StatelessWidget {
  const PreviewImageSelectionButtonsDeprecated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextButtonDeprecated(
            text: PiixCopiesDeprecated.retry.toUpperCase(),
            color: PiixColors.white,
            onPressed: () => Navigator.pop(context),
          ),
          AppTextButtonDeprecated(
            text: PiixCameraCopiesDeprecated.takeNext,
            color: PiixColors.white,
            onPressed: () async {
              Navigator.pop(context, StateMachine.zero);
            },
          ),
        ],
      ),
    );
  }
}
