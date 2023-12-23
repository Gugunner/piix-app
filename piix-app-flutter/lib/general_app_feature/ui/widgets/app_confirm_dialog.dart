import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/bottom_form_action_bar_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/close_dialog_icon_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead Modal')
class AppConfirmDialogDeprecated extends StatelessWidget {
  const AppConfirmDialogDeprecated({
    super.key,
    required this.title,
    required this.message,
    required this.cancelText,
    required this.confirmText,
  });

  final String title;
  final String message;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: PiixColors.white,
      child: SizedBox(
        height: context.height * 0.383,
        width: context.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.h,
            ),
            const SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseDialogIconButtonDeprecated(),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: context.width,
              child: Text(
                title,
                style: context.headlineSmall?.copyWith(
                  color: PiixColors.mainText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: context.width,
              child: Text(
                message,
                style: context.bodyMedium?.copyWith(
                  color: PiixColors.mainText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              heightFactor: 1.4,
              alignment: Alignment.bottomCenter,
              child: BottomFormActionBarDeprecated(
                hasSecondAction: true,
                backgroundColor: PiixColors.white,
                actionTwoColor: PiixColors.activeButton,
                actionOneText: confirmText,
                actionTwoText: cancelText,
                onActionOnePressed: () => Navigator.pop(context, true),
                onActionTwoPressed: () => Navigator.pop(context, false),
              ),
            )
          ],
        ),
      ),
    );
  }
}
