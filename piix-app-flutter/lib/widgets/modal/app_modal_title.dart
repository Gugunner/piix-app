import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A simple [Text] element that is adapted to be used as a header
///for a [Modal].
final class AppModalTitle extends StatelessWidget {
  const AppModalTitle(this.text, {super.key});
  ///The header value.
  final String text;

  ///The color of the [Text].
  Color get _color => PiixColors.primary;
  ///The maximum number of lines the header of an
  ///[Modal] may have.
  int get _maxLines => 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Text(
        text,
        style: context.headlineSmall?.copyWith(color: _color),
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
