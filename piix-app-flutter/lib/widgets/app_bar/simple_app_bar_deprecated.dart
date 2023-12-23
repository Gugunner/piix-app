import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/widgets/app_bar/static_app_bar_deprecated.dart';

class SimpleAppBar extends StaticAppBar {
  const SimpleAppBar({
    super.key,
    super.simple,
    required super.title,
  }) : assert(title != null && title.length > 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaticAppBarBuilder(
      simple: true,
      title: title,
    );
  }
}
