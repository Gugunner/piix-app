import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class HeaderDescriptionRichTextWidget extends StatelessWidget {
  const HeaderDescriptionRichTextWidget({
    Key? key,
    required this.header,
    required this.text,
    this.headerStyle,
    this.textStyle,
  }) : super(key: key);

  final String header;
  final String text;
  final TextStyle? headerStyle;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: header,
        children: [
          TextSpan(
            text: text,
            style: headerStyle ?? context.textTheme?.bodyMedium,
          ),
        ],
        style: textStyle ?? context.primaryTextTheme?.titleMedium,
      ),
      textAlign: TextAlign.left,
    );
  }
}
