import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/widgets/store_text_button.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a title and a text button
///
class TitleWithButtonRowDeprecated extends StatelessWidget {
  const TitleWithButtonRowDeprecated(
      {super.key, required this.labelButton, required this.title, this.onTap});
  final String title;
  final String labelButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme?.headlineSmall,
        ),
        StoreTextButtonDeprecated(
          onTap: onTap,
          label: labelButton,
        )
      ],
    );
  }
}
