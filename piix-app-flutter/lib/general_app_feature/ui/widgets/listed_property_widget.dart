import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class ListedPropertyWidget extends StatelessWidget {
  const ListedPropertyWidget({
    Key? key,
    required this.keyText,
    required this.valueText,
    this.keyStyle,
    this.valueStyle,
  }) : super(key: key);

  final String keyText;
  final String valueText;
  final TextStyle? keyStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: keyText,
              style: keyStyle ?? context.textTheme?.bodyMedium,
            ),
            TextSpan(
              text: valueText,
              style: valueStyle ?? context.primaryTextTheme?.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
