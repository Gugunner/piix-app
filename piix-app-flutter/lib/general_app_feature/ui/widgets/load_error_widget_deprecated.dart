import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';

@Deprecated('Use instead LoadErrorScreen or UnknowErrorScreen')
class LoadErrorWidgetDeprecated extends StatelessWidget {
  const LoadErrorWidgetDeprecated({
    Key? key,
    required this.message,
    required this.onPressed,
    this.textAction,
  }) : super(key: key);

  final String message;
  final VoidCallback onPressed;
  final String? textAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: context.height * 0.24,
            ),
            SizedBox(
              child: Icon(
                Icons.question_mark_rounded,
                color: PiixColors.secondaryText,
                size: context.height * 0.2,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              child: Text(
                message,
                style: context.textTheme?.titleMedium?.copyWith(
                  color: PiixColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              child: ElevatedAppButtonDeprecated(
                onPressed: onPressed,
                text: textAction?.toUpperCase() ??
                    PiixCopiesDeprecated.backText.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
