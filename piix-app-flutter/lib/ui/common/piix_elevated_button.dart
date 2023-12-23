import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

/// Creates a custom elevated button with margin top and padding.
class PiixElevatedButton extends StatelessWidget {
  const PiixElevatedButton(
      {Key? key,
      this.height = kMinInteractiveDimension,
      required this.text,
      required this.onPressed,
      this.marginTop = 0,
      this.padding})
      : super(key: key);

  final double height;
  final String text;

  final double marginTop;
  final EdgeInsets? padding;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: context.primaryTextTheme?.titleMedium?.copyWith(
                color: PiixColors.space,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
