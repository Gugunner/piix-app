import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///The [Text] information inside a tag.
class TagLabel extends StatelessWidget {
  const TagLabel({
    super.key,
    required this.label,
    required this.color,
    this.style,
  }) : assert(label.length <= 45);

  ///The value inside the [Text].
  final String label;

  ///The color of the [Text].
  final Color color;

  ///An optional value to override default [TextStyle]
  final TextStyle? style;

  @protected
  int get _maxCharacters => 45;
  @protected
  int get _maxLines => 1;

  ///Returns an ellipsis at the end of the label
  ///if the label is longer than [_maxCharacters].
  String get _limitedLabel {
    if (label.length > _maxCharacters) {
      return '${label.substring(0, _maxCharacters)}...';
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _limitedLabel,
      style: style ??
          context.primaryTextTheme?.titleSmall?.copyWith(
            color: color,
          ),
      maxLines: _maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
