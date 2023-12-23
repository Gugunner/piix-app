import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A [Text] defined for the [title] property in the 
///[TitleAppBar].
final class AppBarTitle extends StatelessWidget {
  const AppBarTitle(this.text, {super.key});

  final String text;

  @protected
  ///Maximum lines before the [Text] overflows.
  int get _maxLines => 1;
  @protected
  ///The color of the [Text] value.
  Color get _color => PiixColors.space;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: _maxLines,
      overflow: TextOverflow.ellipsis,
      style: context.accentTextTheme?.displayMedium?.copyWith(
        color: _color,
      ),
      textAlign: TextAlign.center,
    );
  }
}
