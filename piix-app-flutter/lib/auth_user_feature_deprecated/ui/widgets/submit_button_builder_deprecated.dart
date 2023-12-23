import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A simple button that takes 0.85% width of the parent widget.
@Deprecated('Use one of the AppButton widgets')
class SubmitButtonBuilderDeprecated extends StatelessWidget {
  const SubmitButtonBuilderDeprecated({
    super.key,
    required this.onPressed,
    required this.text,
    this.isElevatedButton = true,
    this.isLoading = false,
    this.height,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isElevatedButton;
  final bool isLoading;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isElevatedButton) {
          return SizedBox(
            width: context.width * 0.85,
            height: height ?? 40.w,
            child: ElevatedButton(
              onPressed: onPressed,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Builder(builder: (context) {
                if (isLoading) {
                  return const CircularProgressIndicator(
                    color: PiixColors.space,
                  );
                }
                return Text(
                  text.toUpperCase(),
                  style: context.primaryTextTheme?.titleMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                );
              }),
            ),
          );
        }
        return SizedBox(
          width: context.width * 0.85,
          height: 40.w,
          child: OutlinedButton(
            onPressed: onPressed,
            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  elevation: const MaterialStatePropertyAll<double>(0),
                ),
            child: Builder(builder: (context) {
              if (isLoading) {
                const CircularProgressIndicator(
                  color: PiixColors.secondary,
                );
              }
              return Text(
                text.toUpperCase(),
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.active,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
