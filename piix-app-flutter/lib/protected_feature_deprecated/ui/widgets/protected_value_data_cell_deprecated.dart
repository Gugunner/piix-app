import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a protected value cell from a label.
class ProtectedValueDataCellDeprecated extends StatelessWidget {
  const ProtectedValueDataCellDeprecated({Key? key, required this.label})
      : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme?.bodyMedium,
      textAlign: TextAlign.end,
    );
  }
}
