import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/tag/tag_icon.dart';
import 'package:piix_mobile/widgets/tag/tag_label.dart';

class TagIconAndLabel extends StatelessWidget {
  const TagIconAndLabel({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.textDirection = TextDirection.ltr,
  });

  ///The value inside the [TagLabel].
  final String label;

  ///The color for both the [label] and the [icon].
  final Color color;

  ///The shape to show inside the [TagIcon].
  final IconData icon;

  ///Whether to show the [icon] as a prefix or suffix
  ///by default the value is [ltr] and shows the [icon]
  ///as a suffix.
  final TextDirection textDirection;

  ///The space between the label and the icon
  @protected
  double get _space => 4.w;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      textDirection: textDirection,
      children: [
        TagLabel(
          label: label,
          color: color,
          style: context.bodyMedium?.copyWith(
            color: color,
          ),
        ),
        SizedBox(
          width: _space,
        ),
        TagIcon(icon: icon, color: color),
      ],
    );
  }
}
