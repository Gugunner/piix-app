import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A simple [Text] element that is adapted to be used as the message
///for a [Modal].
final class AppModalDescription extends StatelessWidget {
  const AppModalDescription(this.text, {super.key});
  ///The message value.
  final String text;
  ///The color of the [Text].
  Color get _color => PiixColors.infoDefault;
  ///The maximum number of lines the message of an
  ///[Modal] may have.
  int get _maxLines => 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Text(
        text,
        style: context.bodyMedium?.copyWith(color: _color),
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
