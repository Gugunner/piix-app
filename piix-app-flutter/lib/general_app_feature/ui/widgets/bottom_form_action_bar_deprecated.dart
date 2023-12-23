import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/ui/widgets/submit_button_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/app_text_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/icon_text_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';

@Deprecated('Will be removed in 4.0')
class BottomFormActionBarDeprecated extends StatelessWidget {
  const BottomFormActionBarDeprecated({
    Key? key,
    required this.actionOneText,
    this.actionTwoText,
    this.hasSecondAction = false,
    this.icon,
    this.onActionTwoPressed,
    this.onActionOnePressed,
    this.actionTwoColor,
    this.backgroundColor,
    this.isLoading = false,
  }) : super(key: key);

  final bool hasSecondAction;
  final String actionOneText;
  final String? actionTwoText;
  final Color? actionTwoColor;
  final IconData? icon;
  final VoidCallback? onActionTwoPressed;
  final VoidCallback? onActionOnePressed;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final hideSecondAction = !hasSecondAction || actionTwoText.isNullOrEmpty;
    return Container(
      color: backgroundColor ?? PiixColors.twilightBlue,
      padding: EdgeInsets.symmetric(
        horizontal: hideSecondAction ? 16.w : 0,
      ),
      height: 60.h,
      width: context.width,
      child: Row(
        mainAxisAlignment: hideSecondAction
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceAround,
        children: [
          Builder(
            builder: (context) {
              if (hideSecondAction) {
                return const SizedBox();
              }
              if (icon == null) {
                return AppTextButtonDeprecated(
                  text: actionTwoText!,
                  color: actionTwoColor ?? PiixColors.white,
                  onPressed: onActionTwoPressed,
                );
              }
              return IconTextButtonDeprecated(
                text: actionTwoText!,
                icon: icon ?? Icons.info_rounded,
                onPressed: onActionTwoPressed,
                color: actionTwoColor,
              );
            },
          ),
          SizedBox(
            width:
                hideSecondAction ? context.width - 32.w : context.width * 0.34,
            child: SubmitButtonBuilderDeprecated(
              onPressed: onActionOnePressed,
              text: actionOneText,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
