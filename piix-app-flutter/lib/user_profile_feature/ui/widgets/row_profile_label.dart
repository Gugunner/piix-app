import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

/// This widget is a main row display info for profile screen.
class RowProfileLabel extends StatelessWidget {
  const RowProfileLabel({Key? key, required this.label, this.trailingLabel})
      : super(key: key);

  final String label;
  final String? trailingLabel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: .1))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .07),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.textTheme?.bodyMedium,
              ),
            ),
            if (trailingLabel != null)
              Text(
                trailingLabel!,
                style: context.textTheme?.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
