import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/dialog/app_dialog_title_deprecated.dart';
import 'package:piix_mobile/widgets/dialog/close_overlay_gesture.dart';

@Deprecated('Will be removed in 4.0')

///Base class to build any dialog for the app
///
///Any dialog must include constraints for the [maxWidth],
///[minHeight] and [maxHeight]
///
abstract class AppDialogDeprecated extends Dialog {
  AppDialogDeprecated({
    super.key,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.title,
    this.isCompact = false,
    this.titleColor,
    this.buttonOneText,
    this.buttonTwoText,
    this.onPressedOne,
    this.onPressedTwo,
    this.dialogContent,
  }) : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          elevation: 1,
          child: _AppDialogStack(
            maxWidth: maxWidth,
            minHeight: minHeight,
            maxHeight: maxHeight,
            title: title,
            isCompact: isCompact,
            titleColor: titleColor,
            buttonOneText: buttonOneText,
            buttonTwoText: buttonTwoText,
            onPressedOne: onPressedOne,
            onPressedTwo: onPressedTwo,
            dialogContent: dialogContent,
          ),
        );

  //The maximum width constraint the dialog must have
  final double maxWidth;

  ///The minimum height constraint the dialog must have
  final double minHeight;

  ///The maximum height constraint the dialog must have
  final double maxHeight;

  ///The content to put inside the dialog below the [title]
  final Widget? dialogContent;

  ///The header of the dialog
  final String title;

  ///When true the top and bottom margins of
  ///the [dialogContent] is 12.h if not is 32.h
  final bool isCompact;

  ///The color of the header
  final Color? titleColor;

  ///The text for the centered or right button
  final String? buttonOneText;

  ///The text for the left button
  final String? buttonTwoText;

  ///The action for the centered or right button
  final VoidCallback? onPressedOne;

  ///The action for the left button
  final VoidCallback? onPressedTwo;
}

///The dialog is inside a stack so the [CloseOverlayGesture]
///can be inserted to close the dialog.
class _AppDialogStack extends StatelessWidget {
  const _AppDialogStack({
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.title,
    this.isCompact = false,
    this.titleColor,
    this.buttonOneText,
    this.buttonTwoText,
    this.onPressedOne,
    this.onPressedTwo,
    this.dialogContent,
  });

  //The maximum width constraint the dialog must have
  final double maxWidth;

  ///The minimum height constraint the dialog must have
  final double minHeight;

  ///The maximum height constraint the dialog must have
  final double maxHeight;

  ///The header of the dialog
  final String title;

  ///When true the top and bottom margins of
  ///the [dialogContent] is 12.h if not is 32.h
  final bool isCompact;

  ///The color of the header
  final Color? titleColor;

  ///The content to put inside the dialog
  final Widget? dialogContent;

  ///The text for the centered or right button
  final String? buttonOneText;

  ///The text for the left button
  final String? buttonTwoText;

  ///The action for the centered or right button
  final VoidCallback? onPressedOne;

  ///The action for the left button
  final VoidCallback? onPressedTwo;

  @override
  Widget build(BuildContext context) {
    final marginTB = isCompact ? 12.h : 32.h;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: minHeight,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
            padding: EdgeInsets.fromLTRB(16.w, 36.h, 16.w, 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppDialogTitleDeprecated(
                  title,
                  color: titleColor,
                ),
                if (dialogContent != null)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: marginTB),
                    child: dialogContent!,
                  ),
                _AppDialogButtonBuilder(
                  buttonOneText,
                  buttonTwoText,
                  onPressedOne,
                  onPressedTwo,
                ),
              ],
            ),
          ),
        ),
        CloseOverlayGesture(
          iconColor: PiixColors.error,
          onClose: () => NavigatorKeyState().getNavigator()?.pop(),
        )
      ],
    );
  }
}

///Builds either a [Row] with two buttons or a centered button
///with constrained widths
class _AppDialogButtonBuilder extends StatelessWidget {
  const _AppDialogButtonBuilder(
    this.buttonOneText,
    this.buttonTwoText,
    this.onPressedOne,
    this.onPressedTwo,
  );

  ///The text for the centered or right button
  final String? buttonOneText;

  ///The text for the left button
  final String? buttonTwoText;

  ///The action for the centered or right button
  final VoidCallback? onPressedOne;

  ///The action for the left button
  final VoidCallback? onPressedTwo;

  @override
  Widget build(BuildContext context) {
    final buttonOne = ElevatedAppButtonDeprecated(
      text: buttonOneText ?? PiixCopiesDeprecated.accept,
      onPressed:
          onPressedOne ?? () => NavigatorKeyState().getNavigator()?.pop(),
      isMain: false,
    );
    TextAppButtonDeprecated? buttonTwo;
    if (buttonTwoText.isNullOrEmpty && onPressedTwo == null) {
      return _AppDialogOneButton(buttonOne: buttonOne);
    }
    buttonTwo = TextAppButtonDeprecated(
      text: buttonTwoText ?? PiixCopiesDeprecated.cancel,
      onPressed:
          onPressedTwo ?? () => NavigatorKeyState().getNavigator()?.pop(),
    );
    return _AppDialogTwoButtons(
      buttonOne: buttonOne,
      buttonTwo: buttonTwo,
    );
  }
}

///Builds the center or right button for the dialog
class _AppDialogOneButton extends StatelessWidget {
  const _AppDialogOneButton({
    required this.buttonOne,
  });

  ///The centered or right button
  final ElevatedAppButtonDeprecated buttonOne;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 24.h,
        minWidth: 24.w,
        maxWidth: 240.w,
      ),
      child: buttonOne,
    );
  }
}

///Builds a [Row] of two buttons one to the most left part
///and the other to right most part
class _AppDialogTwoButtons extends StatelessWidget {
  const _AppDialogTwoButtons({
    required this.buttonOne,
    required this.buttonTwo,
  });

  ///The centered or right button
  final ElevatedAppButtonDeprecated buttonOne;

  ///The left button
  final TextAppButtonDeprecated buttonTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...[buttonOne, buttonTwo].map(
          (button) => ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 24.w,
              maxWidth: 100.w,
            ),
            child: button,
          ),
        ),
      ],
    );
  }
}
