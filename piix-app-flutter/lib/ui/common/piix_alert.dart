import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/responsive.dart';
import 'package:piix_mobile/ui/common/center_box_container.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_elevated_button.dart';

/// Creates an alert container with a title, description, icon
/// and action button. It also has a loading indicator if the action
/// is loading.
class PiixAlert extends StatelessWidget {
  const PiixAlert({
    Key? key,
    this.title,
    this.message,
    this.buttonText,
    this.onPressed,
    this.icon,
    this.iconColor,
    this.loadingMessage,
    this.isLoading = false,
    this.closeButton = false,
  }) : super(key: key);

  final String? title;
  final String? message;
  final String? loadingMessage;
  final IconData? icon;
  final Color? iconColor;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool closeButton;

  @override
  Widget build(BuildContext context) {
    final screenSize = Responsive.of(context);
    return CenterBoxContainer(
      child: Column(
        children: [
          if (closeButton)
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (_) => const PiixConfirmAlertDialogDeprecated(
                    title: PiixCopiesDeprecated.leaveCurrentPage,
                    message: '',
                  ),
                ),
                child: const Icon(
                  Icons.clear,
                  color: PiixColors.errorMain,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? '',
                style: context.textTheme?.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                isLoading ? loadingMessage ?? '' : message ?? '',
                style: context.textTheme?.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 70.1.h,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: screenSize.height * 0.055,
                  ),
                ),
          if (!isLoading)
            PiixElevatedButton(
              text: buttonText ?? '',
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}
