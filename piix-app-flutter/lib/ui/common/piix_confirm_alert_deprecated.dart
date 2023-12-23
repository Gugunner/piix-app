import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/claim_ticket_feature/utils/claim_ticket_utils.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:provider/provider.dart';

@Deprecated('Use a Modal')

/// Creates a custom confirm dialog that receives a title and a message.
class PiixConfirmAlertDialogDeprecated extends StatelessWidget {
  const PiixConfirmAlertDialogDeprecated({
    Key? key,
    required this.title,
    this.titleStyle,
    this.message,
    this.child,
    this.confirmText = PiixCopiesDeprecated.okButton,
    this.cancelText = PiixCopiesDeprecated.cancelButton,
    this.onConfirm,
    this.onCancel,
    this.hasLoader = false,
    this.isDisable = false,
    this.actionBottomPadding = 0,
  }) : super(key: key);

  final String title;
  final TextStyle? titleStyle;
  final String? message;
  final Widget? child;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final double actionBottomPadding;
  final bool hasLoader;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    final uiBLoC = context.watch<UiBLoC>();
    return Dialog(
      //TODO: This logic of uiBLoC isLoading should not be used, instead a local loader should be used
      child: (hasLoader)
          ? SizedBox(
              height: kMinInteractiveDimension * 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 8.h),
                  Text(
                    uiBLoC.loadText,
                    style: context.textTheme?.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onCancel ?? () => Navigator.pop(context),
                        child: const Icon(
                          Icons.clear,
                          color: PiixColors.error,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                      ),
                      child: Column(
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: context.textTheme?.headlineSmall?.copyWith(
                              color: PiixColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (message != null) ...[
                            if (message!.contains(ConstantsDeprecated.boldOk))
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: getRichAlertMessages(
                                            message: message!)[0]),
                                    TextSpan(
                                      text: getRichAlertMessages(
                                          message: message!)[1],
                                      style: context.textTheme?.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text: getRichAlertMessages(
                                            message: message!)[2]),
                                  ],
                                  style: context.textTheme?.bodyMedium,
                                ),
                                textAlign: TextAlign.center,
                              )
                            else
                              Text(
                                message!,
                                textAlign: TextAlign.center,
                                style: context.textTheme?.bodyMedium,
                              ),
                            const SizedBox(height: 16),
                          ],
                          child ?? const SizedBox(),
                          if (child != null) const SizedBox(height: 16),
                          if (!uiBLoC.isLoading || !hasLoader)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed:
                                      onCancel ?? () => Navigator.pop(context),
                                  child: Text(
                                    cancelText.toUpperCase(),
                                    style: context.primaryTextTheme?.titleMedium
                                        ?.copyWith(
                                      color: PiixColors.active,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: isDisable
                                      ? null
                                      : onConfirm ??
                                          () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  child: Text(
                                    confirmText.toUpperCase(),
                                    style: context.primaryTextTheme?.titleMedium
                                        ?.copyWith(
                                      color: PiixColors.space,
                                    ),
                                  ),
                                ),
                              ],
                            ).padBottom(actionBottomPadding),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
