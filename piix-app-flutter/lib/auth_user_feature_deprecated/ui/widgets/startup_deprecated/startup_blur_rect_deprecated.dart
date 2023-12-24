import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Remove in 4.0')
class StartupBlurRectDeprecated extends StatelessWidget {
  const StartupBlurRectDeprecated({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 1.0),
        child: SizedBox(
          width: context.width,
          height: context.height * 0.35,
          child: child,
        ),
      ),
    );
  }
}
