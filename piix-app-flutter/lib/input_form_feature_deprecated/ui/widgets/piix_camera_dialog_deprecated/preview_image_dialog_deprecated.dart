import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_control_input_deprecated/piix_camera_cancel_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/preview_image_selection_buttons_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_camera_dialog_deprecated/preview_image_widget_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/piix_camera_copies.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/state_machine.dart';

@Deprecated('Will be removed in 4.0')
class PreviewImageDialogDeprecated extends StatelessWidget {
  const PreviewImageDialogDeprecated({
    super.key,
    required this.image,
  });

  final File image;

  double buttonWidth(BuildContext context) => context.width * 0.55;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: PiixColors.black,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          PreviewImageWidgetDeprecated(
            image: image,
          ),
          Positioned(
            left: context.width * 0.05,
            child: SizedBox(
              width: 40.h,
              child: PiixCameraCancelButtonDeprecated(
                backgroundColor: PiixColors.clearBlue.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            bottom: 80.h,
            left: (context.width - buttonWidth(context)) / 2,
            child: SizedBox(
              width: buttonWidth(context),
              child: SubmitButtonBuilderDeprecated(
                onPressed: () => Navigator.pop(context, StateMachine.one),
                text: PiixCameraCopiesDeprecated.saveAndExit,
              ),
            ),
          ),
          Positioned(
            bottom: 32.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              width: context.width,
              child: const PreviewImageSelectionButtonsDeprecated(),
            ),
          ),
        ],
      ),
    );
  }
}
