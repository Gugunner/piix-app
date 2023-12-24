import 'package:flutter/material.dart';

@Deprecated('Implement a Clamp for each different Screen if needed')

///A widget for clam text scale factor in child widgets.
class ClampingScaleDeprecated extends StatelessWidget {
  const ClampingScaleDeprecated({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenQuery = MediaQuery.of(context);
    return MediaQuery(
        data: screenQuery.copyWith(
            textScaleFactor: screenQuery.textScaleFactor.clamp(1.0, 1.1)),
        child: child);
  }
}
